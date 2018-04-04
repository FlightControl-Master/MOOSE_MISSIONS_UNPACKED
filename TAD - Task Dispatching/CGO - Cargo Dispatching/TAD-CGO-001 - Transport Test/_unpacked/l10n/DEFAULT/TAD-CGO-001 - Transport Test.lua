---
-- Name: TAD-CGO-001 - Transport Test
-- Author: FlightControl
-- Date Created: 31 Mar 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for cargo Transport operations.
-- 

HQ = GROUP:FindByName( "HQ", "Bravo" )

CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" )

Mission = MISSION
  :New( CommandCenter, "CSAR Missions", "Tactical", "Transport Cargo", coalition.side.RED )

TransportGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Transport" ):FilterStart()

TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )

TaskDispatcher:SetDefaultDeployZone( ZONE:New( "Stadium" ) )


-- Here we define the "cargo set", which is a collection of cargo objects.
-- The cargo set will be the input for the cargo transportation task.
-- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
local FootballPlayerSet = SET_CARGO:New():FilterTypes( "Football Players" ):FilterStart()

-- Now we add cargo into the battle scene.
local FootballGroup = GROUP:FindByName( "Anderlecht#001" )

-- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
-- We name this group "FC Anderlecht", and is of type "Football Players".
-- The cargoset "EngineersCargoSet" will embed all defined cargo of type Engineers (prefix) into its set.
local FootballPlayerGroup = CARGO_GROUP:New( FootballGroup, "Football Players", "FC Anderlecht", 500 )

TaskDispatcher:AddTransportTask( "Transport Football Team", FootballPlayerSet, "Transport the Football Players and its equipment to the Stadium." )


