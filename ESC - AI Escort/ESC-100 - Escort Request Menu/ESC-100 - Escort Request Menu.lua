-- At startup of the overall mission, we spawn 10 possible escort planes in "Uncontrolled" state.

EscortSpawn = SPAWN:NewWithAlias( "Red A2G Escort Template", "Red A2G Escort AI" )

Escort = {} -- #list<#number>

EscortClients = SET_CLIENT:New():FilterPrefixes( "Red A2G Pilot" ):FilterStart()

-- We setup a process where a new spawn of a client plane will trigger a menu option 
-- to request an escort from the pool of escorts.

EventHandlerBirth = EVENTHANDLER:New()

EventHandlerBirth:HandleEvent( EVENTS.Birth )


function SpawnNewEscorts( EscortUnit )
  env.info("new escort")
  local ID = EscortUnit:GetID()
  Escort[ID] = Escort[ID] or {}
  Escort[ID].Set = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Red A2G Escort AI" ):_FilterStart()
  -- Spawn a new escort
  local EscortGroup = EscortSpawn:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), SPAWN.Takeoff.Cold )
  Escort[ID].Set:AddGroup( EscortGroup )
  
  -- Now setup the AI_ESCORT to make the new spawned escort follow the EscortUnit.
  Escort[ID].Escort = AI_ESCORT:New( EscortUnit, Escort[ID].Set, "Escort A2G", "Briefing" )
  Escort[ID].Escort:Menus()
  Escort[ID].Escort:__Start( 5 )
end

--- @param Core.Event#EVENT self
-- @param Core.Event#EVENTDATA EventData
function EventHandlerBirth:OnEventBirth( EventData )

  local EventUnit = EventData.IniUnit
  local EventGroup = EventUnit:GetGroup()
  
  if EscortClients:FindClient( EventUnit:GetName() ) then
  
    if not EventGroup.MenuRequestEscort then
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
         
        end, EventUnit
        )
    end
  end

end



local FollowGroupSet = SET_GROUP:New():FilterCategories( { "plane" } ):FilterCoalitions( "red" ):FilterPrefixes( { "Red A2G Escort" } )

local LeaderUnit = UNIT:FindByName( "Leader" )

