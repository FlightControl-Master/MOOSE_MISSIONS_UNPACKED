---- Mission 'Demo' CAS  -- more like a hack together :)
--   Details:    Provides for 1 flight of on call close air support aircraft that will attack detected targets detected within search zones.
--               Will patrol on station until out of fuel and then another will take it's place. Flight will attempt to attack detected targets
--               for 20 minutes after engaging. Then will RTB and be replaced by another patrol.
--               Engage zone will be dynamically located to detected targets. 
--     
--               Makes use of the Moose DETECTION_AREAS and AI_CAS_ZONE functionality.
--               
--               Functionality is executed as a scheduled task that runs at 30 seconds and every 60 seconds after.
--               

-- *****************************
-- BLUE CAS SECTION 
-- ||||||||||||||||||||||||||||
-- vvvvvvvvvvvvvvvvvvvvvvvvvvvv

BlueCASGroupStatusTable = {}
BlueCASGroupTable = {}

MaxBlueCAS = math.random(4,8)
--**********************
 --Setup Blue Detection (Stykers in this case) can have 1 to many + predators whatever
 --- Just ensure group name in editor start with "Blue Recon"
 --*********************
ReconSetGroup = SET_GROUP:New():FilterPrefixes( "Blue Recon" ):FilterStart()
ReconDetection = DETECTION_AREAS:New( ReconSetGroup, 3000 ):FilterCategories( Unit.Category.GROUND_UNIT )  -- Group all detections within 3000 meters to one line in report

-- Define Search zones (Editor Trigger Zone (Radius))
BlueSearch1 = ZONE:New( "Blue Search 1" )
BlueSearch2 = ZONE:New( "Blue Search 2" )

-- make them the active search zones and start detecting
ReconDetection:SetAcceptZones( {BlueSearch2, BlueSearch1} )
ReconDetection:Start()  -- start detecting

--  Now setup for spawning CAS Groups -- (which are destroyed on landing)
BlueCASGroup = SPAWN:New("Blue CAS Group")
BlueCASGroup:InitGrouping(2)
BlueCASGroup:OnSpawnGroup(
  function(groupname)
      local SpawnedCASGroup = GROUP:FindByName(groupname.GroupName)
      local tempgroupname = groupname.GroupName
    
      --setup event handler 
      SpawnedCASGroup:HandleEvent( EVENTS.Land )
      --- @param self
      -- @param Core.Event#EVENTDATA EventData
        function SpawnedCASGroup:OnEventLand(EventData)
        
        --EventData.IniGroup:MessageToAll("Landed",15,"Land Event")
        --local CASGroup = BlueCASGroup:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold, 2000 )
        --local CASGroupName = CASGroup:GetName()
        for x=1, MaxBlueCAS do
            if BlueCASGroupTable[x] == EventData.IniGroupName then
                BlueCASGroupTable[x] = "Group Name"
                BlueCASGroupStatusTable[x] = "Avail"
                --CASEngageFlag[EventData.IniGroupName] = ""
                --CASEngagedTimer[EventData.IniGroupName] = 0
                break
            end
        end
        CASGroups[EventData.IniGroup] = nil
        EventData.IniGroup:Destroy()     
        end         
  end
  )

-- Do some setup to track state with CAS Flights and spawning
-- instantiate avail flag at mission start
for x=1, MaxBlueCAS do
    BlueCASGroupTable[x] = "Group Name"
    BlueCASGroupStatusTable[x] = "Avail" 
end

-- Instantiate Group Pointers for BlueCASManager
CASGroup1 = nil

