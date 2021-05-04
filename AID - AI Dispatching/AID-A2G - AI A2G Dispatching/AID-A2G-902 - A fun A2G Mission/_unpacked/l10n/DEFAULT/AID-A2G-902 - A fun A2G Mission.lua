
Recce_Blue = SET_GROUP:New():FilterPrefixes( "RECCE" ):FilterStart()

Detection_Blue = DETECTION_AREAS:New( Recce_Blue, 3000 )

A2G_Blue = AI_A2G_DISPATCHER:New(Detection_Blue)

A2G_Blue:SetTacticalDisplay( true ) -- set on using true as a parameter

A2G_Blue:AddDefenseCoordinate( "Command", GROUP:FindByName( "COMMAND" ):GetCoordinate() )
A2G_Blue:AddDefenseCoordinate( "Home", GROUP:FindByName( "HOME" ):GetCoordinate() )


A2G_Blue:SetDefenseRadius( 350000 ) -- in meters
A2G_Blue:SetDefenseReactivityMedium() -- we engage almost immediately

A2G_Blue:SetSquadron( "SQ-1", AIRBASE.Caucasus.Senaki_Kolkhi, { "A2G-DEFENSE-HELO-001", "A2G-DEFENSE-HELO-002", "A2G-DEFENSE-HELO-003" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-1", 200, 280, 160, 500 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-1", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-1" )
A2G_Blue:SetSquadronOverhead( "SQ-1", 0.5 )
A2G_Blue:SetSquadronGrouping( "SQ-1", 4 )

A2G_Blue:SetSquadron( "SQ-HELO", AIRBASE.Caucasus.Sukhumi_Babushara, { "A2G-DEFENSE-HELO-004", "A2G-DEFENSE-HELO-005", "A2G-DEFENSE-HELO-006" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-HELO", 200, 280, 1500, 2000 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-HELO", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-HELO" )
A2G_Blue:SetSquadronOverhead( "SQ-HELO", 0.75 )
A2G_Blue:SetSquadronGrouping( "SQ-HELO", 4 )

A2G_Blue:SetSquadron( "SQ-2", AIRBASE.Caucasus.Gudauta, { "A2G-DEFENSE-SU-25T-SEAD" }, 10 )
A2G_Blue:SetSquadronSead( "SQ-2", 700, 1100, 2500, 4000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-2" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-2" )
A2G_Blue:SetSquadronOverhead( "SQ-2", 0.5 )

A2G_Blue:SetSquadron( "SQ-AIR", AIRBASE.Caucasus.Kobuleti, { "A2G-DEFENSE-A-10C-CAS" }, 6 )
A2G_Blue:SetSquadronBai( "SQ-AIR", 600, 900, 1000, 2000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-AIR" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-AIR" )
A2G_Blue:SetSquadronOverhead( "SQ-AIR", 0.75 )
A2G_Blue:SetSquadronBaiPatrol( "SQ-AIR", ZONE:New( "PatrolZone" ), 2000, 3000, 600, 800, 1000, 1400 )
A2G_Blue:SetSquadronPatrolInterval( "SQ-AIR", 4, 30, 60, 1, "BAI" )
A2G_Blue:SetSquadronGrouping( "SQ-AIR", 4 )
