---
-- Name: AID-CGO-120 - Helicopter - Randomize Coordinates
-- Author: FlightControl
-- Date Created: 10 May 2018
--
-- Demonstrates the way how the pickup and deploy locations can be randomized.

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherHelicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, SetDeployZones ) 
--AICargoDispatcherHelicopter:SetHomeZone( ZONE:FindByName( "Home" ) )

AICargoDispatcherHelicopter:SetPickupRadius( 100, 50 )
AICargoDispatcherHelicopter:SetDeployRadius( 100, 50 )
