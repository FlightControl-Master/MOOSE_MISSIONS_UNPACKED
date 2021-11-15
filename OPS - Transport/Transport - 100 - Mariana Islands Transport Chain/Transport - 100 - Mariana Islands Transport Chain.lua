---
-- The Seawise Giant has loaded troops from far away.
-- Six infantry groups need to be transported across the Mariana Islands.
-- 
-- In the first step, Speed boats pick up the troops from the Seawise Giant
-- and transport them to the harbour near Piti on Guam.
-- 
-- A UH-60A is then taking off from Antonio B. Won Pat Intl. Airport to pick them
-- up and bring them to Andersen Airbase.
-- 
-- At Andersen there is a C-130 Hercules waiting to further transport the troops 
-- to Saipan Intl. Airport.
-- 
-- Once arrived at Saipan, the troops are added to the local warehouse.
-- 

-- Zones.
local zoneSeawise=ZONE_UNIT:New("Seawise", UNIT:FindByName("Seawise Giant"), 300)
local zoneDeepWater=ZONE:New("Zone Deep Water"):DrawZone()
local zoneHarbourAlpha=ZONE:New("Zone Harbour Alpha"):DrawZone()
local zonePort=ZONE:New("Zone Port"):DrawZone()
local zoneAndersen=ZONE_AIRBASE:New(AIRBASE.MarianaIslands.Andersen_AFB)
local zoneSaipan=ZONE_AIRBASE:New(AIRBASE.MarianaIslands.Saipan_Intl)


-- Cargo group set.
local cargo=SET_OPSGROUP:New()

-- Spawn some infantry groups in late activated state.
local spawnInfantry=SPAWN:New("Infantry Platoon"):InitLateActivated(true)
for i=1,6 do
  local group=spawnInfantry:SpawnInZone(zoneSeawise)
  cargo:AddGroup(group)
end

-- Warehouse Saipan
local warehauseSaipan=WAREHOUSE:New("Warehouse Saipan")
warehauseSaipan:Start()

---
-- Seawise transporting cargo from distant lands near to Guam.
---

-- Seawise Giant carrier.
local seawise=NAVYGROUP:New("Seawise Giant")
seawise:Activate()
  
-- Transport troops to a zone near Guam.
local transportSeawise=OPSTRANSPORT:New(cargo, zoneSeawise, zoneDeepWater)
transportSeawise:SetDisembarkCarriers(SET_GROUP:New():FilterPrefixes("Speed Boat"):FilterOnce())

-- Add transport to Seawise.
seawise:AddOpsTransport(transportSeawise)

-- Load all defined cargo directly.
for _,_opsgroup in pairs(transportSeawise:GetCargoOpsGroups(false)) do
  seawise:Load(_opsgroup)
end

---
-- Speed boats transporting infantry from Seawise to the port.
---

-- Speed boats.
local speedboat1=NAVYGROUP:New("Speed Boat-1")
--speedboat1:SetPathfindingOff()
speedboat1:Activate()  

-- Assignment to transport the troops from the Seawise to the harbour near Piti, Guam.
local transportSpeedboat=OPSTRANSPORT:New(cargo, zoneDeepWater, zoneHarbourAlpha)

-- We add a transport path so that the boats do not get stuck at the harbour entry.
transportSpeedboat:AddPathTransport(GROUP:FindByName("Path Alpha"))

-- Troops are disembarked on the peninsula, where the helo can land.
transportSpeedboat:SetDisembarkZone(zonePort)

-- Add transport assignment to speed boat group.
speedboat1:AddOpsTransport(transportSpeedboat)

---
-- UH-60A transports infantry from port zone to Andersen AFB
---

-- Helo carrier.
local uh60a=FLIGHTGROUP:New("UH-60A-1")
uh60a:Activate()  

-- Transport assignment to pickup the troops at Piti harbour and bring them to Andersen Airbase.
local transportUH60A=OPSTRANSPORT:New(cargo, zonePort, zoneAndersen)

-- Transport is started once the speed boats have delivered the cargo.
transportUH60A:AddConditionStart(function()
  return transportSpeedboat:IsDelivered()
end)

-- Add transport assignment.
uh60a:AddOpsTransport(transportUH60A)


---
-- C-130 transports infantry from Andersen AFB to Saipan Intl
---

-- Hercules carrier.
local c130=FLIGHTGROUP:New("C-130")
c130:Activate()

-- Define transport from Andersen AFB to Saipan Intl.
local transportC130=OPSTRANSPORT:New(cargo, zoneAndersen, zoneSaipan)
transportC130:AddConditionStart(function()
  return transportUH60A:IsDelivered()
end)

-- Assign transport to C130.
c130:AddOpsTransport(transportC130)


--- When the cargo is delivered, it is added to the warehouse.
function transportC130:OnAfterDelivered(From,Event,To)

  -- Get all DELIVERED ops groups.
  local opsgroups=transportC130:GetCargoOpsGroups(true)
  
  -- Add all groups to Warehouse for further tasking.
  for _,_opsgroup in pairs(opsgroups) do
    local opsgroup=_opsgroup --Ops.OpsGroup#OPSGROUP
    local group=opsgroup:GetGroup()
    warehauseSaipan:AddAsset(group)
  end
end