-- At startup of the overall mission, we spawn 10 possible escort planes in "Uncontrolled" state.

EscortSpawn = SPAWN:NewWithAlias( "Blue A2G Escort Template" ):InitLimit( 6, 6 )
EscortSpawn:ParkAtAirbase( AIRBASE:FindByName( AIRBASE.Caucasus.Gudauta ), AIRBASE.TerminalType.OpenMedOrBig )


local EscortUnit = UNIT:FindByName( "Blue A2G Pilot" )

local Escort = AI_ESCORT_REQUEST:New( EscortUnit, EscortSpawn, AIRBASE:FindByName(AIRBASE.Caucasus.Gudauta), "A2G", "Rescue the engineer from the village Lesselide near the station. Beware of enemy air defenses. Use the escorts wisely." )
Escort:FormationTrail( 50, 100, 100 )

Escort:SetEscortSpawnMission()

Escort:MenuJoinUp()

Escort:MenuFormationTrail( 50, 50, 0 )
Escort:MenuFormationLeftLine( 0, 0, 50, 50 )
Escort:MenuFormationRightLine( 0, 0, 50, 50 )


Escort:MenuHoldAtEscortPosition( 30, 0 )
Escort:MenuHoldAtEscortPosition( 100, 0 )
Escort:MenuHoldAtLeaderPosition( 30, 0 )
Escort:MenuHoldAtLeaderPosition( 100, 0 )

Escort:MenuFlare()
Escort:MenuSmoke()

Escort:MenuReportTargets( 60 )
Escort:MenuAssistedAttack()
Escort:MenuROE()
Escort:MenuROT()

Escort:MenuResumeMission()

Escort:__Start( 5 )


