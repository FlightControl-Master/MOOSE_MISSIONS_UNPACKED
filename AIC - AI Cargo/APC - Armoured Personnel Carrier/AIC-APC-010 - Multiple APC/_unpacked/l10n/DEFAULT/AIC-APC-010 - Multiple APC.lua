---
-- Name: AIC-APC-010 - Multiple APC
-- Author: FlightControl
-- Date Created: 24 Apr 2018
--

local InfantrySet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local APC = GROUP:FindByName( "APC" )
Cargo_APC = AI_CARGO_APC:New( APC, InfantrySet, 250 )
Cargo_APC:__Pickup( 2 )



