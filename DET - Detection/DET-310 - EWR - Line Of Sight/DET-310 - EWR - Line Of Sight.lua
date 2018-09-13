---
-- Name: DET-310 - EWR - Line Of Sight
-- Author: FlightControl
-- Date Created: 12 Sep 2018
--
-- # Situation:
--
-- Demonstrates the lost of line of sight using an airplane.

SetGroup = SET_GROUP:New():FilterPrefixes( "Recce" ):FilterStart()

HQ = GROUP:FindByName( "HQ" )

CC = COMMANDCENTER:New( HQ, "HQ" )

RecceDetection = DETECTION_UNITS
  :New( SetGroup )
  :FilterCategories( { Unit.Category.AIRPLANE } )
  :InitDetectRWR(true)

RecceDetection:Start()

--- OnAfter Transition Handler for Event Detect.
-- @param Functional.Detection#DETECTION_UNITS self
-- @param #string From The From State string.
-- @param #string Event The Event string.
-- @param #string To The To State string.
function RecceDetection:OnAfterDetect(From,Event,To)

  local DetectionReport = self:DetectedReportDetailed()

  HQ:MessageToAll( DetectionReport, 15, "Detection" )
end

garbagecollect()
