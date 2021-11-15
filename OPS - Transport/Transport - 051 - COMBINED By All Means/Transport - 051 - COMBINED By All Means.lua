---
-- COMBINED FORCES: By All Means
-- 
-- A large amount of troops need to be transported from Novorossiysk to Gelendzhik.
-- The cargo includes a T-90 tank, two Akatsia Howitzas, several UAZ-469 trucks and infantry.
-- 
-- We use an An-30 plane, a Mi-26 helicopter, a BTR-90 APC and to carry out the 
-- transport as quickly as possibe.
---

-- Zones.
local zonePickup=ZONE_AIRBASE:New(AIRBASE.Caucasus.Novorossiysk, 3000):DrawZone()
local zoneDeploy=ZONE_AIRBASE:New(AIRBASE.Caucasus.Gelendzhik, 3000):DrawZone()
local zoneDisembark=ZONE:New("Zone Gelendzhik Disembark"):DrawZone()

-- Define Cargo.
local CargoSet=SET_OPSGROUP:New()
CargoSet:FilterPrefixes("Infantry AK-74 Alpha"):FilterPrefixes("Infantry AK-74 Bravo")
CargoSet:FilterPrefixes("UAZ-469 Alpha"):FilterPrefixes("UAZ-469 Bravo")
CargoSet:FilterPrefixes("T-90 Bravo")
CargoSet:FilterPrefixes("Akatsia Bravo")
CargoSet:FilterOnce()
CargoSet:Activate()

-- Transport assignment.
local transport=OPSTRANSPORT:New(CargoSet, zonePickup, zoneDeploy)

-- Set disembark zone.
transport:SetDisembarkZone(zoneDisembark)

-- Add a transport path for ground carriers. Waypoints are taken from the late activated template group.
transport:AddPathTransport(GROUP:FindByName("Path Novorossiysk-Gelendzhik Ground"))

-- Add a transport path for naval carriers. Waypoints are taken from the late activated template group.
transport:AddPathTransport(GROUP:FindByName("Path Novorossiysk-Gelendzhik Naval"))

-- Add a transport path for airplane carriers. Waypoints are taken from the late activated template group.
transport:AddPathTransport(GROUP:FindByName("Path Novorossiysk-Gelendzhik Airplane"))

-- Carrier airplane.
local An30=FLIGHTGROUP:New("An-30M Alpha-1")
An30:Activate()

-- Carrier ground.
local BTR80=ARMYGROUP:New("BTR-Alpha-1")
BTR80:Activate()

-- Carrier helicopter.
local Mi26=FLIGHTGROUP:New("Mi-26 Alpha-1")
Mi26:Activate()

-- Carrier ship.
local Ivanov=NAVYGROUP:New("Cargo Ivanov")
Ivanov:Activate()

-- Assign transport to carriers.
An30:AddOpsTransport(transport)
Mi26:AddOpsTransport(transport)  
BTR80:AddOpsTransport(transport)
Ivanov:AddOpsTransport(transport)