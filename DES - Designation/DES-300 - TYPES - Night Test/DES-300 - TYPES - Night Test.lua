-- Name: DES-300 - TYPES - Night Test
-- Author: FlightControl
-- Date Created: 23 Apr 2017
--
-- Demonstrates the designation of units, which are grouped per TYPES of the detected units.
-- A Set of Recce are detecting a large group of units.
-- 
--   - Wait until all units are detected by the recce. A report should appear.
--   - Once the report appears, the Designation Menu should be generated. In the communication menu, Press F10 and select F1. Designation.
--   - Test if one DetectionItem (a designated group) is lased by selecting a Target group from the Designation menu.
--   - If a target group is not lased, it should start with "Designate".
--   - If a target group is lased, the menu should start with "Lasing".
--   - If a target group is smoked, the menu should start with "Smoking".
--   - If a target group is illuminated, the menu should start with "Illuminating".
--   - Jump into a ground vehicle with the group name "Attack", and activate night vision (FLIR) (N key).
--   - With FLIR activated in a ground vehicle, search for the laser beams.
--   - Watch the laser beams alternate as targets are being detected or not detected... 
--     The Recce will try to lase as many targets as possible, 
--     but only for those targets to be lased, 
--     and until sufficient laser codes are available.
--   - While the target group is lased, check if the available Recce are lasing the most possible targets.
--   - Check if all laser codes are being used, but not twice.
--   - Check if once a target has been destoyed, that after a while a Recce selects a new target.
--   - Check that if all targets are destroyed, that the Recce reports that.
--   - Check that while a Recce is lasing a target, that it is marking the target.
--   - Check that when you deactive the lasing, that the Recce report the deactivation.
--   - Check that when you illuminate a target group, that a message appears that the Recce is illuminating the target.
--   - Check that when you illuminate a target group, that the target area gets illuminated after a while.


RecceSetGroup = SET_GROUP:New():FilterPrefixes( "Recce" ):FilterStart()

HQ = GROUP:FindByName( "HQ" )

CC = COMMANDCENTER:New( HQ, "HQ" )

-- Let the RecceSetGroup vehicles in the collection detect targets and group them in AREAS of 1000 meters.
RecceDetection = DETECTION_TYPES:New( RecceSetGroup )

-- Create a 
AttackSet = SET_GROUP:New():FilterPrefixes("Attack"):FilterStart()

-- Setup Designation for the AttackSet.
RecceDesignation = DESIGNATE:New( CC, RecceDetection, AttackSet )

-- Generate the random laser codes.
RecceDesignation:GenerateLaserCodes()

-- The su-25T uses a specific laser code to guide its laser guides rockets.
-- The code is 1113. A special menu option will be added that allows to lase with 1113.
RecceDesignation:AddMenuLaserCode( 1113, "Lase for SU-25T (%d)" )

-- The A-10A etc use a specific laser code to guide its laser guides rockets.
-- The code is 1680. A special menu option will be added that allows to lase with 1680.
RecceDesignation:AddMenuLaserCode( 1680, "Lase for A-10A (%d)" )


