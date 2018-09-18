---
-- Name: TAD-CGO-008 - Transport Test - PickedUp and Deployed Handling
-- Author: FlightControl
-- Date Created: 05 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of various cargo types.
--
-- When cargo is deployed at the Workplace, a large helicopter fleet will descend to the place ...
-- When cargo is deployed at the Factory, a SAM site is activated ...
-- When cargo is deployed at the Cantine, a some other army soldiers will arrive to join lunch ...
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation Cargo Fun", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )


local CargoSetWorkmaterials = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()
local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 250 )
local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 150, 50 )
local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 150, 50 )
local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 50 )
local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 150, 50 )


local WorkplaceTask = TaskDispatcher:AddTransportTask( "Build a Workplace", CargoSetWorkmaterials, "Transport the workers, engineers and the equipment near the Workplace." )
TaskDispatcher:SetTransportDeployZone( WorkplaceTask, ZONE:New( "Workplace" ) )


local CargoSetLiquids = SET_CARGO:New():FilterTypes( "Liquids" ):FilterStart()
local FuelCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Fuel" ), "Liquids", "Fuel", 100, 35 )
local GasCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Gas" ), "Liquids", "Gas", 100, 35 )
local OilCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Oil" ), "Liquids", "Oil", 100, 35 )

local FactoryTask = TaskDispatcher:AddTransportTask( "Transport liquids", CargoSetLiquids, "Transport the milk, gas, fuel, oil to the factory." )
TaskDispatcher:SetTransportDeployZone( FactoryTask, ZONE:New( "Factory" ) )


local CargoSetFood = SET_CARGO:New():FilterTypes( "Food" ):FilterStart()
local WorkerCargoGroupA = CARGO_GROUP:New( GROUP:FindByName( "Workers Team A" ), "Food", "Workers Team A", 250 )
local WorkerCargoGroupB = CARGO_GROUP:New( GROUP:FindByName( "Workers Team B" ), "Food", "Workers Team B", 250 )
local KitchenstuffCargo = CARGO_CRATE:New( STATIC:FindByName( "Kitchenstuff" ), "Food", "Kitchenstuff", 150, 50 )
local FoodCargo = CARGO_CRATE:New( STATIC:FindByName( "Food" ), "Food", "Food", 100, 35 )
local MilkCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Milk" ), "Food", "Milk", 100, 35 )

local FoodTask = TaskDispatcher:AddTransportTask( "Transport food", CargoSetFood, "Transport the workers and the food to the cantine." )
TaskDispatcher:SetTransportDeployZone( FoodTask, ZONE:New( "Cantine" ) )

-- Here we tailor the CargoDeployed event of the TaskDispatcher.

function TaskDispatcher:OnAfterCargoDeployed( From, Event, To, Task, TaskPrefix, TaskUnit, Cargo, DeployZone )

  MESSAGE:NewType( "Unit " .. TaskUnit:GetName().. " has deployed cargo " .. Cargo:GetName() .. " at zone " .. DeployZone:GetName() .. " for task " .. Task:GetName() .. ".", MESSAGE.Type.Information ):ToAll()
  
end

