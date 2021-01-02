---
-- Name: AIC-APC-004 - APC Pickup
-- Author: FlightControl
-- Date Created: 23 Apr 2018
-- Date Checked: 01 Jan 2021

BASE:TraceClass("AI_CARGO_APC")
BASE:TraceOn()

local InfantryCargoSet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()

Cargo_APC = {}

for i = 1, 4 do
  Cargo_APC[i] = AI_CARGO_APC:New( GROUP:FindByName( "APC"..i ), InfantryCargoSet, 350 )

  --- Loaded Handler OnAfter for Cargo_APC
  -- @function [parent=#Cargo_APC] OnAfterLoaded
  -- @param #Cargo_APC self
  -- @param Wrapper.Group#GROUP APC
  -- @param #string From
  -- @param #string Event
  -- @param #string To
  Cargo_APC[i].OnAfterLoaded = function( self, APC, From, Event, To )
    self:__Deploy( 5, ZONE:New( "Deploy" ):GetRandomCoordinate( 300, 500 ) )
  end
  
  --- Unloaded Handler OnAfter for Cargo_APC
  -- @function [parent=#Cargo_APC] OnAfterUnloaded
  -- @param #Cargo_APC self
  -- @param Wrapper.Group#GROUP APC
  -- @param #string From
  -- @param #string Event
  -- @param #string To
  Cargo_APC[i].OnAfterUnloaded = function( self, APC, From, Event, To )
    self:Pickup( ZONE:New( "Pickup" ):GetRandomCoordinate( 50, 70 ) )
  end

  Cargo_APC[i]:__Pickup( i * 30, ZONE:New( "Pickup" ):GetRandomCoordinate( 50, 70 ) )

end




