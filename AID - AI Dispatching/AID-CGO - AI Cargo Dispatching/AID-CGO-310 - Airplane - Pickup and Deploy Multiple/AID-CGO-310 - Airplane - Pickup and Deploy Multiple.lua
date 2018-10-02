---
-- Name: AID-CGO-310 - Airplane - Pickup and Deploy Multiple
-- Author: FlightControl
-- Date Created: 03 Aug 2018
--

local CargoInfantrySet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local AirplanesSet = SET_GROUP:New():FilterPrefixes( "Airplane" ):FilterStart()
local PickupZoneSet = SET_ZONE:New()
local DeployZoneSet = SET_ZONE:New()

PickupZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Gudauta ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Sochi_Adler ) )

AICargoDispatcherAirplanes = AI_CARGO_DISPATCHER_AIRPLANE:New( AirplanesSet, CargoInfantrySet, PickupZoneSet, DeployZoneSet ) 
AICargoDispatcherAirplanes:Start()

for CargoName, Cargo in pairs( CargoInfantrySet:GetSet() ) do
  AICargoDispatcherAirplanes:I( { Cargo = Cargo:GetName() } )
end

