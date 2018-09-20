---
-- Name: AID-CGO-340 - Airplane - Event Handling
-- Author: FlightControl
-- Date Created: 02 Aug 2018
--

local CargoInfantrySet = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local AirplanesSet = SET_GROUP:New():FilterPrefixes( "Airplane" ):FilterStart()
local PickupZoneSet = SET_ZONE:New()
local DeployZoneSet = SET_ZONE:New()

PickupZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Gudauta ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Sochi_Adler ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Maykop_Khanskaya ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Mineralnye_Vody ) )
DeployZoneSet:AddZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Vaziani ) )

AICargoDispatcherAirplanes = AI_CARGO_DISPATCHER_AIRPLANE:New( AirplanesSet, CargoInfantrySet, PickupZoneSet, DeployZoneSet ) 
AICargoDispatcherAirplanes:SetHomeZone( ZONE_AIRBASE:New( AIRBASE.Caucasus.Kobuleti ) )

--- Pickup Handler OnAfter for AICargoDispatcherAirplanes.
-- Use this event handler to tailor the event when a CarrierGroup is routed towards a new pickup Coordinate and a specified Speed.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Point#COORDINATE Coordinate The coordinate of the pickup location.
-- @param #number Speed The velocity in meters per second on which the CarrierGroup is routed towards the pickup Coordinate.
-- @param #number Height Height in meters to move to the pickup coordinate.
-- @param Core.Zone#ZONE_AIRBASE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAirplanes:OnAfterPickup( From, Event, To, CarrierGroup, Coordinate, Speed, Height, PickupZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is picking up cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()
  

end


--- Load Handler OnAfter for AICargoDispatcherAirplanes.
-- Use this event handler to tailor the event when a CarrierGroup has initiated the loading or boarding of cargo within reporting or near range.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE_AIRBASE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAirplanes:OnAfterLoad( From, Event, To, CarrierGroup, PickupZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is loading cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()

end

--- PickedUp Handler OnAfter for AICargoDispatcherAirplanes.
-- Use this event handler to tailor the event when a carrier has picked up all cargo objects into the CarrierGroup.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE_AIRBASE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAirplanes:OnAfterPickedUp( From, Event, To, CarrierGroup, PickupZone )

  -- Write here your own code.
  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " has loaded all cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()

end


--- Deploy Handler OnAfter for AICargoDispatcherAirplanes.
-- Use this event handler to tailor the event when a CarrierGroup is routed to a deploy coordinate, to Unload all cargo objects in each CarrierUnit.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @function OnAfterDeploy
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Point#COORDINATE Coordinate The deploy coordinate.
-- @param #number Speed The velocity in meters per second on which the CarrierGroup is routed towards the deploy Coordinate.
-- @param #number Height Height in meters to move to the deploy coordinate.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAirplanes:OnAfterDeploy( From, Event, To, CarrierGroup, Coordinate, Speed, Height, DeployZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is starting deployment of all cargo in zone " .. DeployZone:GetName(), MESSAGE.Type.Information ):ToAll()

end


--- Unloaded Handler OnAfter for AICargoDispatcherAirplanes.
-- Use this event handler to tailor the event when a CarrierUnit of a CarrierGroup has unloaded a cargo object.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- Note that if more cargo objects were unloading or unboarding from the CarrierUnit, then this event can be fired multiple times for each different Cargo/CarrierUnit.
-- A CarrierUnit can be part of the larger CarrierGroup.
-- @function OnAfterUnloaded
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Cargo.Cargo#CARGO Cargo The cargo object.
-- @param Wrapper.Unit#UNIT CarrierUnit The carrier unit that is executing the cargo unloading operation.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAirplanes:OnAfterUnloaded( From, Event, To, CarrierGroup, Cargo, CarrierUnit, DeployZone )

  -- Write here your own code.
  local CargoGroup = Cargo:GetObject() -- Wrapper.Group#GROUP
  
  -- Get the name of the DeployZone
  local DeployZoneName = DeployZone:GetName()
  
  local DeployBuildingNames = {
    ["Deploy A"] = "Building A",
    }
  
  
  -- Now board the infantry into the respective warehouse building.
  if DeployZoneName then
    local Building = STATIC:FindByName( DeployBuildingNames[DeployZoneName] )
    Cargo:__Board( 5, Building, 25 )
  end

  MESSAGE:NewType( "Group " .. CarrierGroup:GetName() .. ", Unit " .. CarrierUnit:GetName() .. " has unloaded cargo " .. Cargo:GetName() .. " in zone " .. DeployZone:GetName() .. " and cargo is moving to building " .. DeployBuildingNames[DeployZoneName], MESSAGE.Type.Information ):ToAll()


end


--- Deployed Handler OnAfter for AICargoDispatcherAirplanes.
-- @function OnAfterDeployed
-- @param #AICargoDispatcherAirplanes self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAirplanes:OnAfterDeployed( From, Event, To, CarrierGroup, DeployZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName() .. " deployed all cargo in zone " .. DeployZone:GetName(), MESSAGE.Type.Information ):ToAll()

end
  
  
AICargoDispatcherAirplanes:Start()

