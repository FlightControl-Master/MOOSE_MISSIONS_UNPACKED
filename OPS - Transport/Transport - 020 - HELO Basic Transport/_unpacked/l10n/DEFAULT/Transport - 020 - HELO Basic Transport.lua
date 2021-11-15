---
-- HELO: Basic Transport
-- 
-- Two Huey groups are stationed at FARP Berlin. Both are assigned to pickup troops at zone Kobuleti X and deliver them to zone Bravo. 
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X")
local zoneDeploy=ZONE:New("Zone Bravo")

-- Cargo set.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
  infantryset:Activate()
 
  -- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New(infantryset, zonePickup, zoneDeploy)

-- Huey Carrier.
local hueyAlpha1=FLIGHTGROUP:New("UH-1H Alpha-1")
hueyAlpha1:Activate()

-- Cargo transport assignment to first Huey group.
hueyAlpha1:AddOpsTransport(opstransport)


-- Huey Carrier.
local hueyAlpha2=FLIGHTGROUP:New("UH-1H Alpha-2")
hueyAlpha2:Activate()

-- Add transport to second Huey.    
hueyAlpha2:AddOpsTransport(opstransport)