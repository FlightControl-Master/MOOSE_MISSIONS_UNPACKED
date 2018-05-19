---
-- Name: AID-CGO-240 - Helicopter - Unloaded Event Handling
-- Author: FlightControl
-- Date Created: 15 May 2018
--
-- Demonstrates the way how the deploy locations can be set to a specific probability distribution.

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherHelicopter = AI_CARGO_DISPATCHER_HELICOPTER:New( SetHelicopter, SetCargoInfantry, SetDeployZones ) 
AICargoDispatcherHelicopter:SetHomeZone( ZONE:FindByName( "Home" ) )

--- Unloaded Handler OnAfter for AICargoDispatcherHelicopter
-- @function [parent=#AICargoDispatcherHelicopter] OnAfterUnloaded
-- @param #AICargoDispatcherHelicopter self
-- @param #string From
-- @param #string Event
-- @param #string To
-- @param Wrapper.Group#GROUP Carrier
-- @param Cargo.Cargo#CARGO Cargo
function AICargoDispatcherHelicopter:OnAfterUnloaded( From, Event, To, Carrier, Cargo )

  local CargoGroup = Cargo:GetObject() -- Wrapper.Group#GROUP
  
  local Task = CargoGroup:TaskRouteToZone( ZONE:FindByName( "Frontline" ), true, 10, "Vee" )
  CargoGroup:SetTask( Task, 5 )

end

AICargoDispatcherHelicopter:Start()
