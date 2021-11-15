---
-- HELO: Zone to Airbase from FARP
-- 
-- Huey group stationed at Farp Berlin picks up cargo in Zone Kobuleti X and delivers them
-- to Kobuleti airbase.
-- 
-- Note that the deploy zone is a ZONE_AIRBASE object!
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Kobuleti):DrawZone()

-- Cargo set.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha-1"):FilterOnce()
infantryset:Activate()
 
-- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New(infantryset, zonePickup, zoneDeploy)

-- Huey Carrier.
local hueyAlpha1=FLIGHTGROUP:New("UH-1H Alpha-1")
hueyAlpha1:Activate()

-- Cargo transport assignment to the Huey group.
hueyAlpha1:AddOpsTransport(opstransport)