---
-- NAVAL: Transport Ship-to-Ship
-- 
-- A speed boat is used to transfer troops from the beach to the bigger transport ship.
-- The speed boat needs to go two times to deliver all troops.
-- 
-- Once the speed boat has finished its transport assignment, the Handy Wind will transport
-- the troops to another deploy zone.
---

-- Zones.
local zonePickup=ZONE:New("Zone Sea Alpha"):DrawZone()
local zoneDeploy=ZONE:New("Zone Sea Bravo"):DrawZone()
local zoneSurf=ZONE:New("Zone Surf Alpha"):DrawZone()
local zoneEmbark=ZONE:New("Zone Shore Alpha"):DrawZone()
local zoneDisembark=ZONE:New("Zone Shore Bravo"):DrawZone()

-- Carrier group.
local speedboat=NAVYGROUP:New("Speed Boat Alpha-1")
speedboat:Activate()

-- Carrier group.
local handywind=NAVYGROUP:New("Handy Wind")
handywind:Activate()

-- Infantry cargo group.
local CargoGroup=SET_GROUP:New():FilterPrefixes("Infantry Platoon Delta"):FilterOnce()
CargoGroup:Activate()

-- Transport assignment to deliver 
local transfer=OPSTRANSPORT:New(CargoGroup, zoneSurf, zonePickup)

-- Set embark and disembark zone. These are the zones where the troops are supposed to be.
transfer:SetEmbarkZone(zoneEmbark)

-- Direct disembark to Handy Wind. The Handy wind has to be in the pickup zone for the
-- cargo groups to be transferred from the speed boats.
transfer:SetDisembarkCarriers(handywind)

-- Assign transport to carrier.
speedboat:AddOpsTransport(transfer)


-- Transport assignment.
local transport=OPSTRANSPORT:New(CargoGroup, zonePickup, zoneDeploy)

-- Set disembark zone.
transport:SetDisembarkZone(zoneDisembark)

-- Set required cargos. These group(s) need to be loaded before the _first_ transport starts.
-- Here this is advisable because the speed boats cannot transport all infantry in one go.
-- If this is not set, the Hany wind would already start the transport when the first
-- batch of cargo has been loaded.
transport:SetRequiredCargos(CargoGroup)
 
   -- Assign transport to carrier.
handywind:AddOpsTransport(transport)