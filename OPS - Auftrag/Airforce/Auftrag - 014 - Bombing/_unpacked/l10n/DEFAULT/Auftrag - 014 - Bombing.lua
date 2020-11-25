---
-- AUFTRAG: Bombing
---

local Target1=STATIC:FindByName("Red TV Tower")
local Target2=GROUP:FindByName("Red Target X")

local bomber=FLIGHTGROUP:New("B-52 Air Group")
bomber:Activate()

local mission1=AUFTRAG:NewBOMBING(Target1, 25000)
mission1:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
mission1:SetTime("8:05")
mission1:SetPriority(20)

local mission2=AUFTRAG:NewBOMBING(Target2, 30000)
-- Interestingly, setting expend to ALL does NOT work. Looks like as half of the bombs is already gone in mission1, the task cannot be executed any more.
mission2:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
mission1:SetTime("8:05")
mission2:SetPriority(10)

bomber:AddMission(mission1)
bomber:AddMission(mission2)
