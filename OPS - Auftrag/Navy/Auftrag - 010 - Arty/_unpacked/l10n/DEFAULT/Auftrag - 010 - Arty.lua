---
-- AUFTRAG: Arty
-- 
-- USS Lake Erie is ordered to attack two targets.
-- First target is engaged with cruise missiles. Second with cannons.
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Lake Erie Group")

-- Increase output to DCS log file.
navygroup:SetVerbosity(3)

-- Set weapon range (in NM). This is IMPORTANT since the fire at point task is not executed if the ship is not in range.
navygroup:AddWeaponRange(5.5, 270, ENUMS.WeaponFlag.CruiseMissile)
navygroup:AddWeaponRange(2.7, 13, ENUMS.WeaponFlag.Cannons)

-- Targets.
local target1=GROUP:FindByName("Red Target X")
local target2=GROUP:FindByName("Red Target Poti")

-- First mission uses 5 cruise missiles. NOTE that cruise missiles don't obey the radius parametrer of the fire at point task :( They all impact at the same position.
local auftrag1=AUFTRAG:NewARTY(target1, 5)
auftrag1:SetWeaponType(ENUMS.WeaponFlag.CruiseMissile)

-- Second mission fires 10 shells at a target near Poti. Radius is set to 250 meters. 
local auftrag2=AUFTRAG:NewARTY(target2, 10, 250)
auftrag2:SetWeaponType(ENUMS.WeaponFlag.Cannons)

-- Assign mission to the ship's captain.
navygroup:AddMission(auftrag1)
navygroup:AddMission(auftrag2)
