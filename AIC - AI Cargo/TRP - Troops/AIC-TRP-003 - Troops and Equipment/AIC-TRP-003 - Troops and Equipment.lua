---
-- Name: AIC-TRP-003 - Troops and Equipment
-- Author: FlightControl
-- Date Created: 07 Apr 2018
--

local InfantryGroup = GROUP:FindByName( "Infantry" )

for UnitID, InfantryUnit in pairs( InfantryGroup:GetUnits() ) do
  BASE:F( { Desc=InfantryUnit:GetDesc() } )
end

local InfantryCargo = CARGO_GROUP:New( InfantryGroup, "Engineers", "Infantry Engineers" )

local CargoCarrier = UNIT:FindByName( "Carrier" )

CargoTroops = AI_CARGO_TROOPS:New( CargoCarrier, InfantryCargo, 250 )


function CargoTroops:OnAfterDestroyed( CargoCarrier )
  CargoTroops:F( { Destroyed = CargoCarrier } )
  -- The coordinate is passed where the carrier is destroyed.
  local NewCarrier = self:FindCarrier( CargoCarrier:GetCoordinate(), 1000 ) -- which returns one Carrier GROUP object or nil.
  if NewCarrier then
    self:SetCarrier( NewCarrier )
  end
end

