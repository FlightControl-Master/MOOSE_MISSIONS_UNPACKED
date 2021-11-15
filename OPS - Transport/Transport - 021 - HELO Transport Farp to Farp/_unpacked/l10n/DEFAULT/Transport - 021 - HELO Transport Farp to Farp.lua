---
-- HELO: Transport FARP to FARP
-- 
-- A Huey group is stationed at Farp Berlin.
-- It is assigned to transport Infantry groups from Farp Berlin to Farp London.
-- 
-- *** IMPORTANT ***
-- 
-- Note that both the pickup and the deploy zones are ZONE_AIRBASE type objects here!
-- If a pickup or deploy zone is a ZONE_AIRBASE instead of a ZONE, aircraft will land
-- at the airbase parkings for pickup or deployment of cargo.
---

-- Carrier group.
local huey=FLIGHTGROUP:New("UH-1H Alpha-1")

-- Pickup and deploy zones. Both are ZONE_AIRBASES so the helo lands at the airbase.
local zonePickup=ZONE_AIRBASE:New("Farp Berlin")
local zoneDeploy=ZONE_AIRBASE:New("Farp London")

-- Cargo set.
local cargoset=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Charlie"):FilterOnce()  --Core.Set#SET_OPSGROUP
cargoset:Activate()

-- Transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)

-- Assign transport to Huey.
huey:AddOpsTransport(transport)