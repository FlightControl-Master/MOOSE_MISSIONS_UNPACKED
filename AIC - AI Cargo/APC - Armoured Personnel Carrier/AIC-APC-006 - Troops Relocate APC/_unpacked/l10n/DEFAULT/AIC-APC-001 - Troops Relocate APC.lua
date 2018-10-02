---
-- Name: AIC-APC-001 - Troops Relocate APC
-- Author: FlightControl
-- Date Created: 07 Apr 2018
-- 
-- Demonstration of troops relocation when carrier is destroyed...
-- Carrier will relocate to the rescue carrier.

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 500 )


function CargoTroops:OnAfterDestroyed( CargoCarrier )
  CargoTroops:F( { Destroyed = CargoCarrier } )
  -- The coordinate is passed where the carrier is destroyed.
  local NewCarrierGroup = self:FindCarrier( CargoCarrier:GetCoordinate(), 1000 ) -- which returns one Carrier GROUP object or nil.
  if NewCarrierGroup then
    self:SetCarrier( NewCarrierGroup )
  end
end

