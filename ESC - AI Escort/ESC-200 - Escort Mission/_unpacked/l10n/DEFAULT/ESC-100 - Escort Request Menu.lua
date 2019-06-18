-- At startup of the overall mission, we spawn 10 possible escort planes in "Uncontrolled" state.

EscortSpawnA2A = SPAWN
  :NewWithAlias( "Red A2A Escort Template", "Red A2A Escort AI" )
  :InitLimit( 10, 10 )
  
  
EscortSpawnA2G = SPAWN
  :NewWithAlias( "Red A2G Escort Template", "Red A2G Escort AI" )
  :InitLimit( 10, 10 )
  
  
EscortSpawnA2A:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), AIRBASE.TerminalType.OpenBig )
EscortSpawnA2A:SetSpawnIndex()

EscortSpawnA2G:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), AIRBASE.TerminalType.OpenBig )
EscortSpawnA2G:SetSpawnIndex()

--- @type EscortTable
-- @field Core.Set#SET_GROUP Set
-- @field AI.AI_Escort#ESCORT Escort

--- @list<#EscortTable>
Escort = {}

EscortClients = SET_CLIENT:New():FilterPrefixes( "Red A2G Pilot" ):FilterStart()



function SpawnNewEscortsA2A( EscortUnit )
  env.info("new escort A2A")
  local ID = EscortUnit:GetID()
  local EscortGroup = EscortUnit:GetGroup()

  Escort[ID] = Escort[ID] or {} 
  local EscortSet = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Red A2A Escort AI" ):FilterCrashes():FilterDeads()
  
  -- Spawn new escorts
  local EscortGroup = EscortSpawnA2A:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  EscortSet:AddGroup( EscortGroup )

  local EscortGroup = EscortSpawnA2A:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  EscortSet:AddGroup( EscortGroup )
  
  -- Now setup the AI_ESCORT to make the new spawned escort follow the EscortUnit.
  Escort[ID]["A2A"] = AI_ESCORT:New( EscortUnit, EscortSet, "Escort A2A", "Briefing" ) 
  local EscortObject = Escort[ID]["A2A"] -- AI.AI_Escort#AI_ESCORT
  EscortObject:Menus()
  EscortObject:FormationTrail( 50, 50, 0 )
  EscortObject:__Start( 5 )
  
  EscortGroup.MenuRequestEscortA2A:Remove()
end

function SpawnNewEscortsA2G( EscortUnit )
  env.info("new escort A2G")
  local ID = EscortUnit:GetID()
  local EscortGroup = EscortUnit:GetGroup()
  
  Escort[ID] = Escort[ID] or {} 
  local EscortSet = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Red A2G Escort AI" ):FilterCrashes():FilterDeads()
  
  -- Spawn new escorts
  local EscortGroup = EscortSpawnA2G:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  EscortSet:AddGroup( EscortGroup )

  local EscortGroup = EscortSpawnA2G:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  EscortSet:AddGroup( EscortGroup )
  
  -- Now setup the AI_ESCORT to make the new spawned escort follow the EscortUnit.
  Escort[ID]["A2G"] = AI_ESCORT:New( EscortUnit, EscortSet, "Escort A2G", "Briefing" ) 
  local EscortObject = Escort[ID]["A2G"] -- AI.AI_Escort#AI_ESCORT
  EscortObject:Menus()
  EscortObject:FormationTrail( 50, 50, 0 )
  EscortObject:__Start( 5 )
  
  EscortGroup.MenuRequestEscortA2G:Remove()
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
  
    EventGroup.MenuRequestEscortA2A = MENU_GROUP_COMMAND:New( EventGroup, "Request A2A Escort", nil, 
      function( EventUnit )
        env.info(" A2Acall")
        SpawnNewEscortsA2A( EventUnit )
      end, EventUnit
      )

    EventGroup.MenuRequestEscortA2G = MENU_GROUP_COMMAND:New( EventGroup, "Request A2G Escort", nil, 
      function( EventUnit )
        env.info(" A2Gcall")
        SpawnNewEscortsA2G( EventUnit )
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
    local EscortA2A = Escort[ID]["A2A"]-- Core.Set#SET_GROUP
    EscortA2A = nil
    
    if EventGroup.MenuRequestEscortA2A then
     EventGroup.MenuRequestEscortA2A:Remove()
    end
    if EventGroup.MenuRequestEscortA2G then
     EventGroup.MenuRequestEscortA2G:Remove()
    end
    
  end
end

