---
-- GROUND Transport Chain
-- 
-- A group of two TPz Fuchs is ordered to transport and infantry group from Zone Kobulety X to a nearby Zone Alpha.
-- Another transport APC group of on M113 is ordered to transport the troops from Zone Alpha to Zone Bravo.
-- 
-- The second transport will start once the first has been delivered.
-- The M113 is not able to pickup all troops at once and has to go multiple times beteen pickup and deploy zone.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneAlpha=ZONE:New("Zone Alpha"):DrawZone()
local zoneBravo=ZONE:New("Zone Bravo"):DrawZone()

-- Carrier group A.
local carrierA=ARMYGROUP:New("TPz Fuchs Group")
carrierA:Activate()

-- Carrier group B.
local carrierB=ARMYGROUP:New("APC M113")
carrierB:Activate()

  
-- Set of groups to transport.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
infantryset:Activate()  


-- Cargo transport assignment from pickup zone to zone Alpha.
local opstransportA=OPSTRANSPORT:New(infantryset, zonePickup, zoneAlpha)
  
-- Assign transport A to carrier A.
carrierA:AddOpsTransport(opstransportA)


-- Cargo transport assignment from zone Alpha to zone Bravo.
local opstransportB=OPSTRANSPORT:New(infantryset, zoneAlpha, zoneBravo)
  
-- Add start condition that first transport was delivered.
opstransportB:AddConditionStart(function()
  return (opstransportA:IsDelivered() and opstransportA:GetNcargoDelivered()>0)
end)
  
-- Assign transport B to carrier B.
carrierB:AddOpsTransport(opstransportB)