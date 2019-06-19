local FollowGroupSet = SET_GROUP:New():FilterCategories( { "plane", "ship" } ):FilterCoalitions( "red" ):FilterPrefixes( { "Escort", "Ship Defense" } ):FilterStart()

local LeaderUnit = UNIT:FindByName( "Leader" )
local Escort = AI_ESCORT:New( LeaderUnit, FollowGroupSet, "Escort Attack", "Briefing" )
Escort:FormationTrail( 750, 750 , 0 )
Escort:MenusAirplanes()
Escort:__Start( 5 )

