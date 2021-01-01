---
-- Name: AIC-APC-003 - APC Troops and Equipment
-- Author: FlightControl
-- Date Created: 07 Apr 2018
-- Date Checked: 01 Jan 2021
-- Not sure what the test case is

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 350 )



