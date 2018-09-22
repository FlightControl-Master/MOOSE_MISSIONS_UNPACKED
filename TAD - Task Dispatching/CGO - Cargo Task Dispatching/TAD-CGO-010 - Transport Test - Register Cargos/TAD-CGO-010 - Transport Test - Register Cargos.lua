---
-- Name: TAD-CGO-010 - Transport Test - Register Cargos
-- Author: FlightControl
-- Date Created: 15 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of various cargo types.
-- 
-- The cargo is defined within the mission editor.
-- Each cargo is identified with a ~CARGO tag in the group name.
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


-- This is the most important now. You setup a new SET_CARGO filtering the relevant type.
-- The actual cargo objects are now created by MOOSE in the background.
-- Each cargo is setup in the Mission Editor using the ~CARGO tag in the group name.
-- This allows a truly dynamic setup.
local CargoSetWorkmaterials = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Build a Workplace", CargoSetWorkmaterials, "Transport the workers, engineers and the equipment near the Workplace." )
TaskDispatcher:SetTransportDeployZone( WorkplaceTask, ZONE:New( "Workplace" ) )

Helos = { SPAWN:New( "Helicopters 1" ), SPAWN:New( "Helicopters 2" ), SPAWN:New( "Helicopters 3" ), SPAWN:New( "Helicopters 4" ), SPAWN:New( "Helicopters 5" ) }

EnemyHelos = { SPAWN:New( "Enemy Helicopters 1" ), SPAWN:New( "Enemy Helicopters 2" ), SPAWN:New( "Enemy Helicopters 3" ) }

function WorkplaceTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  Helos[ math.random(1,#Helos) ]:Spawn()
  EnemyHelos[ math.random(1,#EnemyHelos) ]:Spawn()

end



-- This is the most important now. You setup a new SET_CARGO filtering the relevant type.
-- The actual cargo objects are now created by MOOSE in the background.
-- Each cargo is setup in the Mission Editor using the ~CARGO tag in the group name.
-- This allows a truly dynamic setup.
local CargoSetLiquids = SET_CARGO:New():FilterTypes( "Liquids" ):FilterStart()

local FactoryTask = TaskDispatcher:AddTransportTask( "Transport liquids", CargoSetLiquids, "Transport the milk, gas, fuel, oil to the factory." )
TaskDispatcher:SetTransportDeployZone( FactoryTask, ZONE:New( "Factory" ) )

SAMSites = { SPAWN:New( "SAM Site 1" ), SPAWN:New( "SAM Site 2" ), SPAWN:New( "SAM Site 3" ), SPAWN:New( "SAM Site 4" ), SPAWN:New( "SAM Site 5" ) }

AirAttack = { SPAWN:New( "Russia Air Attack 1" ), SPAWN:New( "Russia Air Attack 2" ), SPAWN:New( "Russia Air Attack 3" ), SPAWN:New( "Russia Air Attack 4" ) }

function FactoryTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  SAMSites[ math.random(1,#SAMSites) ]:Spawn()
  AirAttack[ math.random(1,#AirAttack) ]:Spawn()
end

-- This is the most important now. You setup a new SET_CARGO filtering the relevant type.
-- The actual cargo objects are now created by MOOSE in the background.
-- Each cargo is setup in the Mission Editor using the ~CARGO tag in the group name.
-- This allows a truly dynamic setup.
local CargoSetFood = SET_CARGO:New():FilterTypes( "Food" ):FilterStart()

local FoodTask = TaskDispatcher:AddTransportTask( "Transport food", CargoSetFood, "Transport the workers and the food to the cantine." )
TaskDispatcher:SetTransportDeployZone( FoodTask, ZONE:New( "Cantine" ) )

Hungry = { SPAWN:New( "Hungry 1" ), SPAWN:New( "Hungry 2" ), SPAWN:New( "Hungry 3" ), SPAWN:New( "Hungry 4" ), SPAWN:New( "Hungry 5" ) }

function FoodTask:OnAfterCargoDeployed( From, Event, To, TaskUnit, Cargo, DeployZone )
  Hungry[ math.random(1,#Hungry) ]:Spawn()
end

