---
-- FLIGHTGROUP: Basics
-- 
-- 4-ship Hornet group is stationed at Batumi.
-- * Add waypoints manually.
-- * Check when entering and leaving zones.
-- * Change formation when passing waypoints.
-- * Test FSM events.
---

-- Create flight group.
local flightgroup=FLIGHTGROUP:New("F/A-18 Batumi")
flightgroup:Activate()


-- Set of all zones defined in the ME.
local AllZones=SET_ZONE:New():FilterOnce()

-- Set a set of zones which are checked and trigger FSM events when the group enters or leaves the zones.
flightgroup:SetCheckZones(AllZones)

-- Common zones.
local Zone={}
Zone.Alpha   = ZONE:New("Zone Alpha")   --Core.Zone#ZONE
Zone.Bravo   = ZONE:New("Zone Bravo")   --Core.Zone#ZONE
Zone.Charlie = ZONE:New("Zone Charlie") --Core.Zone#ZONE
Zone.Delta   = ZONE:New("Zone Delta")   --Core.Zone#ZONE

-- Add a couple of waypoints.
local wp1=flightgroup:AddWaypoint(Zone.Alpha:GetCoordinate(), 350, nil, 5000)
local wp2=flightgroup:AddWaypoint(Zone.Bravo:GetCoordinate(), 300, nil, 2000)
local wp3=flightgroup:AddWaypoint(Zone.Delta:GetCoordinate(), 450, nil, 7000)
local wp4=flightgroup:AddWaypoint(Zone.Charlie:GetCoordinate(), 300, nil, 5000)

--- Function called when the group passes a waypoint.
function flightgroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Get the unique ID of this waypoint.
  -- NOTE that the UID does not change when new waypoints are added or removed.
  local uid=flightgroup:GetWaypointUID(waypoint)

  -- Debug message.
  local text=string.format("Group passed waypoint UID=%d", uid)
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
      
  -- Check which waypoint was passed.
  if uid==wp1.uid then
    -- Switch radio and activate TACAN at this waypoint.
    flightgroup:SwitchRadio(255)
    flightgroup:SwitchTACAN(64, "ABC")
  elseif uid==wp2.uid then
    flightgroup:SwitchFormation(ENUMS.Formation.FixedWing.LineAbreast.Open)
  elseif uid==wp3.uid then
    flightgroup:SwitchFormation(ENUMS.Formation.FixedWing.FingerFour.Close)    
  end

end

--- Function called when the group enteres a zone.
function flightgroup:OnAfterEnterZone(From, Event, To, zone)
  local text=string.format("Group entered zone %s", zone:GetName())
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group leaves a zone.
function flightgroup:OnAfterLeaveZone(From, Event, To, zone)
  local text=string.format("Group left zone %s", zone:GetName())
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when an element of the group is parking at an airbase.
function flightgroup:OnAfterElementParking(From, Event, To, Element, Spot)
  local element=Element --Ops.FlightGroup#FLIGHTGROUP.Element
  local spot=Spot --Wrapper.Airbase#AIRBASE.ParkingSpot
  local text=string.format("Element %s is parking at spot %d", element.name, spot.TerminalID)
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group started taxiing to the runway.
function flightgroup:OnAfterTaxiing(From,Event,To)
  local text=string.format("Group is taxiing")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group took off.
function flightgroup:OnAfterTakeoff(From, Event, To, airbase)
  local text=string.format("Group took off at %s", airbase and airbase:GetName() or "unknown place")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group is airborne.
function flightgroup:OnAfterAirborne(From, Event, To)
  local text=string.format("Group is airborn")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group is ordered to return to an airbase.
function flightgroup:OnAfterRTB(From, Event, To, airbase)
  local text=string.format("Group is RTB to %s", airbase:GetName())
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group is ordered to land (after holding at an airbase).
function flightgroup:OnAfterLanding(From, Event, To)
  local text=string.format("Group is landing")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group landed.
function flightgroup:OnAfterLanded(From, Event, To, airbase)
  local text=string.format("Group landed at %s", airbase and airbase:GetName() or "unknown place")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group arrived at its parking spot.
function flightgroup:OnAfterArrived(From, Event, To)
  local text=string.format("Group arrived at its destination")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end

--- Function called when the group is dead, i.e. killed or despawned. Will be called after the group has arrived at its parking location.
function flightgroup:OnAfterDead(From, Event, To)
  local text=string.format("Group is dead")
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end