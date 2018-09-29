---
-- Name: SPA-120 - Air Ops - Scheduled Spawns with Repeat on Landing with Limit
-- Author: FlightControl
-- Date Created: 05 Feb 2017
--
-- # Situation:
--
-- One airplane and one helicopter will be spawned.
-- Only one airplane and one helicopter can be alive at the same time.
-- Upon landing, the airplane and helicopter will respawn at Kutaisi.
-- 
-- # Test cases:
-- 
-- 1. Observe the spawning of the airplane and helicopter
-- 2. There should not be more airplanes alive than there are set by InitLimit.
-- 3. Upon landing, the planes should respawn.
-- 5. The plane should respawn itself when the air unit has parked at the ramp or has landed.


do

  -- Declare SPAWN objects
  Spawn_Plane = SPAWN:New("Plane"):InitLimit( 1, 10 )
  
  -- Choose repeat functionality
  
  -- Repeat on ... (when landed on the airport)
  Spawn_Plane:InitRepeatOnEngineShutDown()
  
  -- Now SPAWN the GROUPs
  Spawn_Plane:SpawnScheduled(30,0)
  
  -- Now run the mission and observe the behaviour.

end
