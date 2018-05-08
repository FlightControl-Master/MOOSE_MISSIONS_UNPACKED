---
-- Name: AIC-APC-000 - APC
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--
-- A demonstration of the AI_CARGO_APC class.
-- This simple example transports Infantry.
-- The CARGO_GROUP objects are declared within the mission script.

local Infantry1 = CARGO_GROUP:New( GROUP:FindByName( "Infantry1" ), "Infantry", "Infantry1", 500, 25 )
local Infantry2 = CARGO_GROUP:New( GROUP:FindByName( "Infantry2" ), "Infantry", "Infantry2", 500, 25 )
local Infantry3 = CARGO_GROUP:New( GROUP:FindByName( "Infantry3" ), "Infantry", "Infantry3", 500, 25 )

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local APC = GROUP:FindByName( "APC" )
AICargoAPC = AI_CARGO_APC:New( APC, InfantryCargoSet, 500 )
AICargoAPC:__Pickup( 5 )

