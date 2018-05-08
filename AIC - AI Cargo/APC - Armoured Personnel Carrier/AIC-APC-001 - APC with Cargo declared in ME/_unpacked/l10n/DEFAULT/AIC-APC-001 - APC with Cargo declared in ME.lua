---
-- Name: AIC-APC-001 - APC with Cargo declared in ME
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--
-- A demonstration of the AI_CARGO_APC class.
-- This simple example transports Infantry.
-- The cargo is declared with the ~CARGO tag in the mission editor.
-- So, within the mission, the infantry groups have the name:
-- 

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart() 
local APC = GROUP:FindByName( "APC" )
AICargoAPC = AI_CARGO_APC:New( APC, InfantryCargoSet, 500 )
AICargoAPC:__Pickup( 5 )

