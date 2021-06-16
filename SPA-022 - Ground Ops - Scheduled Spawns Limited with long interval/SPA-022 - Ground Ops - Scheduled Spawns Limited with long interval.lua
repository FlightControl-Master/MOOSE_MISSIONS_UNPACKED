-- Name: SPA-022 - Ground Ops - Scheduled Spawns Limited with long interval
-- Author: FlightControl
-- Date Created: 18 Mar 2017
-- Checked in 15 dez 2020 by ZERO
--
-- # Situation:
--
-- At Gudauta spawn multiple ground vehicles, in a scheduled fashion.
-- The vehicle should respawn when killed.
-- 
-- # Test cases:
-- 
-- 1. Observe that the ground vehicles are spawned at the position declared within the mission editor.
-- 2. The vehicles should spawn according the scheduler parameters.
-- 3. When the vehicle spawned die, a new vehicle will be spawned



-- Tests Gudauta
-- -------------
Spawn_Vehicle_1 = SPAWN:New( "Spawn Vehicle 1" ):InitLimit( 1, 0 ):SpawnScheduled( 30, .5 )




