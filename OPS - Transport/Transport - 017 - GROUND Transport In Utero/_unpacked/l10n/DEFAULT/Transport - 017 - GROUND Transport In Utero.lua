---
-- GROUND Transport In Utero
-- 
-- A group of two TPz Fuchs is ordered to transport and infantry group from Zone Kobulety X to a nearby Zone Alpha.
-- 
-- Another group of one M-113 APC is ordered to pick up the troops at zone Alpha and transport them to zone Bravo.
-- The second transport is scheduled to start at 0915 hours.
-- 
-- When the troops are unloaded in zone Alpha, they are NOT spawned inside the deploy zone Alpha. Instead they remain "in utero".
-- This can be handy in cases where spawning groups is difficult. For example, ground groups cannot be spawned on ships or oil-rigs.
-- In DCS the groups would fall through the ship into the sea.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X")
local zoneAlpha=ZONE:New("Zone Alpha")
local zoneBravo=ZONE:New("Zone Bravo")

-- Carrier group.
local carrier1=ARMYGROUP:New("TPz Fuchs Group")
carrier1:Activate()

-- Carrier group.
local carrier2=ARMYGROUP:New("APC M113")
carrier2:Activate()

-- Set of groups to transport.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
infantryset:Activate()

-- Cargo transport assignment.
local transport1=OPSTRANSPORT:New(infantryset, zonePickup, zoneAlpha)

-- Troops are not spawned after disembarkment. They remain in state "InUtero".
transport1:SetDisembarkInUtero(true)  
  
-- Second transport assignment. Scheduled for 0915 hours.
local transport2=OPSTRANSPORT:New(infantryset, zoneAlpha, zoneBravo)
transport2:SetTime("9:15")

-- Assign transports to carriers.
carrier1:AddOpsTransport(transport1)
carrier2:AddOpsTransport(transport2)