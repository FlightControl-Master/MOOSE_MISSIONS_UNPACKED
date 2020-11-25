---
-- AUFTRAG: Arty
---


-- Create a new ARMYGROUP object.
local armygroup=ARMYGROUP:New("MLRS M270")
armygroup:SetDefaultFormation(ENUMS.Formation.Vehicle.OnRoad)

-- We set the weapon min/max ranges in nautical miles (NM). Target needs to be not closer than 10 km and not further away than 32 km.
armygroup:AddWeaponRange(UTILS.KiloMetersToNM(10), UTILS.KiloMetersToNM(32))

-- Create a new ARTY auftrag.
local auftrag1=AUFTRAG:NewARTY(GROUP:FindByName("Red Target X"), 5, 100)
auftrag1:SetWeaponType(ENUMS.WeaponFlag.AnyRocket)

-- Create a new ARTY auftrag.
local auftrag2=AUFTRAG:NewARTY(STATIC:FindByName("Red Command Center"), 5, 10)
auftrag2:SetFormation(ENUMS.Formation.Vehicle.OnRoad)


-- Give mission to commander.
armygroup:AddMission(auftrag1)
armygroup:AddMission(auftrag2)


