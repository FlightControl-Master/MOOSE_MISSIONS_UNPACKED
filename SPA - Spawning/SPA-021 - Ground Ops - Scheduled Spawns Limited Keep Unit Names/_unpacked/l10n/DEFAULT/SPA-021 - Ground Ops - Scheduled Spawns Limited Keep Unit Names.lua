---
-- Name: SPA-021 - Ground Ops - Scheduled Spawns Limited Keep Unit Names
-- Author: FlightControl
-- Date Created: 14 Mar 2017
-- Checked in 15 dez 2020 by ZERO
--
-- # Situation:
--
-- At Gudauta spawn multiple ground vehicles, in a scheduled fashion.
-- 
-- # Test cases:
-- 
-- 1. Observe that the ground vehicles are spawned at the position declared within the mission editor.
-- 2. The vehicles should spawn according the scheduler parameters.
-- 3. There should not be more than 5 groups spawned. (Number of units is 5 groups x 4 units in group = 20 that is a unit limits in :initLimit function in this implementation (:InitLimit( 20 , 10 )))
-- 4. Observe the unit names, they should have the name as defined within the ME.



-- Tests Gudauta
-- -------------
Spawn_Vehicle_1 = SPAWN
  :New( "Spawn Vehicle 1" )
  :InitKeepUnitNames()
  :InitLimit( 20 , 10 )
  :SpawnScheduled( 5, .5 )


