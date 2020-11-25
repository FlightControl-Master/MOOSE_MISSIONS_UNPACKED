---
-- AUFTRAG: Tanker
-- 
-- A KC-135, callsign Arco 5-1, is tasked to refuel our units at two different locations.
-- 
-- First assignment is to orbit in zone Alpha from 8:05 to 8:45. TACAN channel is 80Y ("ARC"), radio 225 MHz.
-- At 9:00 it will move to zone Delta for half an our. TACAN channel is 81Y ("XYZ"), radio 230 MHz.
---

-- Orbit zones.
local zoneAlpha=ZONE:New("Zone Alpha")
local zoneDelta=ZONE:New("Zone Delta")

-- Create Tanker mission.
local auftrag1=AUFTRAG:NewTANKER(zoneAlpha:GetCoordinate(), 10000, 350, 270, 25)
auftrag1:SetTime("8:05", "8:45")
auftrag1:SetTACAN(80, "ARC")
auftrag1:SetRadio(225)

-- Create Tanker mission.
local auftrag2=AUFTRAG:NewTANKER(zoneDelta:GetCoordinate(), 15000, 400, 180, 50)
auftrag2:SetTime("9:00", "9:30")
auftrag2:SetTACAN(81, "XYZ")
auftrag2:SetRadio(230)

-- Create a flight group.
local flightgroup=FLIGHTGROUP:New("KC-135 Kobuleti")
flightgroup:SetDefaultCallsign(CALLSIGN.Tanker.Arco, 5)
flightgroup:SetDefaultRadio(251)
flightgroup:Activate()

-- Assign missions.
flightgroup:AddMission(auftrag1)
flightgroup:AddMission(auftrag2)
