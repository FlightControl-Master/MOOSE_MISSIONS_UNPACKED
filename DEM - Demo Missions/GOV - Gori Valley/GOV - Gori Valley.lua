--- Gori Valley designed with the MOOSE framework for DCS World.
-- Author: FlightControl

-- Define the headquarters.

NATO_HQ = COMMANDCENTER:New( GROUP:FindByName( "HQ NATO Gori" ), "Gori" )
CCCP_HQ = COMMANDCENTER:New( GROUP:FindByName( "HQ CCCP Tskinvali" ), "Tskinvali" )


-- Define the scoring object.

Score = SCORING:New( "Gori Valley" )

Score:SetScaleDestroyScore( 40 )
Score:SetScaleDestroyPenalty( 80 )
Score:SetFratricide( 80 )
Score:SetMessagesHit( false )


--- Cargo Dispatching

do

  local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
  local SetHelicopter = SET_GROUP:New():FilterPrefixes( "US CH-47D@RAMP Troop Deployment" ):FilterStart()
  local SetDeployZones = SET_ZONE:New():FilterPrefixes( "US Troops Landing Zone" ):FilterStart()
  
  NATO_AI_Cargo_Dispatcher_Helicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, SetDeployZones ) 
  NATO_AI_Cargo_Dispatcher_Helicopter:SetPickupRadius( 50, 25 )
  NATO_AI_Cargo_Dispatcher_Helicopter:SetDeployRadius( 1000, 500 )
  NATO_AI_Cargo_Dispatcher_Helicopter:Start()

end

-- CCCP COALITION UNITS

-- Russian helicopters engaging the battle field in Gori Valley
Spawn_RU_KA50 = SPAWN
  :New( "RU KA-50@HOT-Patriot Attack" )
  :InitLimit( 1, 24 ) 
  :InitRandomizeRoute( 1, 1, 8000 )
  :InitCleanUp( 180 )
  :SpawnScheduled( 1200, 0.2 )

-- Russian ground troops attacking Gori Valley
Spawn_RU_Troops =
  { 'RU Attack Gori 1',
    'RU Attack Gori 2',
    'RU Attack Gori 3',
    'RU Attack Gori 4',
    'RU Attack Gori 5',
    'RU Attack Gori 6',
    'RU Attack Gori 7',
    'RU Attack Gori 8',
    'RU Attack Gori 9',
    'RU Attack Gori 10'
  }


Spawn_RU_Troops_Left = SPAWN
  :New( "RU Attack Gori Left" )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_RU_Troops )
  :InitRandomizeRoute( 1, 1, 2000 )
  --:InitArray( 349, 30, 20, 6 * 20 )
  :SpawnScheduled( 120, 1 )

Spawn_RU_Troops_Middle = SPAWN
  :New( "RU Attack Gori Middle" )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_RU_Troops )
  :InitRandomizeRoute( 1, 1, 2000 )
  --:InitArray( 260, 50, 20, 6 * 20 )
  :SpawnScheduled( 120, 1 )

Spawn_RU_Troops_Right = SPAWN
  :New( "RU Attack Gori Right" )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_RU_Troops )
  :InitRandomizeRoute( 1, 1, 2000 )
  --:InitArray( 238, 50, 20, 6 * 20 )
  :SpawnScheduled( 120, 1 )
  

-- NATO Tank Platoons invading Tskinvali

Spawn_US_Platoon =
  { 'US Tank Platoon 1',
    'US Tank Platoon 2',
    'US Tank Platoon 3',
    'US Tank Platoon 4',
    'US Tank Platoon 5',
    'US Tank Platoon 6',
    'US Tank Platoon 7',
    'US Tank Platoon 8',
    'US Tank Platoon 9',
    'US Tank Platoon 10',
    'US Tank Platoon 11',
    'US Tank Platoon 12',
    'US Tank Platoon 13'
  }

Spawn_US_Platoon_Left = SPAWN
  :New( 'US Tank Platoon Left' )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_US_Platoon )
  :InitRandomizeRoute( 3, 1, 2000 )
  --:InitArray( 76, 20, 15, 15*6  )
  :SpawnScheduled( 120, 1 )

