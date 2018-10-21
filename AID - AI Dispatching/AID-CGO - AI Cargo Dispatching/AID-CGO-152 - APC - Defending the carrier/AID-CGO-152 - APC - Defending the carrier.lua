---
-- Name: AID-CGO-152 - APC - Defending the carrier
-- Author: FlightControl
-- Date Created: 18 Oct 2018
--
-- This simulates infantry to board APCs and will disembark to defend the enemy carrier when enemies are nearby..


local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

local ZoneGroup = GROUP:FindByName( "Deploy Group")
local DeployZone = ZONE_GROUP:New( "Deploy Group", ZoneGroup, 200 )


-- For the manpads to unload on time, a range of 8000 meters is appropriate.
AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones, 800 ) 

-- This will work too, so the combat range can be provided, but must be 0.
--AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones, 0 ) 

AICargoDispatcherAPC:Start()

Sound = USERSOUND:New( "Sounds/BOS05ej9982.ogg" )

Sound:ToAll()

