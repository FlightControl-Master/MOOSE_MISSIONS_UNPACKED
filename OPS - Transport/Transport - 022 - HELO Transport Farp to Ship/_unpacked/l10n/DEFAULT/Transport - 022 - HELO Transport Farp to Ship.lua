---
-- HELO: FARP to Ship
-- 
-- A Huey group is ordered to transport troops from Farp Berlin to the USS Shiloh.
-- 
-- As ground groups can "stand" on ships in DCS, the troops are directly loaded into
-- the cargo bay of the ship.
-- 
-- NOTE that the deploy zone of the ship is a ZONE_AIRBASE object.
-- Only if it is a ZONE_AIRBASE the helo will land on the landing platform of the ship.
---

-- Carrier.
local huey=FLIGHTGROUP:New("UH-1H Alpha-1")
huey:Activate(1)

-- Destination.  
local ship=NAVYGROUP:New("Ticonderoga Alpha")
ship:Activate()

-- Pickup and deploy zones. Must be ZONE_AIRBASEs!
local zonePickup=ZONE_AIRBASE:New("Farp Berlin")
local zoneDeploy=ZONE_AIRBASE:New("USS Shiloh")

-- Cargo set.
local infset=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Charlie"):FilterOnce()
  infset:Activate()
 
  -- Create a transport assignment from FARP to Ship. The cargo is directly transferred into the carrier! 
local transport=OPSTRANSPORT:New(infset, zonePickup, zoneDeploy)

-- Assign transport to Huey.
huey:AddOpsTransport(transport)