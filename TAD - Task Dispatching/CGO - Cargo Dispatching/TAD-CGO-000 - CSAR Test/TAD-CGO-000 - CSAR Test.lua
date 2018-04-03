---
-- Name: TAD-CGO-000 - CSAR Test
-- Author: FlightControl
-- Date Created: 31 Mar 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo CSAR operations.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "CSAR Missions", "Tactical", "Rescue downed pilots.", coalition.side.RED )

AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Rescue" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, AttackGroups )

TaskDispatcher:SetCSARDeployZone( ZONE_UNIT:New( "Hospital", STATIC:FindByName( "Hospital" ), 100 ) )

