---
-- AUFTRAG: AWACS
-- 
-- An AWACS, Callsign Darkstar 5-1, is on a mission patrolling Zone Alpha form 8:02 to 8:30.
-- Mission starts at 8:00 so the AWACS will appear after 2 min.
--  
-- Radio 225 MHz AM
-- TACAN 29Y (DXS)
---

-- Patrol zone.
local zoneAlpha=ZONE:New("Zone Alpha")

-- AWACS mission. Orbit at 15000 ft, 350 KIAS, heading 270 for 20 NM.
local auftrag=AUFTRAG:NewAWACS(zoneAlpha:GetCoordinate(), 15000, 350, 270, 20)
auftrag:SetTime("8:02", "8:45")
auftrag:SetTACAN(29, "DXS") -- Set TACAN to 29Y.
auftrag:SetRadio(225)       -- Set radio to 225 MHz AM.

-- Create a flightgroup and set default callsign to Darkstar 5-1
local flightgroup=FLIGHTGROUP:New("E-3A Kobuleti")
flightgroup:SetDefaultCallsign(CALLSIGN.AWACS.Darkstar, 5)

-- Assign mission to pilot.
flightgroup:AddMission(auftrag)
