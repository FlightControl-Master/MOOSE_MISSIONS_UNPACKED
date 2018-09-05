---
-- Name: AID-CGO-100 - APC - Pickup and Deploy
-- Author: FlightControl
-- Date Created: 10 May 2018
--

local SetCargoInfantry = SET_CARGO:New():FilterTypes( "Infantry" ):FilterStart()
local SetAPC = SET_GROUP:New():FilterPrefixes( "APC" ):FilterStart()
local SetDeployZones = SET_ZONE:New():FilterPrefixes( "Deploy" ):FilterStart()

AICargoDispatcherAPC = AI_CARGO_DISPATCHER_APC:New( SetAPC, SetCargoInfantry, nil, SetDeployZones ) 
AICargoDispatcherAPC:SetHomeZone( ZONE:New("Home") )


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
-- @param Core.Zone#ZONE DeployZone The zone wherein the cargo is deployed. This can be any zone type, like a ZONE, ZONE_GROUP, ZONE_AIRBASE.
function AICargoDispatcherAPC:OnAfterDeploy( From, Event, To, CarrierGroup, Coordinate, Speed, DeployZone )

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

AICargoDispatcherAPC:Start()

