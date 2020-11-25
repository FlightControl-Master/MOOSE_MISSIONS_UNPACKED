---
-- AUFTRAG: Carpet Bombing
---

-- Target.
local Target=GROUP:FindByName("Red Target X")

-- Flight group.
local bomber=FLIGHTGROUP:New("B-52 Air Group")
bomber:SetDefaultFormation(ENUMS.Formation.FixedWing.Wedge.Group)

-- Carpet bombing mission. Altitude is 15000 ft. Carpet length is 1000 meters.
local mission=AUFTRAG:NewBOMBCARPET(Target, 15000, 1000)
mission:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Open) -- We take an open line abreast formation for the attack.

-- Assign mission to bomber crew.
bomber:AddMission(mission)
