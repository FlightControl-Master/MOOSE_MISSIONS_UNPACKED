---
-- Name: TSK-CGO-502 - Helo - 1 Helo - 1 Task - 2 Cargo - 1 Zone
-- Author: FlightControl
-- Date Created: 12 Mar 2018
--
-- This mission demonstrates the transport of a cargo group using an Helicopter.
-- 
-- There is:
--  - 1 Helicopter.
--  - 1 Transport Task - Transport Workers.
--  - 1 Cargo - Workers.
--  - 1 Deployment Zone - Alpha.
--  
--  Task Workers: Transport the Workers to Deployment Zone Alpha.
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


end	
					
