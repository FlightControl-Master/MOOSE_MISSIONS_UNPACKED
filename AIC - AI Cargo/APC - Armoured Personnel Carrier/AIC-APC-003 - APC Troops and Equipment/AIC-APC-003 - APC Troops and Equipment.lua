---
-- Name: AIC-APC-003 - APC Troops and Equipment
-- Author: FlightControl
-- Date Created: 07 Apr 2018
--

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 350 )



