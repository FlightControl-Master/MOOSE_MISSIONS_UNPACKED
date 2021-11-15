---
-- COMBINED FORCES: Helo Pickup from Ship
-- 
-- Seawise Giant has infantry loaded. A Mi-8 is assigned to pickup the troops
-- and transport them to a nearby oil rig.
-- 
-- When unloaded, the troops are spawned in late activated state because they
-- cannot stand on the oil rig. They could be picked up later by another transport.
---

-- Zones.
local zoneSeawise=ZONE_AIRBASE:New("Seawise Giant")
local zoneRigShell=ZONE_AIRBASE:New("Oil Rig Shell")

-- Mi-8 carrier group.
local mi8shell=FLIGHTGROUP:New("Mi-8 Shell")
mi8shell:Activate()  

-- Seawise carrier group.
local seawise=NAVYGROUP:New("Seawise Giant")


-- Infantry cargo group.
local CargoGroupSet=SET_OPSGROUP:New():FilterPrefixes("Infantry Platoon Delta"):FilterOnce()
CargoGroupSet:Activate()

-- Load all groups into the Seawise Giant
CargoGroupSet:ForEach(function(opsgroup)
  seawise:__Load(5, opsgroup)
end )

-- Transport assignment.
local transport=OPSTRANSPORT:New(CargoGroupSet, zoneSeawise, zoneRigShell)

-- When disembared, the groups remain inactive since ground groups cannot "stand" on an oil rig. They would fall into the water.
transport:SetDisembarkActivation(false)

-- Add transport assignment.
mi8shell:AddOpsTransport(transport)

--- Function called when a group has been unloaded.
function transport:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier)
  local opsgroup=OpsGroupCargo --Ops.OpsGroup#OPSGROUP
  opsgroup:GetCoordinate():MarkToAll(string.format("Unloaded group %s", opsgroup:GetName()))
end