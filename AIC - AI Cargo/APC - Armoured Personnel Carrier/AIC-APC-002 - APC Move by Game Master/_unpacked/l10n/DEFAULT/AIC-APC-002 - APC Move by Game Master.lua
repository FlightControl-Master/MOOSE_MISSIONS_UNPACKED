---
-- Name: AIC-APC-002 - APC Move by Game Master
-- Author: FlightControl
-- Date Created: 26 Mar 2018
-- Date Checked: 01 Jan 2021. Changed ~ to # in ME Group Names. Not sure how this is supposed to work for the Game Master

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 500 )

