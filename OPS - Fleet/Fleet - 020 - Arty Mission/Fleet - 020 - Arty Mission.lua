---
-- FLEET: Arty
-- 
-- A naval fleet is stationed at Akrotiri (Cyprus). It has two flotillas with five ships each.
-- These consist of CG Ticonderoga and FAC La Combattante warships.
-- 
-- The fleet is assigned to carry out arty (fire at point) missions to shell known enemy locations.
-- It is also assigned to attack enemy ships.
-- 
-- The targets are
-- * BTR-80s located in zone alpha
-- * Silkworms located in zone bravo
-- * War ships located in zone charlie
-- * MiG-31 aircraft (statics) located at Bassar Al-Assad airport
-- 
-- PS: Ships move slowly and distances are rather large. So don't be afraid to fast forward.
---

-- Create zones defined in the Mission Editor.
local zoneAkrotiriSpawn=ZONE:New("Akrotiri Spawn Zone"):DrawZone()
local zoneAkrotiriPort=ZONE:New("Akrotiri Port Zone"):DrawZone()
local zonePatrolAlpha=ZONE:New("Patrol Zone Alpha"):DrawZone()
local zonePatrolBravo=ZONE:New("Patrol Zone Bravo"):DrawZone()
local zoneTargetAlpha=ZONE:New("Target Zone Alpha"):DrawZone()
local zoneTargetBravo=ZONE:New("Target Zone Bravo"):DrawZone()
local zoneTargetCharlie=ZONE:New("Target Zone Charlie"):DrawZone()
local zoneTargetDelta=ZONE:New("Target Zone Delta"):DrawZone()


-- Flotilla of CG Ticonderoga. 
local flotillaAlpha=FLOTILLA:New("CG Ticonderoga Template", 5, "Flotilla Alpha Ticonderoga")
flotillaAlpha:AddMissionCapability({AUFTRAG.Type.PATROLZONE}, 60)
flotillaAlpha:AddMissionCapability({AUFTRAG.Type.ARTY}, 80)
-- Weapon range of cannons has to be manually added. Effective range of the Mk45 gun is 13 NM (~24 km).
flotillaAlpha:AddWeaponRange(1, 13, ENUMS.WeaponFlag.Cannons)

-- Flotilla of FAC La Combattante IIa. 
local flotillaBravo=FLOTILLA:New("FAC La Combattante IIa Template", 5, "Flotilla Bravo La Combattante")
flotillaBravo:AddMissionCapability({AUFTRAG.Type.PATROLZONE}, 80)
flotillaBravo:AddMissionCapability({AUFTRAG.Type.ARTY, AUFTRAG.Type.GROUNDATTACK}, 60)
-- Effective  range of OTO Melara 76 mm gun is 8.6 NM (~16 km).
flotillaBravo:AddWeaponRange(1, 8.6, ENUMS.WeaponFlag.Cannons)
    
-- Create a Fleet.
local fleet=FLEET:New("Warehouse Akrotiri", "Fleet Akrotiri")

-- Set spawn zone.
fleet:SetSpawnZone(zoneAkrotiriSpawn)

-- Set port zone.
fleet:SetPortZone(zoneAkrotiriPort)

-- Add platoons.
fleet:AddFlotilla(flotillaAlpha)
fleet:AddFlotilla(flotillaBravo)

-- All spawned groups will use pathfinding by default.
fleet:SetPathfinding(true)

-- Start brigade.
fleet:Start()

-- Known coordinates of the targets.
local coordAlpha=zoneTargetAlpha:GetCoordinate()
local coordBravo=zoneTargetBravo:GetCoordinate()
local coordCharlie=zoneTargetCharlie:GetCoordinate()
local coordDelta=zoneTargetDelta:GetCoordinate()

-- Fire 30 cannon shots at coordinate of BTR-80 located in zone alpha.
-- We first go to a random point in patrol zone alpha and then relocate to within firing range.
local missionArtyAlpha=AUFTRAG:NewARTY(coordAlpha, 30, 200)
missionArtyAlpha:SetWeaponType(ENUMS.WeaponFlag.Cannons)
missionArtyAlpha:SetMissionWaypointCoord(zonePatrolAlpha:GetRandomCoordinate())

-- Fire 50 cannon shots at the group of Silkworms.
-- First go to the center of patrol zone alpha and then relocate to within firing range.
-- We explicitly assign flotilla bravo for the job.
local missionArtyBravo=AUFTRAG:NewARTY(GROUP:FindByName("Red Silkworm Alpha"), 50, 100)
missionArtyBravo:SetWeaponType(ENUMS.WeaponFlag.Cannons)
missionArtyBravo:SetMissionWaypointCoord(zonePatrolAlpha:GetCoordinate())
missionArtyBravo:AssignCohort(flotillaBravo)

-- Perform a "ground attack" mission on a group of russian ships in zone charlie.
-- We require three asset groups.
local missionAttackCharlie=AUFTRAG:NewGROUNDATTACK(GROUP:FindByName("Ru Ships Alpha"))
missionAttackCharlie:SetRequiredAssets(3)
--missionArtyCharlie:SetMissionRange(1000)

-- Fire 5 cruise missiles at targets located in zone delta.
local missionArtyDelta=AUFTRAG:NewARTY(coordDelta, 5, 500)
missionArtyDelta:SetWeaponType(ENUMS.WeaponFlag.CruiseMissile)
missionArtyDelta:SetMissionWaypointCoord(zonePatrolAlpha:GetRandomCoordinate())

-- Assign missions to fleet.
fleet:AddMission(missionArtyAlpha)
fleet:AddMission(missionArtyBravo)
fleet:AddMission(missionAttackCharlie)
fleet:AddMission(missionArtyDelta)

--- Function called when a navy group is send on a mission.
function fleet:OnAfterNavyOnMission(From, Event, To, NavyGroup, Mission)
  local navygroup=NavyGroup --Ops.NavyGroup#NAVYGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  
  -- Info message.
  local text=string.format("Group %s is on mission %s [%s]", navygroup:GetName(), mission:GetName(), mission:GetType())
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
end
