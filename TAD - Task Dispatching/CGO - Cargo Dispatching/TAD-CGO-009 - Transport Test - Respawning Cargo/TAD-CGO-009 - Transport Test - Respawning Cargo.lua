---
-- Name: TAD-CGO-009 - Transport Test - Respawning Cargo
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
local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 250 ):RespawnOnDestroyed( true )
local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 150, 50 ):RespawnOnDestroyed( true )
local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 150, 50 ):RespawnOnDestroyed( true )
local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 50 ):RespawnOnDestroyed( true )
local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 150, 50 ):RespawnOnDestroyed(true)

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Build a Workplace", CargoSetWorkmaterials, "Transport the workers, engineers and the equipment near the Workplace." )
TaskDispatcher:SetTransportDeployZone( WorkplaceTask, ZONE:New( "Workplace" ) )

Helos = { SPAWN:New( "Helicopters 1" ), SPAWN:New( "Helicopters 2" ), SPAWN:New( "Helicopters 3" ), SPAWN:New( "Helicopters 4" ), SPAWN:New( "Helicopters 5" ) }

EnemyHelos = { SPAWN:New( "Enemy Helicopters 1" ), SPAWN:New( "Enemy Helicopters 2" ), SPAWN:New( "Enemy Helicopters 3" ) }

function WorkplaceTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  Helos[ math.random(1,#Helos) ]:Spawn()
  EnemyHelos[ math.random(1,#EnemyHelos) ]:Spawn()

end



local CargoSetLiquids = SET_CARGO:New():FilterTypes( "Liquids" ):FilterStart()
local FuelCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Fuel" ), "Liquids", "Fuel", 100, 35 ):RespawnOnDestroyed( true )
local GasCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Gas" ), "Liquids", "Gas", 100, 35 ):RespawnOnDestroyed( true )
local OilCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Oil" ), "Liquids", "Oil", 100, 35 ):RespawnOnDestroyed( true )

local FactoryTask = TaskDispatcher:AddTransportTask( "Transport liquids", CargoSetLiquids, "Transport the milk, gas, fuel, oil to the factory." )
TaskDispatcher:SetTransportDeployZone( FactoryTask, ZONE:New( "Factory" ) )

SAMSites = { SPAWN:New( "SAM Site 1" ), SPAWN:New( "SAM Site 2" ), SPAWN:New( "SAM Site 3" ), SPAWN:New( "SAM Site 4" ), SPAWN:New( "SAM Site 5" ) }

AirAttack = { SPAWN:New( "Russia Air Attack 1" ), SPAWN:New( "Russia Air Attack 2" ), SPAWN:New( "Russia Air Attack 3" ), SPAWN:New( "Russia Air Attack 4" ) }

function FactoryTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  SAMSites[ math.random(1,#SAMSites) ]:Spawn()
  AirAttack[ math.random(1,#AirAttack) ]:Spawn()
end

local CargoSetFood = SET_CARGO:New():FilterTypes( "Food" ):FilterStart()
local WorkerCargoGroupA = CARGO_GROUP:New( GROUP:FindByName( "Workers Team A" ), "Food", "Workers Team A", 250 ):RespawnOnDestroyed( true )
local WorkerCargoGroupB = CARGO_GROUP:New( GROUP:FindByName( "Workers Team B" ), "Food", "Workers Team B", 250 ):RespawnOnDestroyed( true )
local KitchenstuffCargo = CARGO_CRATE:New( STATIC:FindByName( "Kitchenstuff" ), "Food", "Kitchenstuff", 150, 50 ):RespawnOnDestroyed( true )
local FoodCargo = CARGO_CRATE:New( STATIC:FindByName( "Food" ), "Food", "Food", 100, 35 )
local MilkCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Milk" ), "Food", "Milk", 100, 35 )

local FoodTask = TaskDispatcher:AddTransportTask( "Transport food", CargoSetFood, "Transport the workers and the food to the cantine." )
TaskDispatcher:SetTransportDeployZone( FoodTask, ZONE:New( "Cantine" ) )

Hungry = { SPAWN:New( "Hungry 1" ), SPAWN:New( "Hungry 2" ), SPAWN:New( "Hungry 3" ), SPAWN:New( "Hungry 4" ), SPAWN:New( "Hungry 5" ) }

function FoodTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  Hungry[ math.random(1,#Hungry) ]:Spawn()
end

