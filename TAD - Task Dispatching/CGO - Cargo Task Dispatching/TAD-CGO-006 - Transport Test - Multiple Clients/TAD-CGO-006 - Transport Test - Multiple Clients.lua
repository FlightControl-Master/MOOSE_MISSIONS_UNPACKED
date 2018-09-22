---
-- Name: TAD-CGO-006 - Transport Test - Multiple Clients
-- Author: FlightControl
-- Date Created: 05 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of various cargo types.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation SandStorm", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Workplace" ) )


local CargoSet = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()

local WorkerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Workers" ), "Workmaterials", "Workers", 250 )
local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 100 )
local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 100, 50 )
local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 150, 50 )
local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 50 )
local FuelCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Fuel" ), "Workmaterials", "Fuel", 150, 50 )
local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 150, 50 )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport Team", CargoSet, "Transport the workers, engineers and the equipment near the Workplace." )