Spawn_US_Platoon_Middle = SPAWN
  :New( 'US Tank Platoon Middle' )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_US_Platoon )
  :InitRandomizeRoute( 3, 1, 2000 )
  --:InitArray( 160, 20, 15, 15*6  )
  :SpawnScheduled( 120, 1 )

Spawn_US_Platoon_Right = SPAWN
  :New( 'US Tank Platoon Right' )
  :InitLimit( 15, 40 )
  :InitRandomizeTemplate( Spawn_US_Platoon )
  :InitRandomizeRoute( 1, 1, 2000 )
  --:InitArray( 90, 20, 15, 15*6 )
  :SpawnScheduled( 120, 1 )
  


do -- NATO Air Patrol Support Mission


  local NATO_S1 = MISSION
    :New( NATO_HQ, "Intercept Intruders","Support","Intercept any intruders invading airspace from the North!", coalition.side.BLUE )
    :AddScoring( Score )

  -- Define the Recce groups that will detect the upcoming ground forces.
  local NATO_S1_EWR = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes( "AI NATO EWR A2A" ):FilterStart()
  
  -- Define the detection method, we'll use here AREA detection.
  local NATO_S1_EWR_Areas = DETECTION_AREAS:New( NATO_S1_EWR, 20000 )
  NATO_S1_EWR_Areas:SetFriendliesRange( 80000 )
  NATO_S1_EWR_Areas:SetRefreshTimeInterval( 30 )
  NATO_S1_EWR_Areas:SetAcceptRange( 250000 ) -- Only report targets within 250km.
  
  local NATO_S1_Task = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "S1 NATO Air Patrol" ):FilterStart()
  
  -- Define the Task dispatcher that will define the tasks based on the detected targets.
  NATO_S1_A2A = TASK_A2A_DISPATCHER:New( NATO_S1, NATO_S1_Task, NATO_S1_EWR_Areas )


  local NATO_AI_A2A_Support_East = { 
    "AI NATO Air Support East F-16A A",
    "AI NATO Air Support East F-16A B",
    } 

  local NATO_AI_A2A_Support_West = { 
    "AI NATO Air Support West F-16A A",
    "AI NATO Air Support West F-16A B",
    }

  NATO_AI_A2A_Dispatcher = AI_A2A_DISPATCHER:New( NATO_S1_EWR_Areas )
  
  NATO_AI_A2A_Dispatcher:SetTacticalDisplay( false )
  
  NATO_AI_A2A_Dispatcher:SetEngageRadius( 80000 )
  NATO_AI_A2A_Dispatcher:SetGciRadius( 140000 )
  
  NATO_AI_A2A_Dispatcher:SetSquadron( "Kutaisi", AIRBASE.Caucasus.Kutaisi, NATO_AI_A2A_Support_West, 20 )
  NATO_AI_A2A_Dispatcher:SetSquadronCap( "Kutaisi", ZONE_POLYGON:New( "NATO CAP EAST", GROUP:FindByName( "NATO CAP EAST") ), 4000, 8000, 450, 600, 800, 1200, "BARO" )
  NATO_AI_A2A_Dispatcher:SetSquadronCapInterval( "Kutaisi", 2, 180, 300 )
  
  NATO_AI_A2A_Dispatcher:SetSquadronGci( "Kutaisi", 800, 1200 )

  NATO_AI_A2A_Dispatcher:SetSquadron( "Vaziani", AIRBASE.Caucasus.Vaziani, NATO_AI_A2A_Support_East, 20 )
  NATO_AI_A2A_Dispatcher:SetSquadronCap( "Vaziani", ZONE_POLYGON:New( "NATO CAP WEST", GROUP:FindByName( "NATO CAP WEST" ) ), 4000, 8000, 500, 700, 800, 1200, "BARO" )
  NATO_AI_A2A_Dispatcher:SetSquadronCapInterval( "Vaziani", 2, 180, 300 )
  
  NATO_AI_A2A_Dispatcher:SetSquadronGci( "Vaziani", 800, 1200 )

end


