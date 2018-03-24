---
-- Name: DES-021 - AREAS - Detection Message Flash
-- Author: FlightControl
-- Date Created: 24 Mar 2018
--
-- Check if the detection messages are NOT displayed.


RecceSetGroup = SET_GROUP:New():FilterPrefixes( "Recce" ):FilterStart()

HQ = GROUP:FindByName( "HQ" )

CC = COMMANDCENTER:New( HQ, "HQ" )

-- Let the RecceSetGroup vehicles in the collection detect targets and group them in AREAS of 1000 meters.
RecceDetection = DETECTION_AREAS:New( RecceSetGroup, 1000 )

-- Create a Attack Set, which contains the human player client slots and CA vehicles.
AttackSet = SET_GROUP:New():FilterPrefixes("Attack"):FilterStart()

RecceDesignation = DESIGNATE:New( CC, RecceDetection, AttackSet )

-- This sets the flashing of detection messages off.
RecceDesignation:SetFlashDetectionMessages( false )

-- Set the possible laser codes.
RecceDesignation:SetLaserCodes({1113,1131,1256})

-- Start the detection process in 5 seconds.
RecceDesignation:__Detect( -5 )

