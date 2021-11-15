---
-- GROUND Transport Direct
-- 
-- A group of two TPz Fuchs is ordered to transport and infantry group from Zone Kobulety X to a nearby Zone Alpha.
-- Another transport APC group of on M113 is ordered to transport the troops from Zone Alpha to Zone Bravo.
-- This mission is very similar to demo mission 012.
-- 
-- However, in this case the troops will not unboard the first carrier. They will remain "inside" the TPz Fuchs
-- and will be directly transferred to the M113.
-- 
-- This can be handy in situations where it is diffcult for troops to unboard.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneAlpha=ZONE:New("Zone Alpha"):DrawZone()
local zoneBravo=ZONE:New("Zone Bravo"):DrawZone()

-- First carrier group.
local carrier1=ARMYGROUP:New("TPz Fuchs Group")
carrier1:Activate()

-- Second carrier group.
local carrier2=ARMYGROUP:New("APC M113")
carrier2:Activate()

-- Set of groups to transport.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
infantryset:Activate()

-- Cargo transport assignment from pickup zone to zone Alpha.
local transport1=OPSTRANSPORT:New(infantryset, zonePickup, zoneAlpha)

-- Directly load into another carrier.
transport1:SetDisembarkCarriers(carrier2)

-- Transport assignment from zone Alpha to zone Bravo.
local transport2=OPSTRANSPORT:New(infantryset, zoneAlpha, zoneBravo)

-- Assign transports to carriers.
carrier1:AddOpsTransport(transport1)
carrier2:AddOpsTransport(transport2)