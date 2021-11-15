---
-- GROUND Transport Zone Combos
-- 
-- A group of two TPz Fuchs transports infantry groups from Zone Kobulety X.
-- 
-- One infantry group should be delivered to zone Alpha, while the second group should be delivered to zone Bravo.
-- To achieve this, we use "Transport Zone Combos" (TPZ).
-- 
-- For the transport to zone Alpha, the carrier will drive on roads.
-- For the transport to zone Bravo, the carrier will drive off roads. 
---

-- Pickup and deploy zones.
local PickupZone=ZONE:New("Zone Kobuleti X")
local DeployZoneAlpha=ZONE:New("Zone Alpha")
local DeployZoneBravo=ZONE:New("Zone Bravo")

-- Carrier.
local carrier=ARMYGROUP:New("TPz Fuchs Group")
carrier:Activate()
  
-- Set of groups to transport.
local Infantry1=GROUP:FindByName("Infantry Platoon Alpha-1"):Activate()
local Infantry2=GROUP:FindByName("Infantry Platoon Alpha-2"):Activate()

-- Cargo transport assignment.
local opstransport=OPSTRANSPORT:New()

-- Add TZCs.
local tpzAlpha=opstransport:AddTransportZoneCombo(Infantry1, PickupZone, DeployZoneAlpha)
local tpzBravo=opstransport:AddTransportZoneCombo(Infantry2, PickupZone, DeployZoneBravo)

-- Transport to zone Alpha will be on road.
opstransport:SetFormationPickup(ENUMS.Formation.Vehicle.OnRoad, tpzAlpha)
opstransport:SetFormationTransport(ENUMS.Formation.Vehicle.OnRoad, tpzAlpha)

-- Assign transport to carrier.
carrier:AddOpsTransport(opstransport)

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
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", opstransport:GetUID(), opstransport:GetNcargoTotal(), opstransport:GetNcargoDelivered())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end