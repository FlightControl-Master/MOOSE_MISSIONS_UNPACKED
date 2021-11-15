---
-- AIRPLANE: Transport Base to Base
-- 
-- A C-130 is stationed at Kobuleti. It is assigned to transport cargo to Gudauta.
---

-- Hercules 
local c130=FLIGHTGROUP:New("C-130 Kobuleti Bravo")
c130:Activate(1)

-- Define area where troops are unloaded.
c130:SetCarrierUnloaderBack(50, 20)

-- Pickup and deploy zones.
local zonePickup=ZONE_AIRBASE:New("Kobuleti", 5000)
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Gudauta, 5000)

-- Cargo set.
local cargoset=SET_OPSGROUP:New():FilterPrefixes("Tank Platoon Kobuleti Alpha"):FilterOnce()
cargoset:Activate()

-- Cargo transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)

-- Add cargo transport.
c130:AddOpsTransport(transport)