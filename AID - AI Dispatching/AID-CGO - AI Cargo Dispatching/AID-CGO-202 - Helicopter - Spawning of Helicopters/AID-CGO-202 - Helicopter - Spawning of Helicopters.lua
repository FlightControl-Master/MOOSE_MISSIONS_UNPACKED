---
-- Name: AID-CGO-202 - Helicopter - Spawning of Helicopters
-- Author: FlightControl
-- Date Created: 19 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherHelicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, nil, SetDeployZones ) 
AICargoDispatcherHelicopter:Start()

HelicopterSpawn = SPAWN
  :New( "Helicopter" )
  :InitLimit( 4, 20 )
  :InitLateActivated( true )
  :SpawnScheduled( 180, 0.5 )
