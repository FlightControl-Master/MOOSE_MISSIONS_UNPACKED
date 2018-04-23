---
-- Name: AIC-APC-000 - APC
-- Author: FlightControl
-- Date Created: 26 Mar 2018
--

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart() 

local CargoCarrier = GROUP:FindByName( "Carrier" )

CargoTroops = AI_CARGO_APC:New( CargoCarrier, InfantryCargoSet, 500 )


function CargoTroops:OnAfterDestroyed( CargoCarrier )
  CargoTroops:F( { Destroyed = CargoCarrier } )
  -- The coordinate is passed where the carrier is destroyed.
  local NewCarrier = self:FindCarrier( CargoCarrier:GetCoordinate(), 1000 ) -- which returns one Carrier GROUP object or nil.
  if NewCarrier then
    self:SetCarrier( NewCarrier )
  end
end

