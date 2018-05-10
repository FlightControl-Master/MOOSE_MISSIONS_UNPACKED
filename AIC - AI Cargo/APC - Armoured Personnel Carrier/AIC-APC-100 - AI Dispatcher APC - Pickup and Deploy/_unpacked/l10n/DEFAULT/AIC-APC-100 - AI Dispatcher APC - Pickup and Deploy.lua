---
-- Name: AIC-APC-100 - AI Dispatcher APC - Pickup and Deploy
-- Author: FlightControl
-- Date Created: 10 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, SetDeployZones ) 
