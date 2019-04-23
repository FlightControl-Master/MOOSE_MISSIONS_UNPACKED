-- At startup of the overall mission, we spawn 10 possible escort planes in "Uncontrolled" state.

EscortSpawn = SPAWN
  :NewWithAlias( "Red A2G Escort Template", "Red A2G Escort AI" )
  :InitUnControlled( true )
  
for ID = 1, 10 do
  EscortSpawn:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
end

EscortSpawn:InitUnControlled( false )
EscortSpawn:SetSpawnIndex() -- Reset the spawning. So new planes will be respawned from the beginning.


--- @type EscortTable
-- @field Core.Set#SET_GROUP Set
-- @field AI.AI_Escort#ESCORT Escort

--- @list<#EscortTable>
Escort = {}

EscortClients = SET_CLIENT:New():FilterPrefixes( "Red A2G Pilot" ):FilterStart()



function SpawnNewEscorts( EscortUnit )
  env.info("new escort")
  local ID = EscortUnit:GetID()
  Escort[ID] = Escort[ID] or {} 
  Escort[ID].Set = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Red A2G Escort AI" ):FilterCrashes():FilterDeads()
  
  -- Spawn a new escort
  local EscortGroup = EscortSpawn:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  Escort[ID].Set:AddGroup( EscortGroup )
  
  -- Now setup the AI_ESCORT to make the new spawned escort follow the EscortUnit.
  Escort[ID].Escort = AI_ESCORT:New( EscortUnit, Escort[ID].Set, "Escort A2G", "Briefing" ) 
  local EscortObject = Escort[ID].Escort -- AI.AI_Escort#AI_ESCORT
  EscortObject:Menus()
end

-- We setup a process where a new spawn of a client plane will trigger a menu option 
-- to request an escort from the pool of escorts.

EventHandlerPlayer = EVENTHANDLER:New()

EventHandlerPlayer:HandleEvent( EVENTS.Birth )


--- @param Core.Event#EVENT self
-- @param Core.Event#EVENTDATA EventData
function EventHandlerPlayer:OnEventBirth( EventData )

  local EventUnit = EventData.IniUnit
  local EventGroup = EventUnit:GetGroup()
  
  if EscortClients:FindClient( EventUnit:GetName() ) then
  
    EventGroup.MenuRequestEscort = MENU_GROUP_COMMAND:New( EventGroup, "Request A2G Escort", nil, 
      function( EventUnit )
        env.info("call")
        local ID = EventUnit:GetID()
        if Escort[ID] then
          
          -- There is already an escort group set spawned previously. Let's check if the escorts are still alive.
          local EscortGroupSet = Escort[ID].Set
          local OneEscortAlive = false
          EscortGroupSet:ForEachGroupAlive( 
            function( EscortGroup )
              OneEscortAlive = true
            end
          )
          
          if OneEscortAlive == false then
            SpawnNewEscorts( EventUnit )
          end
        
        else
          SpawnNewEscorts( EventUnit )
          
        end

      Escort[ID].Escort:FormationTrail( 50, 100, 50)
      Escort[ID].Escort:__Start( 5 )
       
      end, EventUnit
      )
  end
end

EventHandlerPlayer:HandleEvent( EVENTS.PlayerLeaveUnit )

--- @param Core.Event#EVENT self
-- @param Core.Event#EVENTDATA EventData
function EventHandlerPlayer:OnEventPlayerLeaveUnit( EventData )

  local EventUnit = EventData.IniUnit
  local EventGroup = EventUnit:GetGroup()
  
  if EscortClients:FindClient( EventUnit:GetName() ) then
  
    local ID = EventUnit:GetID()
    local EscortGroupSet = Escort[ID].Set -- Core.Set#SET_GROUP
    EscortGroupSet:ForEachGroupAlive( 
      function( EscortGroup )
        EscortGroup:Destroy()
      end
    )

    EscortGroupSet:Clear()
    
  end
end

