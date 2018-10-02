---
-- Name: TAD-CGO-011 - CSAR - Zone
-- Author: FlightControl
-- Date Created: 01 Oct 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo CSAR operations.
-- It will only spawn pilots for rescue when the pilots eject in the zones indicated.

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "CSAR Missions", "Tactical", "Rescue downed pilots.", coalition.side.RED )

AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Rescue" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, AttackGroups )

TaskDispatcher:SetCSARZones( SET_ZONE:New():FilterPrefixes("CSAR"):FilterOnce() )

TaskDispatcher:StartCSARTasks( 
  "CSAR", 
  { ZONE_UNIT:New( "Hospital", STATIC:FindByName( "Hospital" ), 100 ) }, 
  "One of our pilots has ejected. Go out to Search and Rescue our pilot!\n" .. 
  "Use the radio menu to let the command center assist you with the CSAR tasking."
)

function TaskDispatcher:OnAfterCargoDeployed( From, Event, To, Task, TaskPrefix, TaskUnit, Cargo, DeployZone )

  MESSAGE:NewType( "Unit " .. TaskUnit:GetName().. " has deployed cargo " .. Cargo:GetName() .. " at zone " .. DeployZone:GetName() .. " for task " .. Task:GetName() .. ".", MESSAGE.Type.Information ):ToAll()
  
end
