-- At startup of the overall mission, we spawn 10 possible escort planes in "Uncontrolled" state.

EscortSpawn = SPAWN:NewWithAlias( "Red A2G Escort Template", "Red A2G Escort AI" ):InitLimit( 10, 10 )
EscortSpawn:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Sochi_Adler ), AIRBASE.TerminalType.OpenBig )


local EscortUnit = UNIT:FindByName( "Red A2G Pilot" )

local Escort = AI_ESCORT_REQUEST:New( EscortUnit, EscortSpawn, AIRBASE:FindByName(AIRBASE.Caucasus.Sochi_Adler), "A2G", "Briefing" )
Escort:FormationTrail( 50, 100, 100 )
Escort:Menus( 50, 50, 0, 0, 50, 50, 6 )
Escort:SetEscortSpawnMission()
Escort:__Start( 5 )
 
