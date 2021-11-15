---
-- GROUND Transport with Mission
-- 
-- TPz Fuchs groups is assigned to transport an infantry group from Kobuleti Town to zone Alpha.
-- 
-- However, the carriers are currently on a mission to patrol zone Engage X. They will not conduct any transport
-- assignments until that mission is over. The patrol mission is scheduled to end at 0910 hours.
-- 
-- Also, the infantry is currently on a mission. It will not be transported until that mission is over.
-- The mission ends at 0920 hours.
-- 
-- The carriers are assigned to carry out another patrol mission in zone Kobuleti X. That mission starts at 0915 hours
-- and ends at 0940 hours. When the mission starts, the carriers are still busy with the transport. The mission will not
-- start until all cargo has been delivered. 
-- 

-- Zones.
local zonePickup=ZONE:New("Zone Kobuleti Town"):DrawZone()
local zoneDeploy=ZONE:New("Zone Alpha"):DrawZone()
local zoneKobuletiX=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneEngageX=ZONE:New("Zone Engage X"):DrawZone()

-- Mission to patrol Zone Engage X until 0910 hours.
local missionPatrol1=AUFTRAG:NewPATROLZONE(zoneEngageX)
missionPatrol1:SetTime(nil, "9:10")

-- Mission to patrol Zone Kobuleti X form 0915 to 0940 hours.
local missionPatrol2=AUFTRAG:NewPATROLZONE(zoneKobuletiX)
missionPatrol2:SetTime("9:15", "9:40")
  
-- Mission to stand guard until 0920 hours.
local missionGuard=AUFTRAG:NewONGUARD(zonePickup:GetCoordinate())
missionGuard:SetTime(nil, "9:20")

-- Cargo group.
local infantry=ARMYGROUP:New("Infantry Platoon Bravo-1"):Activate()

-- Add mission to cargo group.
infantry:AddMission(missionGuard)

-- Carrier group.
local carrier=ARMYGROUP:New("AAV-7-1"):Activate()

-- Transport assignment.  
local transport=OPSTRANSPORT:New(infantry, zonePickup, zoneDeploy)

-- Add transport to carrier.
carrier:AddOpsTransport(transport)

-- Add patrol missions to carrier.
carrier:AddMission(missionPatrol1)
carrier:AddMission(missionPatrol2)