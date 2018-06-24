---
-- Name: TAD-CGO-005 - Transport Test - Various Cargo
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
  :New( CommandCenter, "Operation SandStorm", "Tactical", "Transport Cargo", coalition.side.BLUE )

TransportGroups = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Workplace" ) )


local CargoSet = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()

local WorkerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Workers" ), "Workmaterials", "Workers", 250 )
WorkerCargoGroup:ReportSmoke( SMOKECOLOR.Green )

local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 100 )
EngineerCargoGroup:ReportSmoke( SMOKECOLOR.Red )

local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 100, 25 )
ConcreteCargo:ReportSmoke( SMOKECOLOR.White )

local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 50, 25 )
CrateCargo:ReportSmoke( SMOKECOLOR.Orange )

local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 25 )
EnginesCargo:ReportFlare( FLARECOLOR.Red )

local FuelCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Fuel" ), "Workmaterials", "Fuel", 200, 25 )
FuelCargo:ReportFlare( FLARECOLOR.Green )

local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 500, 25 )
MetalCargo:ReportFlare( FLARECOLOR.Yellow )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport Team", CargoSet, "Transport the workers, engineers and the equipment near the Workplace." )


