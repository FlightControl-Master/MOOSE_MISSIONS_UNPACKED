---
-- GROUND Basic Transport
-- 
-- A group of two TPz Fuchs transports infantry groups from Zone Kobulety X to a nearby Zone Alpha.
-- 
-- Once all troops were delivered, the carrier returns to its original position.
-- 
-- This script also contains many FSM events that are triggered when a carrier loads/unloads cargo and when groups are being loaded/unloaded.
-- 
-- NOTE that:
--  - Troops to be transported MUST be in the pickup zone. If not, they will not be considered for transport until they enter the zone!
--  - If a group is too heavy for the assigned transports, it will not be transported. Each group must fit into one UNIT of the group.
---

-- Pickup and deploy zones.
local zonePickup=ZONE:New("Zone Kobuleti X"):DrawZone()
local zoneDeploy=ZONE:New("Zone Alpha"):DrawZone()

-- Carrier group.
local carrier=ARMYGROUP:New("TPz Fuchs Group")
carrier:Activate()
  
-- Cargo group.  
local infantry=ARMYGROUP:New("Infantry Platoon Alpha-1")
infantry:Activate()

-- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New(infantry, zonePickup, zoneDeploy)

-- Assign transport to carrier.
carrier:AddOpsTransport(opstransport)

---
-- FSM events of the OPSTRANSPORT
---

--- Function called when an OPSGROUP is loaded into a carrier.
function opstransport:OnAfterLoaded(From, Event, To, CargoOpsGroup, CarrierOpsGroup, CarrierElement)
  local cargoopsgroup=CargoOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrieropsgroup=CarrierOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrier=CarrierElement   --Ops.OpsGroup#OPSGROUP.Element

  -- Info message.
  local text=string.format("Transport UID=%d opsgroup %s loaded into carrier %s", opstransport:GetUID(), cargoopsgroup:GetName(), carrier.name)
  MESSAGE:New(text, 60):ToAll()
  env.info(text)

end

--- Function called when an OPSGROUP is unloaded from the carrier.
function opstransport:OnAfterUnloaded(From, Event, To, CargoOpsGroup, CarrierOpsGroup)
  local cargoopsgroup=CargoOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrieropsgroup=CarrierOpsGroup --Ops.ArmyGroup#ARMYGROUP
  
  -- Info message.
  local text=string.format("Transport UID=%d unloaded opsgroup %s from carrier group %s", opstransport:GetUID(), cargoopsgroup:GetName(), carrieropsgroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
  
  -- OPSGROUP is ready for further actions. Put up green smoke.
  cargoopsgroup:GetGroup():SmokeGreen()
  
end

--- Function called when transport was delivered or everyone (remaining) is dead.
function opstransport:OnAfterDelivered(From, Event, To)
  -- Info Message
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", opstransport:GetUID(), opstransport:GetNcargoTotal(), opstransport:GetNcargoDelivered())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

---
-- FSM events for carrier groups
---

--- Function called when a carrier has loaded a cargo group.
function carrier:OnAfterLoaded(From, Event, To, CargoGroup)
  local cargogroup=CargoGroup --Ops.OpsGroup#OPSGROUP

  -- Info Message
  local text=string.format("Group %s loaded group %s", carrier:GetName(), cargogroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)            
end

--- Function called when a carrier has unloaded a cargo group.
function carrier:OnAfterUnloaded(From, Event, To, CargoGroup)
  local cargogroup=CargoGroup --Ops.OpsGroup#OPSGROUP

  -- Info Message
  local text=string.format("Group %s unloaded group %s", carrier:GetName(), cargogroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)            
end


--- Function called when carrier goes to pickup cargo.
function carrier:OnAfterPickup(From,Event,To)
  -- Info Message
  local text=string.format("Group %s is picking up cargo...", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)                  
end
  
--- Function called when a carrier is loading cargo.
function carrier:OnAfterLoading(From,Event,To)
  -- Info Message
  local text=string.format("Group %s is loading cargo...", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)                
end

--- Function called when a carrier has loaded all cargo.
function carrier:OnAfterLoadingDone(From, Event, To)
  -- Info Message
  local text=string.format("Group %s loaded all cargo", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)              
end

--- Function called when the carrier transports cargo from pickup to deploy zone.
function carrier:OnAfterTransport(From, Event, To)
  -- Info Message
  local text=string.format("Group %s is transporting cargo...", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)                  
end

--- Function called when a carrier is unloading cargo.
function carrier:OnAfterUnLoading(From,Event,To)
  -- Info Message
  local text=string.format("Group %s is unloading cargo...", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)                
end  

--- Function called when a carrier is done with onloading its cargo.
function carrier:OnAfterUnloadingDone(From, Event, To)
  -- Info Message
  local text=string.format("Group %s is finished unloading cargo...", carrier:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)                  
end

---
-- FSM events for cargo groups
---

--- Function called when a cargo group is ordered to board a carrier.
function infantry:OnAfterBoard(From, Event, To, CarrierGroup, Carrier)
  local carriergroup=CarrierGroup --Ops.OpsGroup#OPSGROUP
  local carrier=Carrier --Ops.OpsGroup#OPSGROUP.Element

  -- Info Message
  local text=string.format("Group %s will board into carrier %s of group %s", infantry:GetName(), carrier.name, carriergroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)        
end

--- Function called when the group embarked a carrier.
function infantry:OnAfterEmbarked(From, Event, To, CarrierGroup, Carrier)
  local carriergroup=CarrierGroup --Ops.OpsGroup#OPSGROUP
  local carrier=Carrier --Ops.OpsGroup#OPSGROUP.Element)

  -- Info Message
  local text=string.format("Group %s embarked into carrier %s of group %s", infantry:GetName(), carrier.name, carriergroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

--- Function called when the group disembarked a carrier.  
function infantry:OnAfterDisembarked(From, Event, To, CarrierGroup, Carrier)
  local carriergroup=CarrierGroup --Ops.OpsGroup#OPSGROUP
  local carrier=Carrier --Ops.OpsGroup#OPSGROUP.Element)

  -- Info Message
  local text=string.format("Group %s disembarked from carrier %s of group %s", infantry:GetName(), carrier.name, carriergroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end