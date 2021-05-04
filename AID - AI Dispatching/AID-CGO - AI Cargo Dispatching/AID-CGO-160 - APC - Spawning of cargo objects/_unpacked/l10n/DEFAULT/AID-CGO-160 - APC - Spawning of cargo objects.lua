---
-- Name: AID-CGO-160 - APC - Spawning of cargo objects
-- Author: FlightControl
-- Date Created: 11 Sep 2018
--
-- In this demo cargo objects are spawned at random locations within the battle field.
--
-- This simulates manpads to board APCs and won't disembark to defend the enemy carrier when enemies are nearby..
-- So when the enemy helicopters are within combat range, the manpads will NOT unload and will NOT attack the helos.
-- This is because the combat range was not provided, and thus is 0.


-- Spawn some random cargo in a zone.

SpawnInfantry = SPAWN:New( "Infantry" )
:InitLimit( 30, 100 )
:InitRandomizePosition(true,500,100)
:InitRandomizeZones( { ZONE:New( "SpawnZone" ) } )
:OnSpawnGroup( 
  function( SpawnGroup )
    CARGO_GROUP:New(SpawnGroup,"InfantryType",SpawnGroup:GetName(),150,10)
  end
)
:SpawnScheduled( 30, 0 )


local CargoInfantrySet = SET_CARGO:New():FilterTypes( "InfantryType" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local PickupZonesSet = SET_ZONE:New():FilterPrefixes( "Spawn" ):FilterOnce()
local DeployZonesSet = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterOnce()

-- For the manpads to unload on time, a range of 8000 meters is appropriate.
AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, CargoInfantrySet, PickupZonesSet, DeployZonesSet ) 

-- This will work too, so the combat range can be provided, but must be 0.
--AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones, 0 ) 

-- Now also make the carriers spawn in.
CarrierSpawn = SPAWN:New( "APC" ):InitLimit( 10, 10 ):InitRandomizePosition( true, 200, 50 ):SpawnScheduled( 10, 0 )


AICargoDispatcherAPC:Start()

