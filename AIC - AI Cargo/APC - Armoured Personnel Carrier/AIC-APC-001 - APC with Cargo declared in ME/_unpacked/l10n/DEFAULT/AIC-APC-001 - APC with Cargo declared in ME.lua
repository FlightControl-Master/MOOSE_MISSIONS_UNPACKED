---
-- Name: AIC-APC-001 - APC with Cargo declared in ME
-- Author: FlightControl
-- Date Created: 26 Mar 2018
-- Date Checked: 01 Dec 2021
-- Changed Cargo auto tag from  ~ to #, working example
--
-- A demonstration of the AI_CARGO_APC class.
-- This simple example transports Infantry.
-- The cargo is declared with the #CARGO tag in the mission editor.
-- So, within the mission, the infantry groups have the name:
-- e.g. Infantry1#CARGO(T=Infantry,RR=2000,NR=25)

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart() 
local APC = GROUP:FindByName( "APC" )
AICargoAPC = AI_CARGO_APC:New( APC, InfantryCargoSet, 500 )
AICargoAPC:__Pickup( 5 )

