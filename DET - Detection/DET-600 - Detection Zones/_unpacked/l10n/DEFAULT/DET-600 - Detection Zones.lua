---
-- Name: DET-600 - Detection Zones
-- Author: FlightControl
-- Date Created: 15 Mar 2019
--
-- # Situation:
--
-- 2 trigger zones are defined using the mission editor.
-- The detection algorithm will detect the units within the zones and report them.


DetectionSetZones = SET_ZONE:New():FilterPrefixes( { "Detection Zone" } ):FilterOnce()

DetectionZones = DETECTION_ZONES:New( DetectionSetZones, coalition.side.RED ):BoundDetectedZones():SmokeDetectedUnits()

DetectionZones:__Start( 5 )