---
-- Name: TAD-CGO-003 - Transport Test - Infantry and Crate
-- Author: FlightControl
-- Date Created: 05 Apr 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations of a crate and infantry.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "Operation SandStorm", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Hangar" ) )


-- Now we add cargo into the battle scene.
local CrateStatic = STATIC:FindByName( "Crate" )

-- CARGO_CRATE can be used to setup cargo as a crate or any other static cargo object.
-- We name this group "Important things", and is of type "Crates".
-- The cargoset "CargoSet" will embed all defined cargo of type Crates into its set.
local CrateCargo = CARGO_CRATE:New( CrateStatic, "Football", "Important things", 1000, 25 )

-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local FootballSet = SET_CARGO:New():FilterTypes( "Football" ):FilterStart()

-- Now we add cargo into the battle scene.
local FootballGroup = GROUP:FindByName( "Anderlecht#001" )

-- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
-- We name this group "FC Anderlecht", and is of type "Football Players".
-- The cargoset "EngineersCargoSet" will embed all defined cargo of type Engineers (prefix) into its set.
local FootballPlayerGroup = CARGO_GROUP:New( FootballGroup, "Football", "FC Anderlecht", 500 )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport Team", FootballSet, "Transport FC Anderlecht and the equipment near the Hangar." )


