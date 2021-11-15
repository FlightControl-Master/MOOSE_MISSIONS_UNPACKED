---
-- NAVAL Basic Transport
-- 
-- The USS Shiloh is ordered to transport infantry from Zone Shore Alpha to Zone Shore Bravo.
-- 
-- Firstly, we need the usual pickup and deloy zones. These are the zones where the ship will go.
-- 
-- As ships obviously cannot pickup troops on land and ground groups are not good at swimming.
-- Therefore, we define embark and disembark zones. These are the zones where the troops are 
-- supposed to wait for their transport.
-- 
-- If embark and/or disembark zones are defined, the troops need to be in these zones rather than
-- the pickup and deploy zones to be considered for transport.
-- 
-- Note that embark and disembark zones can also be used for ARMY- and FLIGHTGROUP carriers.
---

-- Zones.
local zonePickup=ZONE:New("Zone Sea Alpha"):DrawZone()
local zoneDeploy=ZONE:New("Zone Sea Bravo"):DrawZone()
local zoneEmbark=ZONE:New("Zone Shore Alpha"):DrawZone()
local zoneDisembark=ZONE:New("Zone Shore Bravo"):DrawZone()

-- Carrier group.
local carrier=NAVYGROUP:New("Ticonderoga Alpha")
carrier:Activate()

-- Infantry cargo group.
local CargoGroup=GROUP:FindByName("Infantry Platoon Delta-1")
CargoGroup:Activate()

-- Transport assignment.
local transport=OPSTRANSPORT:New(CargoGroup, zonePickup, zoneDeploy)

-- Set embark and disembark zone. These are the zones where the troops are supposed to be.
transport:SetEmbarkZone(zoneEmbark)
transport:SetDisembarkZone(zoneDisembark)

-- Assign transport to carrier.
carrier:AddOpsTransport(transport)