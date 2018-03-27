---
-- Name: AIC-TRP-000 - Troops
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--

local InfantryGroup = GROUP:FindByName( "Infantry" )

local InfantryCargo = CARGO_GROUP:New( InfantryGroup, "Engineers", "Infantry Engineers", 2000 )

local CargoCarrier = UNIT:FindByName( "Carrier" )

CargoTroops = AI_CARGO_TROOPS:New( CargoCarrier, InfantryCargo, 1500 )
