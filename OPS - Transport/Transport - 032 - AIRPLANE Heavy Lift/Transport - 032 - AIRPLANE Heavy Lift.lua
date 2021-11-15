---
-- AIRPLANE: Heavy Lift
-- 
-- A C-17 is stationed at Kobuleti. It is assigned to transport cargo to Gudauta.
-- 
-- The cargo consists of
-- 
-- * 2 M2 Bradley (total weight 42,600 kg)
-- * 3 M1126 Stryker (total weight 51711 kg)
-- * 1 M1 Abrams (total weight 57154 kg)
-- 
-- Note that the cargo capacity of the C-17 heavily depends on its internal fuel.
-- When full, its interal fuel ways 132,000 kg.
-- If fully loaded, it can only carry 7,300 kg payload.
-- If fuel is only half full, it can carry 73,000 kg payload.
---

-- Hercules 
local c17=FLIGHTGROUP:New("C-17A Kobuleti Alpha")
c17:Activate(1)

-- Define area where troops are unloaded.
c17:SetCarrierUnloaderBack(50, 20)

-- Pickup and deploy zones.
local zonePickup=ZONE_AIRBASE:New("Kobuleti", 5000)
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Gudauta, 5000)

-- Cargo set.
local cargoset=SET_OPSGROUP:New():FilterPrefixes("Tank Platoon Kobuleti Delta"):FilterOnce()
cargoset:Activate()

-- Cargo transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)
transport:SetVerbosity(3)

-- Add cargo transport.
c17:AddOpsTransport(transport)