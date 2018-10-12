---
-- Name: TAD-CGO-008 - Transport Test - PickedUp and Deployed Handling
-- Author: FlightControl
-- Date Created: 12 Oct 2018
--
-- Test to pickup cargo from the roof of a building.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation Cargo Fun", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "Transport" ):FilterStart()

CargoWorkers = SET_CARGO:New():FilterTypes( "Workers" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

local WorkersTask = TaskDispatcher:AddTransportTask( "Transport Workers", CargoWorkers, "Transport the workers to the other building." )
TaskDispatcher:SetTransportDeployZone( WorkersTask, ZONE:New( "Workplace" ) )


-- Here we tailor the CargoDeployed event of the TaskDispatcher.

function TaskDispatcher:OnAfterCargoDeployed( From, Event, To, Task, TaskPrefix, TaskUnit, Cargo, DeployZone )

  MESSAGE:NewType( "Unit " .. TaskUnit:GetName().. " has deployed cargo " .. Cargo:GetName() .. " at zone " .. DeployZone:GetName() .. " for task " .. Task:GetName() .. ".", MESSAGE.Type.Information ):ToAll()
  
end

