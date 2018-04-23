---
-- Name: AIC-APC-002 - APC Move by Game Master
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 500 )

