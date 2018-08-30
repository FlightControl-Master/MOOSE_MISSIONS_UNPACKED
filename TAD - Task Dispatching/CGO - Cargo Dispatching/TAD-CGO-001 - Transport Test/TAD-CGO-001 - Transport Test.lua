---
-- Name: TAD-CGO-001 - Transport Test
-- Author: FlightControl
-- Date Created: 31 Mar 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations.


local HQ = GROUP:FindByName( "HQ", "Bravo" )

local CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

local Mission = MISSION
  :New( CommandCenter, "Infantry Transportation", "Tactical", 
        "Board the engineers into your MIL-8MTV.", coalition.side.RED )

-- Within the mission file, there is a helicopter defined with a player slot (client).
-- It has the name "Transport Helicopter".
-- The SET_GROUP filter will search for all groups that start with the name "Transport" and will add them to the set.
-- The TransportGroups object of type SET_GROUP will be added to the TaskDispatcher as a parameter, to indicate the groups that will transport the cargo.
local TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

-- This is the task dispatcher main object!
-- It takes a role in the Mission, for the pilots seated in TransportGroups.
TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

-- This zone indicates the location where the engineers can be transported towards.
-- After boarding the engineers, the pilot can ask the HQ to provide routing assistance towards this zone.
TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Stadium" ) )


-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local EngineersSet = SET_CARGO:New():FilterTypes( "Engineers" ):FilterStart()

-- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
-- We name this group "Engineers", and is of type "SAM Engineers".
-- The cargoset "EngineersSet" will embed all defined cargo of type Engineers (prefix) into its set.
local EngineerGroup1 = CARGO_GROUP:New( GROUP:FindByName( "Engineers#001" ), "Engineers", "SAM Engineers 1", 500 )
local EngineerGroup2 = CARGO_GROUP:New( GROUP:FindByName( "Engineers#002" ), "Engineers", "SAM Engineers 2", 500 )
local EngineerGroup3 = CARGO_GROUP:New( GROUP:FindByName( "Engineers#003" ), "Engineers", "SAM Engineers 3", 500 )

-- 
local WorkplaceTask = TaskDispatcher:AddTransportTask( "Transport", EngineersSet, "Transport the SAM Engineers and its equipment to the Stadium." )


