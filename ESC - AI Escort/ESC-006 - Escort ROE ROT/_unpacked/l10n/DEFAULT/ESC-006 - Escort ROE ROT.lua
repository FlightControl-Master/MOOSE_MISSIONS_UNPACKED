
local FollowGroupSet = SET_GROUP:New():FilterCategories( { "helicopter" } ):FilterCoalitions( "blue" ):FilterPrefixes( { "Escort" } ):FilterStart()

local LeaderUnit = UNIT:FindByName( "Leader" )
local Escort = AI_ESCORT:New( LeaderUnit, FollowGroupSet, "Escort Test", "Use the ROE and ROT menus to test if the behaviour is working." )

Escort:ModeMission()

Escort:Menus()
Escort:__Start( 5 )