-- Blue CAS Manager Function
-- Detects and triggers state changes in CASAir1 FSM
-- Basically check state every 60 seconds and take an action
function BlueCASManager()
    local detection = false
   
    -- Determine if flight avail or already assigned  
    if ActiveCASGroupName == "" then
      CASGroup1 = SpawnNewCASGroup()
    end
    --MessageToAll("CASGroup 1 = " .. CASGroup1:GetName(), 15)
    
    -- Display detection report if detected targets
    if ReconDetection.DetectedItemCount > 0 then
         detection = true
         bluedetectiontimer = timer.getTime() + 300   -- send RTB after 5 minutes of 0 contacts
         DetectionReport = ReconDetection:DetectedReportDetailed()
         MessageToAll(DetectionReport, 15)   
    else
        detection = false
    end
    -- Drive through CAS Groups
    for Group, Fsm in pairs(CASGroups) do
        local mystate = Fsm:GetState()
        local CASAir1 = Fsm
        
         
         local tempgroup = GROUP:FindByName( Group )
         local tempgroupname = tempgroup:GetName()
         local tempcoalition = tempgroup:GetCoalition()
         --MessageToAll( "GroupName = " .. tempgroupname .. " " .. mystate, 15)
          
              -- if patrolling engage if detected targets
              if mystate == "Patrolling" then
                 if engaged == false then 
                  if ReconDetection.DetectedItemCount > 0 then
                      Fsm:__Engage( 2, 350, 2500)
                       -- start engage Timer so we can stop after 20 minutes
                      CASEngagedTimer[tempgroupname] = timer.getTime() + 1500
                      CASEngageFlag[tempgroupname] = true
                      engaged = true
                  end
                 end
              end
                  -- if engaging then check timers to see when to stop
              if mystate == "Engaging" then
                  if timer.getTime() > CASEngagedTimer[tempgroupname] then
                      Fsm:__RTB(2)
                      engaged = false
                      CASEngagedTimer[tempgroupname] = 0
                      CASEngageFlag[tempgroupname] = false
                    
                  else
                     --MessageToAll( "Detection Timer: " .. bluedetectiontimer .. "  " .. timer.getTime(), 15)
                     -- if no targets keep looking for 5 minutes and rtb
                     if ReconDetection.DetectedItemCount == 0 then
                        if timer.getTime() > bluedetectiontimer then
                           Fsm:__RTB(2)
                           engaged = false
                           bluedetectiontimer = 0
                           CASEngagedTimer[tempgroupname] = 0
                           CASEngageFlag[tempgroupname] = false
                        
                        end
                     end  
                  end  -- end timer.getTime()
                end    
                
                -- here we launch a replacement as soon as flight hits returning state.
                -- possible via adding additional transition called 'Stage'  to AI_CAS_ZONE FSM (defined in spawn manager below)
                if mystate == "Returning" then
                          Fsm:__Stage(30)
                end
                -- if crashed then mark in status table dead and set ActiveCASGroupName to nil, which will spawn a new flight
                -- cleanup all other flags for active flight
                if mystate == "Crashed" then
                 ActiveCASGroupName = ""
                 for x=1, MaxBlueCAS do
                     local mytempgroup = BlueCASGroupTable[tempgroupname]
                     if mytempgroup == tempgroupname then
                          BlueCASGroupStatusTable[x] = "Dead"
                          break
                     end                
                 end
                 -- Cleanup current flags
                 engaged = false
                 detectiontimer = 0
                 detection = false
                 CASEngagedTimer[tempgroupname] = 0
                 CASEngageFlag[tempgroupname] = false
                 CASGroups[tempgroupname] = nil      
                end    
                
                if mystate == "Stopped" then
                    CASEngageFlag[tempgroupname] = false
                    CASEngagedTimer[tempgroupname] = 0
                    engaged = false
                    CASGroups[tempgroupname] = nil
                end
                -- continuing flags management
                if mystate == "Staged" then
                  ActiveCASGroupName = ""
                  Fsm:Stop()
                end
    end  
    
end


-- Setup for SpawnNewCASGroup Function
CASAirPointer = "CASAir1"
BlueCASGroupCounter = 0
ActiveCASGroupName = ""
CASGroups = {}
CASEngagedTimer = {}
CASEngageFlag = {}
engaged = false
BlueCASPatrolZone = ZONE:New( "Blue CAS Patrol Zone" )
BlueCASEngageZone = ZONE:New( "Blue CAS Engage Zone" )

