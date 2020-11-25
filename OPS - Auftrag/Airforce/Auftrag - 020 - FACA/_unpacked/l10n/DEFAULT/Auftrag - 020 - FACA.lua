---
-- AUFTRAG: Forward Air Controller Airborne (FACA)
-- 
-- Kiowa gets a FACA mission. It will be orbiting around the target and JTAC menu entry is created. 
---

-- The target.
local Target=GROUP:FindByName("Red Target X")

-- Create a FACA mission. This uses the default settings: Datalink on, designation auto, radio 133 MHz AM.
local mission=AUFTRAG:NewFACA(Target)
mission:SetMissionAltitude(2000)

-- Create a flight group and assign mission.
local afac=FLIGHTGROUP:New("OH-58 Group")
afac:AddMission(mission)
