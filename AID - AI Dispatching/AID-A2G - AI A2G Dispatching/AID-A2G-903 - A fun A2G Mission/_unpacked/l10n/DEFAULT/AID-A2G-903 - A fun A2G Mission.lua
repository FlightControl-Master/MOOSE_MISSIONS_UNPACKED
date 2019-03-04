
Recce_Blue = SET_GROUP:New():FilterPrefixes( "RECCE" ):FilterStart()

Detection_Blue = DETECTION_AREAS:New( Recce_Blue, 3000 )

A2G_Blue = AI_A2G_DISPATCHER:New(Detection_Blue)

A2G_Blue:SetTacticalDisplay( true ) -- set on using true as a parameter

A2G_Blue:AddDefenseCoordinate( "Command", GROUP:FindByName( "COMMAND" ):GetCoordinate() )
A2G_Blue:AddDefenseCoordinate( "Home", GROUP:FindByName( "HOME" ):GetCoordinate() )


A2G_Blue:SetDefenseRadius( 350000 ) -- in meters
A2G_Blue:SetDefenseReactivityMedium() -- we engage almost immediately

A2G_Blue:SetSquadron( "SQ-HELO-BAI-1", AIRBASE.Caucasus.Senaki_Kolkhi, { "A2G-DEFENSE-HELO-001", "A2G-DEFENSE-HELO-002", "A2G-DEFENSE-HELO-003" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-HELO-BAI-1", 200, 280, 160, 500 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-HELO-BAI-1", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-HELO-BAI-1" )
A2G_Blue:SetSquadronOverhead( "SQ-HELO-BAI-1", 0.5 )
A2G_Blue:SetSquadronGrouping( "SQ-HELO-BAI-1", 4 )

A2G_Blue:SetSquadron( "SQ-HELO-BAI-2", AIRBASE.Caucasus.Sukhumi_Babushara, { "A2G-DEFENSE-HELO-004", "A2G-DEFENSE-HELO-005", "A2G-DEFENSE-HELO-006" }, 20 )
A2G_Blue:SetSquadronBai( "SQ-HELO-BAI-2", 200, 280, 1500, 2000 )
A2G_Blue:SetSquadronTakeoffInAir( "SQ-HELO-BAI-2", 1000 ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingNearAirbase( "SQ-HELO-BAI-2" )
A2G_Blue:SetSquadronOverhead( "SQ-HELO-BAI-2", 0.75 )
A2G_Blue:SetSquadronGrouping( "SQ-HELO-BAI-2", 4 )

A2G_Blue:SetSquadron( "SQ-SEAD", AIRBASE.Caucasus.Gudauta, { "A2G-DEFENSE-SU-25T-SEAD" }, 10 )
A2G_Blue:SetSquadronSead( "SQ-SEAD", 700, 1100, 2500, 4000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-SEAD" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-SEAD" )
A2G_Blue:SetSquadronOverhead( "SQ-SEAD", 1 )
A2G_Blue:SetSquadronGrouping( "SQ-SEAD", 2 )

A2G_Blue:SetSquadron( "SQ-AIR-BAI", AIRBASE.Caucasus.Kobuleti, { "A2G-DEFENSE-A-10C" }, 6 )
A2G_Blue:SetSquadronBai( "SQ-AIR-BAI", 600, 900, 1000, 2000 )
A2G_Blue:SetSquadronTakeoffFromParkingHot( "SQ-AIR-BAI" ) -- altitude in meters when spawning in the air.
A2G_Blue:SetSquadronLandingAtRunway( "SQ-AIR-BAI" )
A2G_Blue:SetSquadronOverhead( "SQ-AIR-BAI", 0.75 )
A2G_Blue:SetSquadronBaiPatrol( "SQ-AIR-BAI", ZONE:New( "PatrolZone" ), 2000, 3000, 600, 800, 1000, 1400 )
A2G_Blue:SetSquadronPatrolInterval( "SQ-AIR-BAI", 4, 30, 60, 1, "BAI" )
A2G_Blue:SetSquadronGrouping( "SQ-AIR-BAI", 4 )


-- A2G task dispatcher

Command_Blue = COMMANDCENTER:New( GROUP:FindByName( "NATO HQ" ), "NATO HQ" )

Mission_Blue = MISSION:New( Command_Blue, "Invasion", "High", "Eliminate 5 targets", coalition.side.BLUE )

Players_Blue = SET_GROUP:New():FilterPrefixes( { "NATO Player" } ):FilterStart()

A2G_Task_Blue = TASK_A2G_DISPATCHER:New( Mission_Blue, Players_Blue, Detection_Blue )