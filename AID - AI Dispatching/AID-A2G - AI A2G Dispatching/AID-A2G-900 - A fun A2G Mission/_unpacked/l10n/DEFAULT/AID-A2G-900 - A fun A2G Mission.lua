
Recce_Blue = SET_GROUP:New():FilterPrefixes( "RECCE" ):FilterStart()

Detection_Blue = DETECTION_AREAS:New( Recce_Blue, 3000 )

A2G_Blue = AI_A2G_DISPATCHER:New(Detection_Blue)

A2G_Blue:SetTacticalDisplay( true ) -- set on using true as a parameter

DefenseCoordinate = GROUP:FindByName( "COMMAND" ):GetCoordinate()

A2G_Blue:AddDefenseCoordinate( "Defense Point", DefenseCoordinate )
A2G_Blue:SetDefenseRadius( 200000 ) -- in meters
A2G_Blue:SetDefenseReactivityHigh() -- we engage almost immediately

A2G_Blue:SetSquadron( "SQ-1", AIRBASE.Caucasus.Gudauta, { "A2G-DEFENSE-AH-64D-ROCKETS", "A2G-DEFENSE-AH-64D-HELLFIRES" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-1", 200, 280, 160, 500 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-1", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-1" )
A2G_Blue:SetSquadronOverhead( "SQ-1", 0.25 )

A2G_Blue:SetSquadron( "SQ-2", AIRBASE.Caucasus.Gudauta, { "A2G-DEFENSE-AH-SU-25T-SEAD" }, 6 )
A2G_Blue:SetSquadronSead( "SQ-2", 600, 900, 1000, 2000 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-2", 2000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-2" )
A2G_Blue:SetSquadronOverhead( "SQ-2", 0.5 )


