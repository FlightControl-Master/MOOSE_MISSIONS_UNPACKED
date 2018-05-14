---
-- Name: AID-CGO-101 - Helicopter - DeployZone Orbit
-- Author: FlightControl
-- Date Created: 10 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherHelicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, SetDeployZones ) 
AICargoDispatcherHelicopter:SetHomeZone( ZONE:FindByName( "Home" ) )
