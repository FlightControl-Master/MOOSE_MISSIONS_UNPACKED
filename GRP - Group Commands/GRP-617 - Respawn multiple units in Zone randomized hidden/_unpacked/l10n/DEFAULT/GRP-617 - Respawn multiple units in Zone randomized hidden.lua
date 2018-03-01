--- This makes a vehicle respawn itself within ZONEVEHICLE1 hidden.
-- The vehicle group consists of multiple units and are spawned in randomized within the new zone.
-- The vehicle is hidden, so you need to observe from the watch tower (external view).
--
-- Name: GRP-617 - Respawn multiple units in Zone randomized hidden
-- Author: FlightControl
-- Date Created: 01 Mar 2018

-- Find the Vehicle and create a GROUP object.
Vehicle = GROUP:FindByName( "Vehicle" )

-- Setup RespawnZone1 linking to the trigger zone ZONEVEHICLE1.
RespawnZone1 = ZONE:New( "ZONEVEHICLE1")

-- Prepare the spawning to be done in RespawnZone1.
Vehicle:InitZone( RespawnZone1 )
Vehicle:InitRandomizePositionZone( true )

-- Respawn the vehicle in RespawnZone1.
Vehicle:Respawn()