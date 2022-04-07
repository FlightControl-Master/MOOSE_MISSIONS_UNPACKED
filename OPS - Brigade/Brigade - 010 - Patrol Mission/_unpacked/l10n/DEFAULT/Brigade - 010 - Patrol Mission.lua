---
-- BRIGADE: Patrol Mission
-- 
-- The brigade is stationed at Senaki. It consists of multiple platoons
-- of different unit types and capabilities.
-- 
-- The brigade gets an assignment to patrol a nearby zone for 30 minutes.
-- All enemies will be engaged.
-- 
-- Once the mission is over, the assigned assets will return to the 
-- brigade spawn zone.
-- 
-- The mission is repeated five times.
---

-- The zone to patrol.
local zoneCapture=ZONE:New("Capture Me")

-- TPz Fuchs platoon.
local platoonAPC=PLATOON:New("TPz Fuchs Template", 5, "TPz Fuchs")
platoonAPC:AddMissionCapability({AUFTRAG.Type.PATROLZONE}, 40)

-- Paladin platoon
local platoonARTY=PLATOON:New("M109 Paladin Template", 5, "M109 Paladin")
platoonARTY:AddMissionCapability({AUFTRAG.Type.ARTY}, 70)
platoonARTY:AddWeaponRange(UTILS.KiloMetersToNM(0.5), UTILS.KiloMetersToNM(20))

-- MLRS platoon.
local platoonMLRS=PLATOON:New("MLRS M270 Template", 5, "MLRS M270")
platoonMLRS:AddMissionCapability({AUFTRAG.Type.ARTY}, 80)
platoonMLRS:AddWeaponRange(UTILS.KiloMetersToNM(10), UTILS.KiloMetersToNM(32))

-- M939 Truck platoon. Can provide ammo in DCS.
local platoonM939=PLATOON:New("M939 Heavy", 5, "M939 Heavy Truck")
platoonM939:AddMissionCapability({AUFTRAG.Type.AMMOSUPPLY}, 70)


-- Create a Brigade
local brigade=BRIGADE:New("Warehouse Senaki", "Brigade Senaki")

-- Set spawn zone.
brigade:SetSpawnZone(ZONE:New("Warehouse Senaki Spawn Zone"))

-- Add platoons.
brigade:AddPlatoon(platoonAPC)
brigade:AddPlatoon(platoonARTY)
brigade:AddPlatoon(platoonMLRS)

-- Start brigade.
brigade:Start()


-- Mission to patrol the zone. Two asset groups will be assigned to patrol the zone for 20 min.
local missionPatrol=AUFTRAG:NewPATROLZONE(zoneCapture)

-- Mission is cancelled 30 min after execution, i.e. when the first group patrols the zone.
missionPatrol:SetDuration(30*60)
-- Mission is repeated 5 times.
missionPatrol:SetRepeat(5)
-- Enemies are automatically engaged.
missionPatrol:SetEngageDetected()
-- At least to asset groups are required to carry out the mission.
missionPatrol:SetRequiredAssets(2)

-- Add mission to brigade.
brigade:AddMission(missionPatrol)

--- Function called each time a group from the brigade is send on a mission.
function brigade:OnAfterArmyOnMission(From, Event, To, Armygroup, Mission)
  local armygroup=Armygroup --Ops.ArmyGroup#ARMYGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  
  -- Info text.
  local text=string.format("Armygroup %s on Mission %s [%s]", armygroup:GetName(), mission:GetName(), mission:GetType())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end