do -- NATO Mission 1


  local NATO_M1 = MISSION
    :New( NATO_HQ, "Destroy SAM-6","Primary","Destroy SAM-6 batteries", coalition.side.BLUE )
    :AddScoring( Score )
    

  -- Define the Recce groups that will detect the upcoming ground forces.
  local NATO_M1_RecceSet = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes( "M1 NATO Recce" ):FilterStart()
  
  NATO_M1_Spawn_Reaper = SPAWN
    :New( "M1 NATO Recce Reaper" )
    :InitLimit( 1, 5 )
    :SpawnScheduled( 300, 0 )

  
  NATO_M1_ReccePatrolArray = {}
  NATO_M1_RecceSpawn_US = SPAWN
    :New( "M1 NATO Recce AH-64" )
    :InitLimit( 2, 10 )
    :SpawnScheduled( 60, 0.4 )
    :InitCleanUp( 300 )
    :OnSpawnGroup(
      function( SpawnGroup )
        NATO_M1_RecceSpawn_US:E( SpawnGroup.ControllableName )
        local M1_ReccePatrolZoneWP = GROUP:FindByName( "M1 US Patrol Zone@ZONE" )
        local M1_ReccePatrolZone = ZONE_POLYGON:New( "PatrolZone", M1_ReccePatrolZoneWP )
        local M1_ReccePatrol = AI_PATROL_ZONE:New( M1_ReccePatrolZone, 30, 50, 50, 100 )
        NATO_M1_ReccePatrolArray[#NATO_M1_ReccePatrolArray+1] = M1_ReccePatrol
        
        M1_ReccePatrol:SetControllable( SpawnGroup )
        M1_ReccePatrol:__Start( 30 ) -- It takes a bit of time for the Recce to start
      end
     )
  
  
  -- Define the detection method, we'll use here AREA detection.
  local NATO_M1_DetectionAreas = DETECTION_AREAS:New( NATO_M1_RecceSet, 1000 )
  --M1_DetectionAreas:BoundDetectedZones()
  
  local NATO_M1_Attack = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "M1 NATO Attack" ):FilterStart()
  
  -- Define the Task dispatcher that will define the tasks based on the detected targets.
  NATO_M1_Task_A2G_Dispatcher = TASK_A2G_DISPATCHER:New( NATO_M1, NATO_M1_Attack, NATO_M1_DetectionAreas )

  NATO_M1_Designate = DESIGNATE:New( NATO_HQ, NATO_M1_DetectionAreas, NATO_M1_Attack, NATO_M1 )


end


