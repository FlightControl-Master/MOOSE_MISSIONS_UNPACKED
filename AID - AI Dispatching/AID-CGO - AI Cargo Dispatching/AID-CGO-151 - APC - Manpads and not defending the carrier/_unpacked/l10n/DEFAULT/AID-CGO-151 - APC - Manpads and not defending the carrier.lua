---
-- Name: AID-CGO-151 - APC - Manpads and not defending the carrier
-- Author: FlightControl
-- Date Created: 08 Sep 2018
--
-- This simulates manpads to board APCs and won't disembark to defend the enemy carrier when enemies are nearby..
-- So when the enemy helicopters are within combat range, the manpads will NOT unload and will NOT attack the helos.
-- This is because the combat range was not provided, and thus is 0.


local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

local ZoneGroup = GROUP:FindByName( "Deploy Group")
local DeployZone = ZONE_GROUP:New( "Deploy Group", ZoneGroup, 200 )


-- For the manpads to unload on time, a range of 8000 meters is appropriate.
AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones ) 

-- This will work too, so the combat range can be provided, but must be 0.
--AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones, 0 ) 

AICargoDispatcherAPC:Start()

