---
-- Name: AIC-APC-000 - APC
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--
-- A demonstration of the AI_CARGO_APC class.
-- This simple example transports Infantry.

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart() 
local APC = GROUP:FindByName( "APC" )
AICargoAPC = AI_CARGO_APC:New( APC, InfantryCargoSet, 500 )
AICargoAPC:__Pickup( 5 )

