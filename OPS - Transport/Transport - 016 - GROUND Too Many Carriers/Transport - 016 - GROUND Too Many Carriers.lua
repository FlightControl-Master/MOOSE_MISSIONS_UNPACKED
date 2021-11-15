---
-- GROUND Too many carriers
-- 
-- Two carriers are assigned to transport troops. The cargo already fits into one of the carriers.
-- 
-- Both carriers will drive to the pickup zone. All cargo will be loaded into one carrier.
-- The second carrier will wait at the pickup zone in case more cargo is added to the transport.
-- 
-- Once the first carrier has delivered all cargo, both carriers will return to their initial position.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Engage X")
local zoneAlpha=ZONE:New("Zone Kobuleti X")

-- First carrier.
local carrier1=ARMYGROUP:New("AAV-7-1")
carrier1:Activate()

-- Second carrier.
local carrier2=ARMYGROUP:New("AAV-7-2")
carrier2:Activate()

-- Set of groups to transport.
local infantryset=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Echo"):FilterOnce()
infantryset:Activate()

-- Cargo transport assignment.
local transport=OPSTRANSPORT:New(infantryset, zonePickup, zoneAlpha)
transport:SetVerbosity(3)

-- Assign transport to carriers.
carrier1:AddOpsTransport(transport)
carrier2:AddOpsTransport(transport)