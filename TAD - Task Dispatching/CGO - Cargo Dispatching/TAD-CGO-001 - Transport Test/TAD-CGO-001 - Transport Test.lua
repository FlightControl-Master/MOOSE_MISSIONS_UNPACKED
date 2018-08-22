---
-- Name: TAD-CGO-001 - Transport Test
-- Author: FlightControl
-- Date Created: 31 Mar 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations.
-- 

local HQ = GROUP:FindByName( "HQ", "Bravo" )

local CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

local Mission = MISSION
  :New( CommandCenter, "Infantry Transportation", "Tactical", 
        "Board the engineers into your MIL-8MTV.", coalition.side.RED )

local TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Stadium" ) )


-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local EngineersSet = SET_CARGO:New():FilterTypes( "Engineers" ):FilterStart()

-- Now we add cargo into the battle scene.
local EngineersGroup = GROUP:FindByName( "Engineers#001" )

-- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
-- We name this group "FC Anderlecht", and is of type "Football Players".
-- The cargoset "EngineersCargoSet" will embed all defined cargo of type Engineers (prefix) into its set.
local FootballPlayerGroup = CARGO_GROUP:New( EngineersGroup, "Engineers", "SAM Engineers", 500 )

local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport SAM Engineers", EngineersSet, "Transport the SAM Engineers and its equipment to the Stadium." )


