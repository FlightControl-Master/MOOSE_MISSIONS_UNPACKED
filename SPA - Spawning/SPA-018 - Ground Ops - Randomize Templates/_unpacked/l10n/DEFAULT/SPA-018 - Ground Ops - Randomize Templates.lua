---
-- Name: SPA-018 - Ground Ops - Randomize Templates
-- Author: FlightControl
-- Date Created: 10 Jan 2017
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
-- 3. There should not be more than 10 groups spawned.
-- 4. Observe that the route that the vehicles follow is randomized starting from point 1 till point 3.
-- 5. Observe that the position where the units are spawned, is randomized according the zones.
-- 6. Observe that the ground vehicles are spawned with randomized templates.


-- Tests Gudauta
-- -------------
-- Create a zone table of the 2 zones.
ZoneTable = { ZONE:New( "Zone1" ), ZONE:New( "Zone2" ) }

TemplateTable = { "A", "B", "C" }

Spawn_Vehicle_1 = SPAWN:New( "Spawn Vehicle 1" )
  :InitLimit( 10, 10 )
  :InitRandomizeRoute( 1, 1, 200 )
  :InitRandomizeZones( ZoneTable )
  :InitRandomizeTemplate( TemplateTable ) 
  :SpawnScheduled( 5, .5 )

