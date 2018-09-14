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

RecceDetection = DETECTION_AREAS
  :New( SetGroup, 1500 )
  :FilterCategories( { Unit.Category.AIRPLANE } )
  :InitDetectRWR(true)

local Zones = {
  ZONE:New( "Zone1" ),
  ZONE:New( "Zone2" )
}

local Sams = {
  GROUP:FindByName( "SAM1" ),
  GROUP:FindByName( "SAM2" )
}

RecceDetection:Start()

--- OnAfter Transition Handler for Event DetectedItem.
-- @param RecceDetection self
-- @param #string From The From State string.
-- @param #string Event The Event string.
-- @param #string To The To State string.
-- @param Functional.Detection#DETECTION_BASE.DetectedItem DetectedItem
function RecceDetection:OnAfterDetectedItem(From,Event,To,DetectedItem)

  local DetectionReport = self:DetectedReportDetailed()

  HQ:MessageToAll( DetectionReport, 15, "Detection" )
  
  if DetectedItem.IsDetected then
    local Coordinate = DetectedItem.Coordinate -- Core.Point#COORDINATE
    for ZoneID, ZoneData in pairs( Zones ) do
      local Zone = ZoneData -- Core.Zone#ZONE
      if Zone:IsCoordinateInZone(Coordinate) then
        Sams[ZoneID]:Activate()
      end
    end
  end
  
end

garbagecollect()
