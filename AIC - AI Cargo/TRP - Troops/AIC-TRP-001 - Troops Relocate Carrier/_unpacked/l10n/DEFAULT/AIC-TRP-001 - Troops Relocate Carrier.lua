---
-- Name: AIC-TRP-001 - Troops Relocate Carrier
-- Author: FlightControl
-- Date Created: 07 Apr 2018
-- 
-- Demonstration of troops relocation when carrier is destroyed...
-- Carrier will relocate to the rescue carrier.

local InfantryGroup = GROUP:FindByName( "Infantry" )

local InfantryCargo = CARGO_GROUP:New( InfantryGroup, "Engineers", "Infantry Engineers", 2000 )

local CargoCarrier = UNIT:FindByName( "Carrier" )

CargoTroops = AI_CARGO_TROOPS:New( CargoCarrier, InfantryCargo, 500 )


function CargoTroops:OnAfterDestroyed( CargoCarrier )
  CargoTroops:F( { Destroyed = CargoCarrier } )
  -- The coordinate is passed where the carrier is destroyed.
  local NewCarrier = self:FindCarrier( CargoCarrier:GetCoordinate(), 1000 ) -- which returns one Carrier GROUP object or nil.
  if NewCarrier then
    self:SetCarrier( NewCarrier )
  end
end

