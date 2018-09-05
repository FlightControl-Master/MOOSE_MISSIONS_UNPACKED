---
-- Name: AID-CGO-150 - APC - Manpads against enemy helicopters
-- Author: FlightControl
-- Date Created: 17 May 2018
--
-- This simulates manpads to fight against enemy helicpters.
-- So when the enemy helicopters are within combat range, the manpads will unload and will attack the helos.


local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

local ZoneGroup = GROUP:FindByName( "Deploy Group")
local DeployZone = ZONE_GROUP:New( "Deploy Group", ZoneGroup, 200 )


-- For the manpads to unload on time, a range of 8000 meters is appropriate.
AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones, 8000 ) 
AICargoDispatcherAPC:Start()

