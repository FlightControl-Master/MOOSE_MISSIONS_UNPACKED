---
-- Name: TAD-CGO-004 - Transport Test - Infantry and Slingload
-- Author: FlightControl
-- Date Created: 05 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of a crate and infantry.
-- Slingload the concrete and board the infantry.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation SandStorm", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Workplace" ) )


-- Now we add cargo into the battle scene.
local CrateStatic = STATIC:FindByName( "Tetrapod" )

-- CARGO_SLINGLOAD can be used to setup cargo as a crate or any other static cargo object.
-- We name this group "Important Concrete", and is of type "Workmaterials".
-- The cargoset "CargoSet" will embed all defined cargo of type Crates into its set.
local CrateCargo = CARGO_SLINGLOAD:New( CrateStatic, "Workmaterials", "Concrete", 1000, 25 )

-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local CargoSet = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()

-- Now we add cargo into the battle scene.
local WorkerGroup = GROUP:FindByName( "Workers" )

-- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
-- We name this group "Workers", and is of type "Workmaterials".
-- The cargoset "CargoSet" will embed all defined cargo of type Workmaterials (prefix) into its set.
local WorkerCargoGroup = CARGO_GROUP:New( WorkerGroup, "Workmaterials", "Workers", 500 )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport Team", CargoSet, "Transport the workers and the equipment near the Workplace." )


