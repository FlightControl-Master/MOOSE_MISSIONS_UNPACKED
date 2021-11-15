---
-- TPZ: Ground 
-- 
-- A BTR-80 is assigned to transport infantry troops.
-- The troops are supposed to be picked up in two different areas.
-- 
-- To this end, we use "Transport Zone Combos" (TZC), which allow to
-- specify different pickup and/or deploy zones within the transport assignment.
---

-- Pickup and deploy zones.
local zonePickupAlpha=ZONE:New("Zone Novorossiysk Alpha"):DrawZone()
local zonePickupBravo=ZONE:New("Zone Novorossiysk Bravo"):DrawZone()
local zoneDeploy=ZONE:New("Zone Delta"):DrawZone()

-- Carrier.
local carrier1=ARMYGROUP:New("BTR-Alpha-1")
carrier1:Activate()

-- Set of groups to transport.
local infantrysetAlpha=SET_OPSGROUP:New():FilterPrefixes("Infantry AK-74 Alpha"):FilterOnce()
infantrysetAlpha:Activate()

-- Set of groups to transport.
local infantrysetBravo=SET_OPSGROUP:New():FilterPrefixes("Infantry AK-74 Bravo"):FilterOnce()
infantrysetBravo:Activate()


-- Cargo transport assignment to transport troops from pickup Alpha to the deploy zone.
local opstransport=OPSTRANSPORT:New(infantrysetAlpha, zonePickupAlpha, zoneDeploy)

-- Add a Transport Zone Combo (TZC) to transport troops from pickup zone Bravo. 
local tpz1=opstransport:AddTransportZoneCombo(infantrysetBravo, zonePickupBravo, zoneDeploy)
  
-- Assign transport to carrier.
carrier1:AddOpsTransport(opstransport)


--- Function called when transport was delivered or everyone (remaining) is dead.
function opstransport:OnAfterDelivered(From, Event, To)
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", opstransport:GetUID(), opstransport:GetNcargoTotal(), opstransport:GetNcargoDelivered())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end