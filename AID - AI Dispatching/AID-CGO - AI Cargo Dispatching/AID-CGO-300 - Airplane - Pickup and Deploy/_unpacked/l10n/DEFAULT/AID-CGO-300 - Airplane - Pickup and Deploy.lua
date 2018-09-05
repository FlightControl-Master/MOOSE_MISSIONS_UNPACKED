---
-- Name: AID-CGO-300 - Airplane - Pickup and Deploy
-- Author: FlightControl
-- Date Created: 02 Aug 2018
--

local CargoInfantrySet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local AirplanesSet = SET_GROUP:New():FilterPrefixes( "Airplane" ):FilterStart()
local PickupZoneSet = SET_ZONE:New()
local DeployZoneSet = SET_ZONE:New()

PickupZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Gudauta ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Sochi_Adler ) )

AICargoDispatcherAirplanes = AI_CARGO_DISPATCHER_AIRPLANE:New( AirplanesSet, CargoInfantrySet, PickupZoneSet, DeployZoneSet ) 
AICargoDispatcherAirplanes:Start()

