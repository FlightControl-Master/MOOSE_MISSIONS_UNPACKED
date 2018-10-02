---
-- Name: TAD-CGO-002 - Transport Test - Crate
-- Author: FlightControl
-- Date Created: 04 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of a crate.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation SandStorm", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Hangar" ) )


-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local CargoSet = SET_CARGO:New():FilterTypes( "Crates" ):FilterStart()

-- Now we add cargo into the battle scene.
local CrateStatic = STATIC:FindByName( "Crate" )

-- CARGO_CRATE can be used to setup cargo as a crate or any other static cargo object.
-- We name this group "Important things", and is of type "Crates".
-- The cargoset "CargoSet" will embed all defined cargo of type Crates into its set.
local CrateCargo = CARGO_CRATE:New( CrateStatic, "Crates", "Important things", 1000, 25 )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport Crates", CargoSet, "Transport the Crates near the Hangar." )