do -- NATO Transport Task Engineers

  local NATO_M4_Patriots = MISSION
    :New( NATO_HQ, 
          "Engineers Patriots", 
          "Operational", 
          "Transport 3 engineering teams to three strategical Patriot launch sites. " ..
            "The launch sites are not yet complete and need some special launch codes to be delivered. " ..
            "The engineers have the knowledge to install these launch codes. ",
          coalition.side.BLUE )

  local NATO_M4_HeloSetGroup = SET_GROUP:New():FilterPrefixes( "M4 NATO Patriot Transport" ):FilterStart()

  local NATO_M4_SetCargo = SET_CARGO:New():FilterTypes( { "Patriot Engineers" } ):FilterStart()

  local EngineersCargo1 = CARGO_GROUP:New( GROUP:FindByName( "M4 NATO Engineers Bear" ), "Patriot Engineers", "Team Bear", 500 ):RespawnOnDestroyed(true)
  local EngineersCargo2 = CARGO_GROUP:New( GROUP:FindByName( "M4 NATO Engineers Moose" ), "Patriot Engineers", "Team Moose", 500 ):RespawnOnDestroyed(true)
  local EngineersCargo3 = CARGO_GROUP:New( GROUP:FindByName( "M4 NATO Engineers Falcon" ), "Patriot Engineers", "Team Falcon", 500 ):RespawnOnDestroyed(true)


  -- These are the groups of the SA-6 batteries.
  local Patriots1 = GROUP:FindByName( "M4 NATO Patriot North" ):SetAIOff()
  local Patriots2 = GROUP:FindByName( "M4 NATO Patriot West" ):SetAIOff()
  local Patriots3 = GROUP:FindByName( "M4 NATO Patriot East" ):SetAIOff()
  
  -- Each SA-6 battery has a zone of type ZONE_GROUP. That makes these zone moveable as they drive around the battle field!
  local Zone_Patriots1 = ZONE_GROUP:New( "Patriots North", Patriots1, 600 )
  local Zone_Patriots2 = ZONE_GROUP:New( "Patriots West", Patriots2, 600 )
  local Zone_Patriots3 = ZONE_GROUP:New( "Patriots East", Patriots3, 600 ) 

  NATO_M4_Cargo_Transport_Dispatcher = TASK_CARGO_DISPATCHER:New( NATO_M4_Patriots, NATO_M4_HeloSetGroup )

  local NATO_M4_Cargo_Transport_TaskName = NATO_M4_Cargo_Transport_Dispatcher:AddTransportTask( 
    "Activate Patriot Batteries",
    NATO_M4_SetCargo,
    "Pickup Engineers Alpha, Beta and Gamma from their current location, and drop them near the Patriot launchers. " ..
      "Deployment zones have been defined at each Patriot location."
  ) 
  
  NATO_M4_Cargo_Transport_Dispatcher:SetTransportDeployZones( NATO_M4_Cargo_Transport_TaskName, { Zone_Patriots1, Zone_Patriots2, Zone_Patriots3 } )
  
  local NATO_M4_Cargo_Transport_Task = NATO_M4_Cargo_Transport_Dispatcher:GetTransportTask( NATO_M4_Cargo_Transport_TaskName )
  

  --- OnAfter Transition Handler for Event CargoDeployed.
  -- This event will handle after deployment the activation of the SA-6 site.
  -- @function [parent=#TASK_CARGO_TRANSPORT] OnAfterCargoDeployed
  -- @param Tasking.Task_CARGO#TASK_CARGO_TRANSPORT self
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  -- @param Wrapper.Unit#UNIT TaskUnit The Unit (Client) that Deployed the cargo. You can use this to retrieve the PlayerName etc.
  -- @param Core.Cargo#CARGO Cargo The Cargo that got PickedUp by the TaskUnit. You can use this to check Cargo Status.
  -- @param Core.Zone#ZONE DeployZone The zone where the Cargo got Deployed or UnBoarded.
  function NATO_M4_Cargo_Transport_Task:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
    self:E( { From, Event, To, TaskUnit, Cargo, DeployZone } )
  
    local DeployZoneName = DeployZone:GetName()
    local CargoName = Cargo:GetName()
  
  
    NATO_HQ:MessageToCoalition( 
      string.format( "Engineers %s are successfully transported to patriot site %s.", 
                     CargoName, 
                     DeployZoneName 
                   ) 
    )
    
    if DeployZoneName == Zone_Patriots1:GetName() then
      if Patriots1 and not Patriots1:IsAlive() then
        local Template = Patriots1:GetTemplate()
        Template.lateActivation = false
        Template.Visible = false
        Patriots1:Respawn(Template)
        --Patriots1:SetAIOn()
      end
    end

    if DeployZoneName == Zone_Patriots2:GetName() then
      if Patriots2 and not Patriots2:IsAlive() then
        local Template = Patriots2:GetTemplate()
        Template.lateActivation = false
        Template.Visible = false
        Patriots2:Respawn(Template)
        --Patriots2:SetAIOn()
      end
    end

    if DeployZoneName == Zone_Patriots3:GetName() then
      if Patriots3 and not Patriots3:IsAlive() then
        local Template = Patriots3:GetTemplate()
        Template.lateActivation = false
        Template.Visible = false
        Patriots3:Respawn(Template)
        --Patriots3:SetAIOn()
      end
    end
    
    if self:IsAllCargoTransported() then
      self:Success()
      NATO_M4_Patriots:Complete()
    end
  end

end






do -- CCCP Air Patrol Support Functions


  local CCCP_S1 = MISSION
    :New( CCCP_HQ, "Provide Air Support","Support","Intercept any bogeys invading airspace from the South or East!", coalition.side.RED )
    :AddScoring( Score )

  -- Define the Recce groups that will detect the upcoming A2A intruders.
  local CCCP_S1_EWR_Groups = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes( "AI CCCP EWR" ):FilterStart()
  
  -- Define the detection method, we'll use here AREA detection.
  local CCCP_S1_EWR_Areas = DETECTION_AREAS:New( CCCP_S1_EWR_Groups, 30000 )
  CCCP_S1_EWR_Areas:SetFriendliesRange( 80000 )
  CCCP_S1_EWR_Areas:SetAcceptRange( 250000 ) -- Only report targets that are within 250km from detection.
  --M1_DetectionAreas_US:BoundDetectedZones()
  
  local CCCP_S1_SupportGroups = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes( "S1 CCCP Air Defense" ):FilterStart()
  
  -- Define the Task dispatcher that will define the tasks based on the detected targets.
  CCCP_S1_A2A_Task_Dispatcher = TASK_A2A_DISPATCHER:New( CCCP_S1, CCCP_S1_SupportGroups, CCCP_S1_EWR_Areas )


  CCCP_AI_A2A_Support_SU_27 = { 
    "AI CCCP Air Support SU-27 A", 
    "AI CCCP Air Support SU-27 B", 
    "AI CCCP Air Support SU-27 C", 
    "AI CCCP Air Support SU-27 D" 
    } 

  CCCP_AI_A2A_Support_MIG_29S = { 
    "AI CCCP Air Support MIG-29S A",
    "AI CCCP Air Support MIG-29S B",
    "AI CCCP Air Support MIG-29S C",
    "AI CCCP Air Support MIG-29S D"
    }
  

  CCCP_AI_A2A_Dispatcher = AI_A2A_DISPATCHER:New( CCCP_S1_EWR_Areas )
  
  CCCP_AI_A2A_Dispatcher:SetTacticalDisplay( false )
  
  CCCP_AI_A2A_Dispatcher:SetEngageRadius( 80000 )
  CCCP_AI_A2A_Dispatcher:SetGciRadius( 100000 )
  
  -- Beslan
  CCCP_AI_A2A_Dispatcher:SetSquadron( "Beslan", AIRBASE.Caucasus.Beslan, CCCP_AI_A2A_Support_SU_27, 20 )
  CCCP_AI_A2A_Dispatcher:SetSquadronCap( "Beslan", ZONE_POLYGON:New( "CCCP CAP EAST", GROUP:FindByName( "CCCP CAP EAST") ), 4000, 8000, 450, 600, 800, 1200, "BARO" )
  CCCP_AI_A2A_Dispatcher:SetSquadronCapInterval( "Beslan", 2, 180, 300 )
  CCCP_AI_A2A_Dispatcher:SetSquadronTakeoffInAir( "Beslan" )
  
  -- Mozdok
  CCCP_AI_A2A_Dispatcher:SetSquadron( "Mozdok", AIRBASE.Caucasus.Mozdok, CCCP_AI_A2A_Support_SU_27, 20 )
  CCCP_AI_A2A_Dispatcher:SetSquadronGci( "Mozdok", 800, 1200 )

  CCCP_AI_A2A_Dispatcher:SetSquadron( "Nalchik", AIRBASE.Caucasus.Nalchik, CCCP_AI_A2A_Support_MIG_29S, 20 )
  CCCP_AI_A2A_Dispatcher:SetSquadronCap( "Nalchik", ZONE_POLYGON:New( "CCCP CAP WEST", GROUP:FindByName( "CCCP CAP WEST" ) ), 4000, 8000, 500, 700, 800, 1200, "BARO" )
  CCCP_AI_A2A_Dispatcher:SetSquadronCapInterval( "Nalchik", 2, 180, 300 )
  CCCP_AI_A2A_Dispatcher:SetSquadronGci( "Nalchik", 800, 1200 )

end

do -- CCCP Destroy Patriots

  local CCCP_M1 = MISSION
    :New( CCCP_HQ, 
          "Destroy Patriots",
          "Primary",
          "Destroy Patriot batteries.", 
          coalition.side.RED
        )
    :AddScoring( Score )

  -- Define the Recce groups that will detect the upcoming ground forces.
  local CCCP_M1_RecceSet = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "M1 CCCP Recce" ):FilterStart()

  CCCP_M1_Spawn_SU25MR = SPAWN
    :New( "M1 CCCP Recce SU-25MR" )
    :InitLimit( 1, 5 )
    :SpawnScheduled( 300, 0.5 )

  
  CCCP_M1_ReccePatrolArray = {}
  CCCP_M1_RecceSpawn = SPAWN
    :New( "M1 CCCP Recce MI-28N" )
    :InitLimit( 2, 10 )
    :SpawnScheduled( 60, 0.4 )
    :OnSpawnGroup(
      function( SpawnGroup )
        local M1_ReccePatrolZoneWP = GROUP:FindByName( "M1 RU Patrol Zone@ZONE" )
        local M1_ReccePatrolZone = ZONE_POLYGON:New( "PatrolZone", M1_ReccePatrolZoneWP )
        local M1_ReccePatrol = AI_PATROL_ZONE:New( M1_ReccePatrolZone, 30, 50, 50, 100 )
        CCCP_M1_ReccePatrolArray[#CCCP_M1_ReccePatrolArray+1] = M1_ReccePatrol
        
        M1_ReccePatrol:SetControllable( SpawnGroup )
        M1_ReccePatrol:__Start( 20 ) -- It takes a bit of time for the Recce to start
      end
     )
  
  
  -- Define the detection method, we'll use here AREA detection.
  local CCCP_M1_DetectionAreas = DETECTION_AREAS:New( CCCP_M1_RecceSet, 1000 )
  --M1_DetectionAreas_US:BoundDetectedZones()
  
  local CCCP_M1_Attack = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "M1 CCCP Attack" ):FilterStart()
  CCCP_M1_Attack:Flush()
  
  -- Define the Task dispatcher that will define the tasks based on the detected targets.
  CCCP_M1_Task_A2G_Dispatcher = TASK_A2G_DISPATCHER:New( CCCP_M1, CCCP_M1_Attack, CCCP_M1_DetectionAreas )