-- Function SPAWN New CAS
-- Check that there are avail flights to use and if so Spawn one.
-- Assign spawned aircraft AI_CAS_ZONE
-- Set some flags for maintaining logic
function SpawnNewCASGroup()   
        MessageToAll("Assigning CAS", 15)
        -- get AI_CAS_ZONE Ready for some planes
        local CASAir1 = AI_CAS_ZONE:New( BlueCASPatrolZone, 5000, 5500, 250, 270, BlueCASEngageZone ) 
        
        -- look for 'avail' flight
        for x=1, MaxBlueCAS do
          local CASFlightStatus = BlueCASGroupStatusTable[x]
          if CASFlightStatus == "Avail" then
              MessageToAll("CAS Status = AVAIL", 15)
              --Spawn a CAS Flight
              CASGroup = BlueCASGroup:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Kobuleti ), SPAWN.Takeoff.Runway, 2000 )
              local CASGroupName = CASGroup:GetName()
              BlueCASGroupStatusTable[x] = "Inflight"   
              ActiveCASGroupName = "Inflight"
              CASAir1:SetControllable( CASGroup )
              CASAir1:__Start(30)
              CASGroups[CASGroupName] = CASAir1
              CASEngagedTimer[CASGroupName] = 0
              CASEngageFlag[CASGroupName] = false
              BlueCASGroupTable[x] = CASGroupName
              break
           else
              -- Will flip back to avail if CAS flight lands
              BlueCASGroupStatusTable[x] = "Dead"   
           end
        end   
       
         CASAir1:AddTransition( "Returning", "Stage", "Staged" )
         --- OnLeave Transition Handler for State Staged.
          -- @function [parent=#AI_PATROL_ZONE] OnLeaveStaged
          -- @param #AI_PATROL_ZONE self
          -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
          -- @param #string From The From State string.
          -- @param #string Event The Event string.
          -- @param #string To The To State string.
          -- @return #boolean Return false to cancel Transition.
          
          --- OnEnter Transition Handler for State Staged.
          -- @function [parent=#AI_PATROL_ZONE] OnEnterStaged
          -- @param #AI_PATROL_ZONE self
          -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
          -- @param #string From The From State string.
          -- @param #string Event The Event string.
          -- @param #string To The To State string.
          
          --- OnBefore Transition Handler for Event Stage.
          -- @function [parent=#AI_PATROL_ZONE] OnBeforeStage
          -- @param #AI_PATROL_ZONE self
          -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
          -- @param #string From The From State string.
          -- @param #string Event The Event string.
          -- @param #string To The To State string.
          -- @return #boolean Return false to cancel Transition.
          
          --- OnAfter Transition Handler for Event Stage.
          -- @function [parent=#AI_PATROL_ZONE] OnAfterStage
          -- @param #AI_PATROL_ZONE self
          -- @param Wrapper.Controllable#CONTROLLABLE Controllable The Controllable Object managed by the FSM.
          -- @param #string From The From State string.
          -- @param #string Event The Event string.
          -- @param #string To The To State string.
            
          --- Synchronous Event Trigger for Event Stage.
          -- @function [parent=#AI_PATROL_ZONE] Stage
          -- @param #AI_PATROL_ZONE self
          
          --- Asynchronous Event Trigger for Event Stage.
          -- @function [parent=#AI_PATROL_ZONE] __Stage
          -- @param #AI_PATROL_ZONE self
          -- @param #number Delay The delay in seconds.
          
              CASAir1:AddTransition("Stopped", "Stage", "Staged")
              CASAir1:AddTransition("Staged", "Route", "Patrolling")
              CASAir1:AddTransition("Staged", "Stop", "Stopped")  
   
         return CASGroup         
end

-- Triggered when detection happens
-- Also smokes red detected targets
function ReconDetection:OnAfterDetected( From, Event, To, DetectedUnits )
   for DetectedUnitID, DetectedUnit in pairs( DetectedUnits ) do
    local DetectedUnit = DetectedUnit -- Wrapper.Unit#UNIT
    local detectedunitvec2 = DetectedUnit:GetVec2()

--   --Move Engagement Zone to Contact from Red Recon
    BlueCASEngageZone:SetVec2(detectedunitvec2)
    DetectedUnit:SmokeRed()  
 end 
end

-- **************************************
--  End of Blue CAS
-- *************************************

  SchedulerObject, SchedulerID = SCHEDULER:New( nil, BlueCASManager, {}, 30, 60 )
