---
-- Name: AID-CGO-310 - Airplane - Pickup and Deploy Multiple
-- Author: FlightControl
-- Date Created: 03 Aug 2018
--

local CargoInfantrySet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local AirplanesSet = SET_GROUP:New():FilterPrefixes( "Airplane" ):FilterStart()
local PickupAirbasesSet = SET_AIRBASE:New()
local DeployAirbasesSet = SET_AIRBASE:New()

PickupAirbasesSet:AddAirbasesByName( AIRBASE.Caucasus.Gudauta )
DeployAirbasesSet:AddAirbasesByName( AIRBASE.Caucasus.Sochi_Adler )

AICargoDispatcherAirplanes = AI_CARGO_DISPATCHER_AIRPLANE:New( AirplanesSet, CargoInfantrySet, PickupAirbasesSet, DeployAirbasesSet ) 
AICargoDispatcherAirplanes:Start()

for CargoName, Cargo in pairs( CargoInfantrySet:GetSet() ) do
  AICargoDispatcherAirplanes:I( { Cargo = Cargo:GetName() } )
end

