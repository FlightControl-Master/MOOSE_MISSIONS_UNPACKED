---
<<<<<<< HEAD
-- Name: DET-002 - Detection only Visible Units
-- Author: FlightControl
-- Date Created: 20 Mar 2018
=======
-- Name: DET-001 - Detection Areas
-- Author: FlightControl
-- Date Created: 04 Feb 2017
>>>>>>> develop
--
-- # Situation:
--
-- A small blue vehicle with laser detection methods is detecting targets.
-- Targets are grouped within areas. A detection range and zone range is given to group the detected units.
<<<<<<< HEAD
-- This demo will group red vehicles in areas. One vehicle is diving from one group to the other.
-- It should only detect the visible vehicles. The invisible vehicles should not be detected!
=======
-- This demo will group 5 red vehicles in areas. One vehicle is diving from one group to the other.
>>>>>>> develop
-- 
-- # Test cases:
-- 
-- 1. Observe the flaring of the areas formed
-- 2. Observe the smoking of the units detected
-- 3. Observe the areas being flexibly changed very detection run.
-- 4. The truck driving from the one group to the other, will leave the first area, and will join the second.
-- 5. While driving in between the areas, it will have a separate area.

FACSetGroup = SET_GROUP:New():FilterPrefixes( "FAC Group" ):FilterStart()

FACDetection = DETECTION_AREAS:New( FACSetGroup, 150, 250 ):BoundDetectedZones():SmokeDetectedUnits()

<<<<<<< HEAD
FACDetection:InitDetectVisual( true )
FACDetection:InitDetectRWR( true )
FACDetection:InitDetectRadar( true )


=======
>>>>>>> develop
FACDetection:__Start( 5 )