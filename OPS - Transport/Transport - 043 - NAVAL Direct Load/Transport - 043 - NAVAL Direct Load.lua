---
-- NAVAL: Direct Load
-- 
-- The Seawise Giant is coming from far, far away and delivers cargo toops to an oil rig.
-- 
-- For lack of time, we do not want to simulate the whole transport process. So the cargo groups are placed
-- anywhere on the map and directly loaded into the Seawise, which is already close to its destination.
-- 
-- As ground troops cannot stand on oil rigs, the disembarkment happens "in utero", i.e. troops are not spawned.
-- But they could be picked up later by a helo, for instance, and be delivered to another destination.
---

-- Zones.
local zoneSeawise=ZONE_GROUP:New("Seawise", GROUP:FindByName("Seawise Giant"), 1000)
local zoneShell=ZONE:New("Zone Shell"):DrawZone()

-- Carrier group.
local seawise=NAVYGROUP:New("Seawise Giant")
seawise:Activate()
seawise:SetVerbosity(2)


-- Infantry cargo group.
local CargoGroup=SET_GROUP:New():FilterPrefixes("Infantry Platoon Delta"):FilterOnce()
CargoGroup:Activate()

-- Transport assignment.
local transport=OPSTRANSPORT:New(CargoGroup, zoneSeawise, zoneShell)
transport:SetVerbosity(3)
transport:SetDisembarkInUtero()

-- Add transport assignment.
seawise:AddOpsTransport(transport)

-- Load all defined cargo.  
for _,_opsgroup in pairs(transport:GetCargoOpsGroups(false)) do
  seawise:__Load(30, _opsgroup)
end

--- Function called when carrier loaded all cargo.
function seawise:OnAfterLoaded(From, Event, To, OpsGroupCargo)
  local opsgroup=OpsGroupCargo --Ops.OpsGroup#OPSGROUP
  env.info(string.format("Loaded opsgroup %s", opsgroup:GetName()))
end

--- Function called when carrier unloaded a cargo group.
function seawise:OnAfterUnloaded(From, Event, To, OpsGroupCargo)
  local opsgroup=OpsGroupCargo --Ops.OpsGroup#OPSGROUP
  local text=string.format("Unloaded opsgroup %s", opsgroup:GetName())
  env.info(text)
  opsgroup:GetCoordinate():MarkToAll(text)
end