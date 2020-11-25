---
-- Mission: Transport Troops
--
-- A UH-1H is assigned to pick up infantry groups and transport them to the drop zone.
---

-- Troops to be transported from A to B.
local TroopSet=SET_GROUP:New():FilterPrefixes("Infantry Transport"):FilterOnce()

-- Carrier.
local helo=FLIGHTGROUP:New("UH-1H Group")

-- Drop off zone.
local zoneDrop=ZONE:New("Zone Dropoff")

-- Transport mission.
local mission=AUFTRAG:NewTROOPTRANSPORT(TroopSet, zoneDrop:GetCoordinate())

-- Assign mission to the flight group.
helo:AddMission(mission)

-- Smoke transported groups after they disembarked.
function mission:OnAfterDone(From,Event,To)
  for _,group in pairs(mission.transportGroupSet:GetSet()) do
    group:SmokeRed()
  end
end
