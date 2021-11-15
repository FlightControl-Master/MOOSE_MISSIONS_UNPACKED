---
-- NAVAL: Transport Ship-to-Ship but ferry ships are transported as well.
-- 
-- Three speed boats are used to transfer troops from the beach to a bigger transport ship.
-- Only one is actually needed to transport all troops.
-- 
-- Once the speed boat has finished its transport assignment, all three speed boats are
-- loaded into the Handy Wind as well.
-- 
-- All cargo is then transported to the deploy zone.
-- 
-- At the deploy zone, the speed boats will then transfer the troops from the Handy Wind
-- to the shore.
---

-- Zones.
local zonePickup=ZONE:New("Zone Sea Alpha"):DrawZone()
local zoneDeploy=ZONE:New("Zone Sea Bravo"):DrawZone()

-- Surf zones near the shores. This is where the speed boats will go to pickup and deploy the infantry groops.
local zoneSurfA=ZONE:New("Zone Surf Alpha"):DrawZone()
local zoneSurfB=ZONE:New("Zone Surf Bravo"):DrawZone()

-- Embark and disembark zones for infantry.
local zoneEmbark=ZONE:New("Zone Shore Alpha"):DrawZone()
local zoneDisembark=ZONE:New("Zone Shore Bravo"):DrawZone()

-- Carrier group.
local handywind=NAVYGROUP:New("Handy Wind")
handywind:Activate()

-- Infantry group set.
local InfantrySet=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Delta-1"):FilterOnce()
InfantrySet:Activate()

-- Speed boat group set.
local SpeedboatSet=SET_OPSGROUP:New():FilterPrefixes("Speed Boat Alpha"):FilterOnce()
SpeedboatSet:Activate()

-- All cargo groups of the main transport.
local AllCargo=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Delta-1"):FilterPrefixes("Speed Boat Alpha"):FilterOnce()

---
-- Transfer from Shore Alpha to Pickup zone
---

-- Transport assignment for Speedboat: Pickup Infantry and deliver to pick up zone of Handy wind.
local transfer1=OPSTRANSPORT:New(InfantrySet, zoneSurfA, zonePickup)

-- Set embark and disembark zone. These are the zones where the troops are supposed to be.
transfer1:SetEmbarkZone(zoneEmbark)

-- Direct disembark to Handy Wind.
transfer1:SetDisembarkCarriers(handywind)

--- Function called when all cargo groups have beed delivered.
function transfer1:OnAfterDelivered()
  -- Ensure that all carriers are inside the pickup zone.
  local carriers=transfer1:GetCarriers()
  for _,_carrier in pairs(carriers) do
    local carrier=_carrier --Ops.NavyGroup#NAVYGROUP
    if not carrier:IsInZone(zonePickup) then
      carrier:AddWaypoint(zonePickup:GetRandomCoordinate())
    end
  end
end

---
-- Transport from Pickup to Deploy zone
---

-- Transport assignment.
local transport=OPSTRANSPORT:New(SpeedboatSet, zonePickup, zoneDeploy)

-- We add the Infantry troops as well, but set them to be unloaded in late activated state so they dont float on the water.
transport:AddCargoGroups(InfantrySet, nil, false)

-- Set that all cargo is required before transport of the FIRST batch starts. Handy Wind is large enough to carry everything in one go.
transport:SetRequiredCargos(AllCargo)

---
-- Transfer from Deploy zone zo Shore Bravo
---

-- Transport assignment.
local transfer2=OPSTRANSPORT:New(InfantrySet, zoneDeploy, zoneSurfB)
transfer2:SetDisembarkZone(zoneDisembark)
transfer2:SetRequiredCargos(InfantrySet)
transfer2:AddConditionStart(
function()
  return (transport:IsDelivered() and transport:GetNcargoDelivered()>0)
end)
  
 
-- Assign transport to carrier.
SpeedboatSet:ForEach(
function(speedboat)
  speedboat:AddOpsTransport(transfer1)
  speedboat:AddOpsTransport(transfer2)
end)
 
   -- Assign transport to carrier.
handywind:AddOpsTransport(transport)