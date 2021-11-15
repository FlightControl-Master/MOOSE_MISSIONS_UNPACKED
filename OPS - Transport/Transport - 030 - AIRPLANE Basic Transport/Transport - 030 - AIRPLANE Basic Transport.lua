---
-- AIRPLANE: Basic Transport
-- 
-- A C-130 Hercules (spawned in air) is assigned to pick up heavy cargo (tanks) at Kobuleti and deliver them to Gudauta.
-- 
-- The homebase of the Hercules is Batumi. Once the cargo has been delivered, the plane will go there.
-- 
-- *** IMPORTANT ***
-- 
-- Note the the pickup and depoly zones have to be ZONE_AIRBASE objects as airplanes can only land at airbases.
---

-- Carrier group.
local c130=FLIGHTGROUP:New("C-130 Alpha")
c130:Activate(1)

-- Define area where troops are unloaded relative to the aircraft.
c130:SetCarrierUnloaderBack(50, 20)

-- The default cruise altitude of aircraft is 10,000 ft. Here we set it to 12,000 ft.
c130:SetDefaultAltitude(12000)

-- Air start (i.e. no home or destination base). Set homebase to Batumi. Once the transport is finished, the aircarft will RTB to Batumi.
c130:SetHomebase(AIRBASE:FindByName("Batumi"))

-- Pickup and deploy base. NOTE that we use ZONE_AIRBASE here, which is important for aircraft as they can only land there.
local zonePickup=ZONE_AIRBASE:New("Kobuleti", 5000)
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Gudauta, 5000)

-- Cargo set.
local cargoset=SET_GROUP:New():FilterPrefixes("Tank Platoon Kobuleti Alpha"):FilterOnce()
cargoset:Activate()

-- Ops transport assignment.
local transport=OPSTRANSPORT:New(cargoset, zonePickup, zoneDeploy)

-- Assign transport to C-130.
c130:AddOpsTransport(transport)

---
-- FSM events of the OPSTRANSPORT
---

--- Function called when an OPSGROUP is loaded into a carrier.
function transport:OnAfterLoaded(From, Event, To, CargoOpsGroup, CarrierOpsGroup, CarrierElement)
  local cargoopsgroup=CargoOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrieropsgroup=CarrierOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrier=CarrierElement   --Ops.OpsGroup#OPSGROUP.Element

  -- Info message.
  local text=string.format("Transport UID=%d opsgroup %s loaded into carrier %s", transport:GetUID(), cargoopsgroup:GetName(), carrier.name)
  MESSAGE:New(text, 60):ToAll()
  env.info(text)

end

--- Function called when an OPSGROUP is unloaded from the carrier.
function transport:OnAfterUnloaded(From, Event, To, CargoOpsGroup, CarrierOpsGroup)
  local cargoopsgroup=CargoOpsGroup --Ops.ArmyGroup#ARMYGROUP
  local carrieropsgroup=CarrierOpsGroup --Ops.ArmyGroup#ARMYGROUP
  
  -- Info message.
  local text=string.format("Transport UID=%d unloaded opsgroup %s from carrier group %s", transport:GetUID(), cargoopsgroup:GetName(), carrieropsgroup:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
  
  -- OPSGROUP is ready for further actions. Put up green smoke.
  cargoopsgroup:GetGroup():SmokeGreen()
  
end

--- Function called when transport was delivered or everyone (remaining) is dead.
function transport:OnAfterDelivered(From, Event, To)
  -- Info Message
  local text=string.format("Transport UID=%d was delivered. Ncargo=%d Ndelivered=%d", transport:GetUID(), transport:GetNcargoTotal(), transport:GetNcargoDelivered())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end