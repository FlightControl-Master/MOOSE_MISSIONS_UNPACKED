---
-- AUFTRAG: Strike
-- 
-- Task is to destroy a strategically important bridge at the mouth of the Enguri river.
-- 
-- We assign two flights, one Viggen and one A-10C, for this job.
-- 
-- The Viggen pilot is a nugget and tends to drop bombs long. So it is always good to have a more experienced pilot as backup.
-- 
-- NOTE:
-- * In order to get the scenery object, you can right click on the map in the mission editor and use the "assign as..." function to create a zone.
-- * The STRIKE auftrag uses the AttackMapObject DCS task https://wiki.hoggitworld.com/view/DCS_task_attackMapObject
---

-- To get the scenery object of the bridge, we create a zone in the mission editor.
local TargetCoord=ZONE:New("Zone Bridge"):GetCoordinate()

-- The bridge should be the closest scenery object.
local Bridge=TargetCoord:FindClosestScenery(200)

-- Create a strike mission.
local auftrag=AUFTRAG:NewSTRIKE(Bridge)

-- Assign Viggen group.
local viggen=FLIGHTGROUP:New("Viggen BAI Group")
viggen:AddMission(auftrag)

-- Assign A-10 group.
local a10c=FLIGHTGROUP:New("A-10C CAS Group")
a10c:AddMission(auftrag)
