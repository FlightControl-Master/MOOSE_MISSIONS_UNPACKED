---
-- Name: AID-CGO-230 - Helicopter - DeployZone Probability
-- Author: FlightControl
-- Date Created: 15 May 2018
--
-- Demonstrates the way how the deploy locations can be set to a specific probability distribution.

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherHelicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, nil, SetDeployZones ) 
AICargoDispatcherHelicopter:SetHomeZone( ZONE:FindByName( "Home" ) )
AICargoDispatcherHelicopter:Start()

SetDeployZones:SetZoneProbability( "Deploy A", 0.1 )
SetDeployZones:SetZoneProbability( "Deploy B", 0.1 )
SetDeployZones:SetZoneProbability( "Deploy C", 0.8 )