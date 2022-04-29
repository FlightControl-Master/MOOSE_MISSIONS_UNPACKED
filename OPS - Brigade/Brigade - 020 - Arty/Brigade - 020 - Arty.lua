---
-- BRIGADE: Arty Mission
-- 
-- The brigade is stationed at Senaki. It consists of multiple platoons
-- of different unit types and capabilities.
-- 
-- The brigade gets an assignment to shell a nearby zone.
-- Intel has even provided us the coordinates of an enemy group in the zone.
-- This will be the target.
-- 
-- The mission is repeated ten times if the group has not been completely destroyed.
-- 
-- NOTE that specifying the weapon range of the platoon units is important.
-- Unfortunately, that information cannot be retrieved via scripting.
-- The groups will automatically move in range before the fire at point task is executed.
-- 
-- As an additional feature, some arty groups are spawned beforehand on a "do nothing" mission.
-- Each platoon automatically has the capability to do this mission type. It does not need to be added.
-- These assets will be preferred when the best assets for the ARTY mission are selected.
-- For the ARTY mission, the do NOTHING mission is paused. After the ARTY mission is done, 
-- the assets will resume the NOTHING mission.
---

-- The zone to patrol.
local zoneCapture=ZONE:New("Capture Me"):DrawZone()

-- Set spawn zone of Senaki warehouse.
local zoneSenakiSpawn=ZONE:New("Warehouse Senaki Spawn Zone"):DrawZone()

-- Zone where arty assets should "relax" until they get an assignment.
local zoneArtyAlpha=ZONE:New("Arty Alpha"):DrawZone()

-- Paladin platoon
local platoonARTY=PLATOON:New("M109 Paladin Template", 4, "M109 Paladin")
platoonARTY:AddMissionCapability({AUFTRAG.Type.ARTY}, 90)
platoonARTY:AddWeaponRange(UTILS.KiloMetersToNM(0.5), UTILS.KiloMetersToNM(20))

-- MLRS platoon.
local platoonMLRS=PLATOON:New("MLRS M270 Template", 4, "MLRS M270")
platoonMLRS:AddMissionCapability({AUFTRAG.Type.ARTY}, 80)
platoonMLRS:AddWeaponRange(UTILS.KiloMetersToNM(10), UTILS.KiloMetersToNM(32))

-- Leopard Tank platoon.
local platoonTANK=PLATOON:New("Leopard-2A6M Template", 6, "Leopard-2A6M")
platoonTANK:AddMissionCapability({AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.GROUNDATTACK}, 90)
platoonTANK:AddMissionCapability({AUFTRAG.Type.ARTY}, 30)
platoonTANK:AddWeaponRange(0.1, 1.8)

-- Create a Brigade
local brigade=BRIGADE:New("Warehouse Senaki", "Brigade Senaki")

-- Set spawn zone.
brigade:SetSpawnZone(zoneSenakiSpawn)

-- Add platoons.
brigade:AddPlatoon(platoonARTY)
brigade:AddPlatoon(platoonMLRS)
brigade:AddPlatoon(platoonTANK)

-- Start brigade.
brigade:Start()

---
-- Missions
---

-- Mission to do nothing. Assets will be spawned and got to a random point inside the given zone.
local missionNothing=AUFTRAG:NewNOTHING(zoneArtyAlpha)
missionNothing:SetRequiredAssets(5)
missionNothing:SetFormation(ENUMS.Formation.Vehicle.OffRoad)
missionNothing:SetRequiredAttribute(GROUP.Attribute.GROUND_ARTILLERY)
-- We could also require a certain property (DCS attribute), e.g. only rocket launchers. See https://wiki.hoggitworld.com/view/DCS_enum_attributes
--missionNothing:SetRequiredProperty({"MLRS"})

-- ARTY mission to fire 12 shots at the coordinates of a red group. Radius is 200 meters.
-- NOTE that MLRS have only 12 rockets. They will be out-of-ammo and return after the first engagement.
local missionArty=AUFTRAG:NewARTY(GROUP:FindByName("Ru Smerch-1"), 12, 200)
missionArty:SetFormation(ENUMS.Formation.Vehicle.OffRoad)

-- Set number of required assets. At least one and up to six if available.
-- The five assets on the do NOTHING mission should be selected and one additional asset is spawned. 
missionArty:SetRequiredAssets(1, 6)

-- Start time is 5 min after staring the script. This allows the assets of the "nothing" missions to be spawned.
missionArty:SetTime(5*60)

-- Set time interval before mission result is evaluated. Default is 8 min for arty missions but we shorten it to 2 min here.
missionArty:SetEvaluationTime(2*60)

-- Mission will be repeated up to 10 times if it fails.
missionArty:SetRepeatOnFailure(10)

-- Add mission to brigade.
brigade:AddMission(missionNothing)
brigade:AddMission(missionArty)

--- Function called each time a group from the brigade is send on a mission.
function brigade:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  
  -- Info text.
  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end
