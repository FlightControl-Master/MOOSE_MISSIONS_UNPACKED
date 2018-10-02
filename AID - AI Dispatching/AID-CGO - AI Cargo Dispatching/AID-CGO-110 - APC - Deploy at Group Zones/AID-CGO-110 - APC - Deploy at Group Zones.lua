---
-- Name: AID-CGO-110 - APC - Deploy at Group Zones
-- Author: FlightControl
-- Date Created: 10 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

local ZoneGroup = GROUP:FindByName( "Deploy Group")
local DeployZone = ZONE_GROUP:New( "Deploy Group", ZoneGroup, 200 )


AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones ) 
AICargoDispatcherAPC:Start()

