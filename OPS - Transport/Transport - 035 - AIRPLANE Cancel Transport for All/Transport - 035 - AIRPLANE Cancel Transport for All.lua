---
-- AIRPLANE: Cancel Transport for All
-- 
-- Two Hercules stationed at Kobuleti are assigned to transport cargo from Gudauta to Senaki.
-- 
-- After 10 min there is a change of plan the transport is cancelled.
-- All assigned carriers will RTB to their home base.
---

-- Hercules at Kobuleti. 
local c130bravo=FLIGHTGROUP:New("C-130 Kobuleti Bravo")
c130bravo:SetCarrierUnloaderBack(50, 20)
c130bravo:Activate(1)

-- Hercules at Kobuleti. 
local c130charlie=FLIGHTGROUP:New("C-130 Kobuleti Charlie")
c130charlie:SetCarrierUnloaderBack(50, 20)
c130charlie:Activate(1)  

-- Pickup and deploy zones.
local zonePickup=ZONE_AIRBASE:New(AIRBASE.Caucasus.Gudauta, 5000)
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Senaki_Kolkhi, 5000)

-- Cargo set.
local cargoset=SET_OPSGROUP:New():FilterPrefixes("Tank Platoon Gudauta Alpha"):FilterOnce()
cargoset:Activate()

-- Cargo transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)

-- Add cargo transport.
c130bravo:AddOpsTransport(transport)
c130charlie:AddOpsTransport(transport)

-- Cancel the transport
transport:__Cancel(10*60)