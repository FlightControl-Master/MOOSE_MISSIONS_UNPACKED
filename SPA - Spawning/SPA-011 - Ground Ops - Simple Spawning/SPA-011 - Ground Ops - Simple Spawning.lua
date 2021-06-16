-- Name: SPA-011 - Ground Ops - Simple Spawning
-- Author: FlightControl
-- Date Created: 10 Jan 2017
-- Checked in 15 dez 2020 by ZERO
--
-- # Situation:
--
-- At Gudauta spawn a ground vehicle.
-- 
-- # Test cases:
-- 
-- 1. Observe that the ground vehicle is spawned.



-- Tests Gudauta
-- -------------
-- Spawn a gound vehicle...
Spawn_Vehicle_1 = SPAWN:New( "Spawn Vehicle 1" )
Spawn_Group_1 = Spawn_Vehicle_1:Spawn()



