---
-- HELO: Respawn after Destroyed
-- 
-- Huey is ordered to transport infantry.
-- 
-- Before the cargo can be loaded, the enemy destroyes the Huey.
-- The group is then respawned and the transport is newly assigned.
-- 
-- The respawned huey is really unlucky and gets destroyed again
-- 60 seconds after taking off. This also destroyes the loaded cargo groups.
-- However, it seems to have seven lifes and gets respawned again.
-- The remaining infantry group is loaded and safely delivered to the deploy zone.
---

-- Carrier group.
local huey=FLIGHTGROUP:New("UH-1H Alpha-1")

-- Pickup and deploy zones. Both are ZONE_AIRBASES so the helo lands at the airbase.
local zonePickup=ZONE_AIRBASE:New("Farp Berlin")
local zoneDeploy=ZONE_AIRBASE:New("Farp London")

-- Cargo set.
local cargoset=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Charlie"):FilterOnce()  --Core.Set#SET_OPSGROUP
cargoset:Activate()

-- Transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)

-- Assign transport to Huey.
huey:AddOpsTransport(transport)

-- Destroy the helo group.
huey:SelfDestruction(90)

--- Function called after the helo is destroyed.
function huey:OnAfterDestroyed(From, Event, To)
  huey:__Respawn(-1)
end

--- Also destroy the huey once when airborne.
local destroymeonce=true
function huey:OnAfterAirborne()
  if destroymeonce then
    huey:SelfDestruction(60)
    destroymeonce=false
  end
end

--- Function called when the carrier group is dead.
function transport:OnAfterDeadCarrierGroup(From, Event, To, OpsGroup)
  local flightgroup=OpsGroup --Ops.OpsGroup#OPSGROUP      
  flightgroup:AddOpsTransport(transport)
end