---
-- GROUND Carrier Dead
-- 
-- A group of two TPz Fuchs is ordered to transport and infantry group from Zone Kobulety X to a nearby Zone Alpha.
-- 
-- Before the carrier can pickup the cargo, it is destroyed.
-- 
-- When the carrier is destroyed, it is respawned and the transport is assigned to the carrier again.
-- 
-- Once the carrier has loaded the cargo and starts its transport, it is destroyed again.
-- The loaded cargo is also destroyed.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X")
local zoneAlpha=ZONE:New("Zone Alpha")

-- Carrier group.
local carrier=ARMYGROUP:New("TPz Fuchs Group")
carrier:Activate()

-- After 30 seconds the carrier is destroyed.
carrier:SelfDestruction(30)

-- Set of groups to transport.
local infantryset=SET_GROUP:New():FilterPrefixes("Infantry Platoon Alpha"):FilterOnce()
infantryset:Activate()

-- Cargo transport assignment.
local transport=OPSTRANSPORT:New(infantryset, zonePickup, zoneAlpha)
transport:SetVerbosity(3)
    
-- Assign transports to carriers.
function carrier:OnAfterSpawned(From,Event,To)
  env.info("Carrier spawned!")
  if transport and not transport:IsDelivered() then
    env.info("Assigning transport to carrier...")
    carrier:AddOpsTransport(transport)
  end
end  

--- Function called after a carrier group is dead.
function transport:OnAfterDeadCarrierGroup(From, Event, To, OpsGroup)
  local opsgroup=OpsGroup --Ops.ArmyGroup#ARMYGROUP
  local text=string.format("Carrier group %s is DEAD!", opsgroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
  
  -- Respawn group after 60 seconds.
  opsgroup:__Respawn(60)
end

--- Function called after all assigned carriers are dead.
function transport:OnAfterDeadCarrierAll(From, Event, To)
  local text=string.format("All Carriers of transport UID=%d are DEAD!", transport:GetUID())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)  
end

--- Function called after all cargo was delivered OR is dead!
function transport:OnAfterDelivered(From, Event, To)
  local text=string.format("Transport UID=%d DELIVERED! Number of delivered cargo groups %d of %d", transport:GetUID(), transport:GetNcargoDelivered(), transport:GetNcargoTotal())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)  
end  

--- Function called after the carrier started transporting troops.
function carrier:OnAfterTransport(From,Event,To)
  -- Destroy carrier. The loaded cargo is also destroyed.
  carrier:SelfDestruction(60)
end