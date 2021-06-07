---
-- Name: SPA-123 - Air Ops - Repeat on Landing and InitCleanUp
-- Author: FlightControl
-- Date Created: 15 Sep 2018
--
-- # Situation:
--
-- Helicpters spawn and are lightly shot until the crash land, but don't really destroy.
-- The should be respawned after a while.
-- No performance overhead should be noticed.

do

  -- Declare SPAWN objects
  Spawn_KA_50 = SPAWN:New("KA-50")
  Spawn_KA_50:InitLimit( 2, 10 )
  
  -- Choose repeat functionality
 
  Spawn_KA_50:InitDelayOff()
  Spawn_KA_50:InitCleanUp( 300 )
  Spawn_KA_50:SpawnScheduled( 180, 0.2 )
  
  -- Now run the mission and observe the behaviour.

end
