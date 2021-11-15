---
-- GROUND Transport Waiting
-- 
-- A group of two TPz Fuchs is ordered to transport and infantry group from Zone Kobulety X to a nearby Zone Alpha.
-- The infantry troops were just involved in a fire fight and are now returning to the briefed pickup zone.
-- Once the troops arrive in the pickup zone, the carrier will go there to pick them up.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneDeploy=ZONE:New("Zone Alpha"):DrawZone()

-- Carrier group.
local carrier=ARMYGROUP:New("TPz Fuchs Group")
carrier:Activate()
  
-- Infantry group to be transported.
local infantry=ARMYGROUP:New("Infantry Platoon Bravo-1")
infantry:Activate()

-- Add waypoint to make the group move to the pickup zone.
infantry:AddWaypoint(zonePickup:GetRandomCoordinate())

-- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New(infantry, zonePickup, zoneDeploy)

-- Assign transport to carrier.
carrier:AddOpsTransport(opstransport)

--- Function called when transport was delivered or everyone (remaining) is dead.
function opstransport:OnAfterDelivered(From, Event, To)
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", opstransport.uid, opstransport.Ncargo, opstransport.Ndelivered)
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end