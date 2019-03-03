
Recce_Blue = SET_GROUP:New():FilterPrefixes( "RECCE" ):FilterStart()

Detection_Blue = DETECTION_AREAS:New( Recce_Blue, 3000 )

A2G_Blue = AI_A2G_DISPATCHER:New(Detection_Blue)

A2G_Blue:SetTacticalDisplay( true ) -- set on using true as a parameter

A2G_Blue:AddDefenseCoordinate( "Command", GROUP:FindByName( "COMMAND" ):GetCoordinate() )
A2G_Blue:AddDefenseCoordinate( "Home", GROUP:FindByName( "HOME" ):GetCoordinate() )


A2G_Blue:SetDefenseRadius( 200000 ) -- in meters
A2G_Blue:SetDefenseReactivityHigh() -- we engage almost immediately

A2G_Blue:SetSquadron( "SQ-1", AIRBASE.Caucasus.Senaki_Kolkhi, { "A2G-DEFENSE-HELO-001", "A2G-DEFENSE-HELO-002", "A2G-DEFENSE-HELO-003" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-1", 200, 280, 160, 500 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-1", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-1" )
A2G_Blue:SetSquadronOverhead( "SQ-1", 0.25 )

A2G_Blue:SetSquadron( "SQ-2", AIRBASE.Caucasus.Gudauta, { "A2G-DEFENSE-SU-25T-SEAD" }, 10 )
A2G_Blue:SetSquadronSead( "SQ-2", 600, 900, 1000, 2000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-2" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-2" )
A2G_Blue:SetSquadronOverhead( "SQ-2", 0.5 )

A2G_Blue:SetSquadron( "SQ-3", AIRBASE.Caucasus.Kobuleti, { "A2G-DEFENSE-AJS37-CAS" }, 6 )
A2G_Blue:SetSquadronBai( "SQ-3", 600, 900, 1000, 2000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-3" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-3" )
A2G_Blue:SetSquadronOverhead( "SQ-3", 0.5 )
A2G_Blue:SetSquadronBaiPatrol( "SQ-3", ZONE:New( "PatrolZone" ), 2000, 3000, 600, 800, 1000, 1400 )
A2G_Blue:SetSquadronPatrolInterval( "SQ-3", 4, 30, 60, 1, "BAI" )
