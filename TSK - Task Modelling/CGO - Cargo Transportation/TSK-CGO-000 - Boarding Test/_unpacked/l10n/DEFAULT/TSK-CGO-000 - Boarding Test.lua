---
-- Name: TSK-CGO-000 - Boarding Test
-- Author: FlightControl
-- Date Created: 12 Apr 2017
--
-- This mission demonstrates the transport of a cargo group using an APC.
-- 
-- There is:
--  - 1 APC.
--  - 2 Transport Tasks - Transport Workers and Transport Engineers.
--  - 2 Cargo - Workers and Engineers.
--  - 2 Deployment Zones - Alpha and Beta.
--  
--  Task Engineers: Transport the Engineers to Deployment Zone Alpha or Zone Beta.
--  Task Workers: Transport the Workers to Deployment Zone Beta.
-- 

do
  local HQ = GROUP:FindByName( "HQ", "Bravo HQ" )

  local CommandCenter = COMMANDCENTER:New( HQ, "Bravo" )

  local Scoring = SCORING:New( "Cargo Group Transport Demonstration" )

  local Mission = MISSION
    :New( CommandCenter, "Transport", "High", "Transport the team from Deploy Zone 1 to Deploy Zone 2", coalition.side.BLUE )
    :AddScoring( Scoring )

  -- Allocate the Transport, which is an APC in the field.
  local APC = SET_GROUP:New():FilterPrefixes( "Transport" ):FilterStart()

  -- We will setup the transportation for Engineers.
  
  -- Here we define the "cargo set", which is a collection of cargo objects.
  -- The cargo set will be the input for the cargo transportation task.
  -- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
  local EngineersCargoSet = SET_CARGO:New():FilterTypes( "Engineers" ):FilterStart()

  -- Now we add cargo into the battle scene.
  local EngineersGroup = GROUP:FindByName( "Engineers" )
  
  -- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
  -- We name this group Engineers.
  -- Note that the name of the cargo is "Engineers".
  -- The cargoset "EngineersCargoSet" will embed all defined cargo of type Engineers (prefix) into its set.
  local EngineersCargoGroup = CARGO_GROUP:New( EngineersGroup, "Engineers", "Radar Team", 500 )

  
  -- We setup the task to transport engineers.
  EngineersCargoTransportTask = TASK_CARGO_TRANSPORT:New( Mission, APC, "Transport Engineers", EngineersCargoSet )

  -- We setup to deploy workers in the deploy zone 1 and 2 (the player can choose).
  EngineersCargoTransportTask:AddDeployZone( ZONE_POLYGON:New( "Deploy Zone Alpha", GROUP:FindByName("DeployZone Alpha") ) )
  EngineersCargoTransportTask:AddDeployZone( ZONE_POLYGON:New( "Deploy Zone Beta", GROUP:FindByName("DeployZone Beta") ) )


  -- Here we define the "cargo set", which is a collection of cargo objects.
  -- The cargo set will be the input for the cargo transportation task.
  -- So a transportation object is handling a cargo set, which is automatically refreshed when new cargo is added/deleted.
  local WorkersCargoSet = SET_CARGO:New():FilterTypes( "Workers" ):FilterStart()
  
  local WorkersGroup = GROUP:FindByName( "Workers" )

  -- CARGO_GROUP can be used to setup cargo with a GROUP object underneath.
  -- We name this group Engineers.
  -- Note that the name of the cargo is "Workers".
  -- The cargoset "WorkersCargoSet" will embed all defined cargo of type Workers (prefix) into its set.
  local WorkersCargoGroup = CARGO_GROUP:New( WorkersGroup, "Workers", "Mechanics", 500 )


  -- We setup the task to transport workers.
  WorkersCargoTransportTask = TASK_CARGO_TRANSPORT:New( Mission, APC, "Transport Workers", WorkersCargoSet )
  
  -- We setup to deploy workers in the deploy zone 1.
  WorkersCargoTransportTask:AddDeployZone( ZONE_POLYGON:New( "Deploy Zone Beta", GROUP:FindByName("DeployZone Beta") ) )

end	
					
