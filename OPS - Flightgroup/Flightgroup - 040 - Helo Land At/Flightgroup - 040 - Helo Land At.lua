---
-- FLIGHTGROUP: Land at coordinate
-- 
-- A helo group is ordered to go to a waypoint at zone Bravo.
-- After 10 min, it is ordered to land at a drop off zone. It will stay there for 5 min and then resume its route to zone Bravo.
-- 
---

local flightgroup=FLIGHTGROUP:New("UH-1H Group")
flightgroup:Activate()

local zoneBravo=ZONE:New("Zone Bravo")

-- Add a waypoint.
flightgroup:AddWaypoint(zoneBravo:GetCoordinate():SetAltitude(500), 100)

-- After 10 min give the command to land at the drop off zone for 5 min.
flightgroup:__LandAt(10*60, ZONE:New("Zone Dropoff"):GetCoordinate(), 5*60)

--- Function called when the group has passed a waypoint.
function flightgroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  if flightgroup:HasPassedFinalWaypoint() then
    flightgroup:RTB(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi))
  end
end

--- Function called after helo is ordered to land at a coordinate.
function flightgroup:OnAfterLandAt(From, Event, To, Coordinate, Duration)

  -- Note that the coordinate must not be passed like in this example. If it is not given in the :LandAt() command the helo will land at is current position.
  if Coordinate then
  
    -- Send a message.
    local mgrs=Coordinate:ToStringMGRS()
    local text=string.format("We are landing at %s and will remain there for %d seconds", mgrs, Duration or 600)
    MESSAGE:New(text, 120):ToAll()
    env.info(text)
    
  end

end

--- Function called after helo landed at a coordinate.
function flightgroup:OnAfterLandedAt(From, Event, To)

  -- Smoke group organge.
  flightgroup:GetCoordinate():SmokeOrange()

end
  
