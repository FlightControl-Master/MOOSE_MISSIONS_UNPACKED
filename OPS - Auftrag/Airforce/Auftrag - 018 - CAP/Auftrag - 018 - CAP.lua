---
-- Mission: Combat Air Patrol (CAP)
-- 
-- An F-16 group will perform a DCS CAP in zone Delta and attack all targets it detects automatically.
-- 
-- At 08:15 two enemy groups will fly into the CAP zone and should be engaged.
-- The enemies will not attack as they are on a simple orbit mission where the ROE prohibit any engagement.
---

-- CAP zone.
local zoneDelta=ZONE:New("Zone Delta")

--Create a new CAP mission.
local missionCAP=AUFTRAG:NewCAP(zoneDelta, 10000, 350)
missionCAP:SetTime("8:00", "9:00")

-- Create a flightgroup and assign mission to pilot.
local f16=FLIGHTGROUP:New("F-16 CAP Group")
f16:AddMission(missionCAP)


---
-- Intruders
---

-- Create an orbit mission for the intruder.
local missionORBIT=AUFTRAG:NewORBIT(zoneDelta:GetRandomCoordinate(), 6000, 350, 180, 10)
missionORBIT:SetTime("8:15", "9:00")

-- Add intruder flight.
local mig29=FLIGHTGROUP:New("MiG-29 Air Group")
local tu22=FLIGHTGROUP:New("Tu-22 Air Group")
mig29:AddMission(missionORBIT)
tu22:AddMission(missionORBIT)
