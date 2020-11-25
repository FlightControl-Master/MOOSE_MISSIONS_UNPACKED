---
-- Mission: Close Air Support (CAS)
-- 
-- A-10 will perform a DCS CAS in zone Charlie and attack all targets it detects automatically.
-- 
-- This mission type uses the DCS enroute task engageTargetsInZone https://wiki.hoggitworld.com/view/DCS_task_engageTargetsInZone
-- Therefore, the CAS zone needs to be a circular zone. Polygon zones are unfortunately not supported by DCS.
-- 
-- We also enable the detection and send a message if an unknown unit was detected by the group.
-- NOTE that this is not necessary for the CAS mission to work. It is only to keep track on which units are actually detected.
---

-- The CAS zone.
local zoneCharlie=ZONE:New("Zone Charlie")

-- Create a flight group.
local flightgroup=FLIGHTGROUP:New("A-10C CAS Group")
flightgroup:SetDetection(true)

--- Function called when the group detectes a previously unkwown unit.
function flightgroup:OnAfterDetectedUnitNew(From, Event, To, Unit)
  local unit=Unit --Wrapper.Unit#UNIT
  
  -- Message to everybody and in the DCS log file.
  local text=string.format("Detected unit %s", unit:GetName())
  MESSAGE:New(text, 120,flightgroup:GetName()):ToAll()
  env.info(text)
  
end

-- Create a CAS mission.
local mission=AUFTRAG:NewCAS(zoneCharlie)

-- Assign mission to pilot.
flightgroup:AddMission(mission)