end

do -- CCCP Transport Task Engineers

  local CCCP_M4_SA6 = MISSION
    :New( CCCP_HQ, 
          "Engineers SA-6", 
          "Operational", 
          "Transport 3 engineering teams to three strategical SA-6 launch sites. " ..
            "The launch sites are not yet complete and need some special launch codes to be delivered. " ..
            "The engineers have the knowledge to install these launch codes. ",
          coalition.side.RED )
    :AddScoring( Score ) 

  local CCCP_M4_HeloSetGroup = SET_GROUP:New():FilterPrefixes( "M4 CCCP SA6 Transport" ):FilterStart()

  local CCCP_M4_SA6_SetCargo = SET_CARGO:New():FilterTypes( { "SA6 Engineers" } ):FilterStart()

  local EngineersCargoAlpha = CARGO_GROUP:New( GROUP:FindByName( "M4 CCCP Engineers Alpha" ), "SA6 Engineers", "Team Alpha", 500 )
  local EngineersCargoBeta = CARGO_GROUP:New( GROUP:FindByName( "M4 CCCP Engineers Beta" ), "SA6 Engineers", "Team Beta", 500 )
  local EngineersCargoGamma = CARGO_GROUP:New( GROUP:FindByName( "M4 CCCP Engineers Gamma" ), "SA6 Engineers", "Team Gamma", 500 )

  CCCP_M4_Cargo_Transport_Dispatcher = TASK_CARGO_DISPATCHER:New( CCCP_M4_SA6, CCCP_M4_HeloSetGroup )

  local CCCP_M4_Cargo_Transport_TaskName = CCCP_M4_Cargo_Transport_Dispatcher:AddTransportTask( 
    "Transport SA-6 Engineers", 
    CCCP_M4_SA6_SetCargo, 
    "Pickup Engineers Alpha, Beta and Gamma from their current location, and drop them near the SA-6 launchers. " ..
      "Deployment zones have been defined at each SA-6 location." 
  )
    
  -- These are the groups of the SA-6 batteries.
  local SA6_1 = GROUP:FindByName( "M4 CCCP SA6 Kub Moskva" ):SetAIOff()
  local SA6_2 = GROUP:FindByName( "M4 CCCP SA6 Kub Niznij" ):SetAIOff()
  local SA6_3 = GROUP:FindByName( "M4 CCCP SA6 Kub Yaroslavl" ):SetAIOff()
  
  -- Each SA-6 battery has a zone of type ZONE_GROUP. That makes these zone moveable as they drive around the battle field!
  local Zone_SA6_1 = ZONE_GROUP:New( "SA6 Moskva", SA6_1, 500 )
  local Zone_SA6_2 = ZONE_GROUP:New( "SA6 Niznij", SA6_2, 500 )
  local Zone_SA6_3 = ZONE_GROUP:New( "SA6 Yaroslavl", SA6_3, 500 ) 
  
  CCCP_M4_Cargo_Transport_Dispatcher:SetTransportDeployZones( CCCP_M4_Cargo_Transport_TaskName, { Zone_SA6_1, Zone_SA6_2, Zone_SA6_3 } )
  local CCCP_M4_Cargo_Transport_Task = CCCP_M4_Cargo_Transport_Dispatcher:GetTransportTask( CCCP_M4_Cargo_Transport_TaskName )

  --- OnAfter Transition Handler for Event CargoDeployed.
  -- This event will handle after deployment the activation of the SA-6 site.
  -- @function [parent=#TASK_CARGO_TRANSPORT] OnAfterCargoDeployed
  -- @param Tasking.Task_CARGO#TASK_CARGO_TRANSPORT self
  -- @param #string From The From State string.
  -- @param #string Event The Event string.
  -- @param #string To The To State string.
  -- @param Wrapper.Unit#UNIT TaskUnit The Unit (Client) that Deployed the cargo. You can use this to retrieve the PlayerName etc.
  -- @param Core.Cargo#CARGO Cargo The Cargo that got PickedUp by the TaskUnit. You can use this to check Cargo Status.
  -- @param Core.Zone#ZONE DeployZone The zone where the Cargo got Deployed or UnBoarded.
  function CCCP_M4_Cargo_Transport_Task:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  
    self:E( { From, Event, To, TaskUnit:GetName(), Cargo:GetName(), DeployZone:GetName() } )
  
    local DeployZoneName = DeployZone:GetName()
    local CargoName = Cargo:GetName()
  
  
    CCCP_HQ:MessageToCoalition( 
      string.format( "Engineers %s are successfully transported to SA-6 site %s.", 
                     CargoName, 
                     DeployZoneName 
                   ) 
    )
    
    if DeployZoneName == Zone_SA6_1:GetName() then
      if SA6_1 and not SA6_1:IsAlive() then
        self:E( { GroupActivated = SA6_1:GetName() } )
          local Template = SA6_1:GetTemplate()
          Template.lateActivation = false
          Template.Visible = false
          SA6_1:Respawn(Template)
        --SA6_1:SetAIOn()
      end
    end

    if DeployZoneName == Zone_SA6_2:GetName() then
      if SA6_2 and not SA6_2:IsAlive() then
        self:E( { GroupActivated = SA6_2:GetName() } )
          local Template = SA6_2:GetTemplate()
          Template.lateActivation = false
          Template.Visible = false
          SA6_2:Respawn(Template)
        --SA6_2:SetAIOn()
      end
    end

    if DeployZoneName == Zone_SA6_3:GetName() then
      if SA6_3 and not SA6_3:IsAlive() then
        self:E( { GroupActivated = SA6_3:GetName() } )
          local Template = SA6_3:GetTemplate()
          Template.lateActivation = false
          Template.Visible = false
          SA6_3:Respawn(Template)
        --SA6_3:SetAIOn()
      end
    end
    
    if self:IsAllCargoTransported() then
      self:Success()
      CCCP_M4_SA6:Complete()
    end
  end

end

MissileTrainer = MISSILETRAINER:New( 100, "Helps with missile tracking" )



