---
-- Name: AID-CGO-100 - APC - Pickup and Deploy
-- Author: FlightControl
-- Date Created: 10 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetPickupZones = SET_ZONE:New():FilterPrefixes( "Pickup" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, SetPickupZones, SetDeployZones ) 
AICargoDispatcherAPC:SetHomeZone( ZONE:New("Home") )

--- Pickup Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a CarrierGroup is routed towards a new pickup Coordinate and a specified Speed.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Point#COORDINATE Coordinate The coordinate of the pickup location.
-- @param #number Speed The velocity in meters per second on which the CarrierGroup is routed towards the pickup Coordinate.
-- @param #number Height Height in meters to move to the pickup coordinate.
-- @param Core.Zone#ZONE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAPC:OnAfterPickup( From, Event, To, CarrierGroup, Coordinate, Speed, Height, PickupZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is picking up cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()
  

end


--- Load Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a CarrierGroup has initiated the loading or boarding of cargo within reporting or near range.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE_AIRBASE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAPC:OnAfterLoad( From, Event, To, CarrierGroup, PickupZone )

  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is loading cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()

end

--- PickedUp Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a carrier has picked up all cargo objects into the CarrierGroup.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE_AIRBASE PickupZone (optional) The zone from where the cargo is picked up. Note that the zone is optional and may not be provided, but for AI_CARGO_DISPATCHER_AIRBASE there will always be a PickupZone, as the pickup location is an airbase zone.
function AICargoDispatcherAPC:OnAfterPickedUp( From, Event, To, CarrierGroup, PickupZone )

  -- Write here your own code.
  -- Write here your own code.
  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " has loaded all cargo at airbase " .. PickupZone:GetName(), MESSAGE.Type.Information ):ToAll()

end


--- Deploy Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a CarrierGroup is routed to a deploy coordinate, to Unload all cargo objects in each CarrierUnit.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @function OnAfterDeploy
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Point#COORDINATE Coordinate The deploy coordinate.
-- @param #number Speed The velocity in meters per second on which the CarrierGroup is routed towards the deploy Coordinate.
-- @param #number Height Height in meters to move to the deploy coordinate.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAPC:OnAfterDeploy( From, Event, To, CarrierGroup, Coordinate, Speed, Height, DeployZone )

  MESSAGE:NewType( "Group " .. CarrierGroup:GetName().. " is starting deployment of all cargo in zone " .. DeployZone:GetName(), MESSAGE.Type.Information ):ToAll()

end







--- Unloaded Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a CarrierUnit of a CarrierGroup has unloaded a cargo object.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- Note that if more cargo objects were unloading or unboarding from the CarrierUnit, then this event can be fired multiple times for each different Cargo/CarrierUnit.
-- A CarrierUnit can be part of the larger CarrierGroup.
-- @function OnAfterUnloaded
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Cargo.Cargo#CARGO Cargo The cargo object.
-- @param Wrapper.Unit#UNIT CarrierUnit The carrier unit that is executing the cargo unloading operation.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAPC:OnAfterUnloaded( From, Event, To, CarrierGroup, Cargo, CarrierUnit, DeployZone )

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


--- Deployed Handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a carrier has deployed all cargo objects from the CarrierGroup.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- @function OnAfterDeployed
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was fired.
-- @param #string Event A string that contains the "*event name*" when the event was fired.
-- @param #string To A string that contains the "*to state name*" when the event was fired.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAPC:OnAfterDeployed( From, Event, To, CarrierGroup, DeployZone )

  MESSAGE:NewType( "Group " .. CarrierGroup:GetName() .. " deployed all cargo in zone " .. DeployZone:GetName(), MESSAGE.Type.Information ):ToAll()

end


--- Home event handler OnAfter for AICargoDispatcherAPC.
-- Use this event handler to tailor the event when a CarrierGroup is returning to the HomeZone, after it has deployed all cargo objects from the CarrierGroup.
-- You can use this event handler to post messages to players, or provide status updates etc.
-- If there is no HomeZone is specified, the CarrierGroup will stay at the current location after having deployed all cargo.
-- @param #AICargoDispatcherAPC self
-- @param #string From A string that contains the "*from state name*" when the event was triggered.
-- @param #string Event A string that contains the "*event name*" when the event was triggered.
-- @param #string To A string that contains the "*to state name*" when the event was triggered.
-- @param Wrapper.Group#GROUP CarrierGroup The group object that contains the CarrierUnits.
-- @param Core.Point#COORDINATE Coordinate The home coordinate the Carrier will arrive and stop it's activities.
-- @param #number Speed The velocity in meters per second on which the CarrierGroup is routed towards the home Coordinate.
-- @param #number Height Height in meters to move to the home coordinate.
-- @param Core.Zone#ZONE HomeZone The zone wherein the carrier will return when all cargo has been transported. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAPC:OnAfterHome( From, Event, To, CarrierGroup, Coordinate, Speed, Height, HomeZone )

  MESSAGE:NewType( "Group " .. CarrierGroup:GetName() .. " deployed all cargo and going home to zone " .. HomeZone:GetName(), MESSAGE.Type.Detailed ):ToAll()

end
      


AICargoDispatcherAPC:Start()

