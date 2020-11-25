---
-- NAVYGROUP: Waypoints: Passing, Adding and Removing
-- 
-- USS Normandy has four waypoints set in the Mission Editor.
-- After passing a waypoint, it is removed. So when the group has visited all waypoints, it will come to a full stop.
-- When the group reaches waypoint with unique ID=3, we add another waypoint at the zone Detour Alpha.
-- 
-- Note that UID counting for pre-defined waypoints in the ME start at one.
-- In paricular, the initial (spawn) position of the group is the waypoint with UID=1.
-- 
---

-- Create a new NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Normandy Group")
navygroup:Activate()

-- Increase verbosity to DCS log file.
navygroup:SetVerbosity(1)

--- Function called each time the group passes a waypoint.
function navygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Get uid of the passed waypoint.
  local uid=navygroup:GetWaypointUID(waypoint)

  -- Message
  local text=string.format("Group passed waypoint with UID=%d!", uid)
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
  
  -- After passing waypoint 3, go to Zone Alpha at 20 knots.
  if uid==3 then
  
    -- Detour zone.
    local zoneDetourAlpha=ZONE:New("Zone Detour Alpha")
    
    local coordDetourAlpha=zoneDetourAlpha:GetCoordinate()
        
    -- Add waypoint.
    local newaypoint=navygroup:AddWaypoint(coordDetourAlpha, 20, waypoint.uid)
        
    -- Message
    local text=string.format("Alright, let's make a detour to %s. Waypoint UID=%d", zoneDetourAlpha:GetName(), newaypoint.uid)
    MESSAGE:New(text, 360):ToAll()
    env.info(text)    
  end

  -- Remove the waypoint that has just been passed.
  navygroup:RemoveWaypointByID(uid)
  
end


--- Function called each time the group comes to a full stop, e.g. when no more waypoints are left.
function navygroup:OnAfterFullStop(From, Event, To)
  -- Send a message that we stopped.
  local text=string.format("Group came to a full stop!")
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
end