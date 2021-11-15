---
-- GROUND Cargo Dead
-- 
-- A TPz Fuchs group is assigned to transport cargo.
-- While the carrier is on its way to pickup the cargo, all cargo is destroyed.
-- 
-- When the cargo is dead, the carrier will abort the transport and return to its initial position.
-- 

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X")
local zoneDeploy=ZONE:New("Zone Alpha")

-- Carrier.
local carrier=ARMYGROUP:New("TPz Fuchs Group")
carrier:Activate()

-- Set of groups to transport.
local infantryset=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
infantryset:Activate()

-- Destroy all cargo after 60 seconds.
infantryset:ForEach(function(_opsgroup)
  local opsgroup=_opsgroup --Ops.ArmyGroup#ARMYGROUP
  opsgroup:SelfDestruction(60)
end
)

-- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New(infantryset, zonePickup, zoneDeploy)

-- Assign transport to carrier.
carrier:AddOpsTransport(opstransport)


--- Function called when transport was delivered or everyone (remaining) is dead.
function opstransport:OnAfterDelivered(From, Event, To)
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", opstransport:GetUID(), opstransport:GetNcargoTotal(), opstransport:GetNcargoDelivered())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end