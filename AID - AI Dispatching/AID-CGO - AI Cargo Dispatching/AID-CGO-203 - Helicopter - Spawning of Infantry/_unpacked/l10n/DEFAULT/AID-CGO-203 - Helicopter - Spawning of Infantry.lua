---
-- Name: AID-CGO-203 - Helicopter - Spawning of Infantry
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
  :SpawnScheduled( 20, 0.5 )
  
InfantrySpawn = SPAWN
  :New( "Infantry" )
  :InitLimit( 20, 60 )
  :OnSpawnGroup(
    function( SpawnGroup )
      CARGO_GROUP:New( SpawnGroup, "Infantry", SpawnGroup:GetName(), 500, 25 )
    end
  )
  :InitRandomizePosition( true, 1000, 250 )
  :SpawnScheduled( 10, 0.5 )

