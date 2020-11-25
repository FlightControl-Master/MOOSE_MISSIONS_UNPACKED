  ---
  -- NAVYGROUP: Passing Waypoints
  -- 
  -- Naval group "USS Normandy Group" has four waypoints set in the Mission editor:
  -- 1.) Initial positon at speed 0 knots
  -- 2.) Heading North at 25 knots.
  -- 3.) Heading North-West at 15 knots.
  -- 4.) Heading South at 30 knots (full speed).
  -- 
  -- After passing waypoint 4, the group will proceed eastwards to waypoint 1 and redo the route until all eternaty.
  -- Note that usually a waypoint speed of zero is dangerous.
  -- 
  -- When a group passes a waypoint, it will trigger an event "PassingWaypoint" which can be captured by the OnAfterPassingWaypoint() function.
  -- 
  ---

-- Create a NAVYGROUP object and activate the late activated group.
local navygroup=NAVYGROUP:New("USS Normandy Group")  
navygroup:Activate()

--- Function called each time the group passes a waypoint.
function navygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Debug info.
  local text=string.format("Group passed waypoint ID=%d (Index=%d) for the %d. time", waypoint.uid, navygroup:GetWaypointIndex(waypoint.uid), waypoint.npassed)
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
  
end

--- Function called when the group is cruising. This is the "normal" state when the group follows its waypoints.
function navygroup:OnAfterCruise(From, Event, To)
  local text="Group is cruising"
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

--- Function called when the groups starts to turn.
function navygroup:OnAfterTurningStarted(From, Event, To)
  local text="Group started turning"
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end  

--- Function called when the group stopps to turn.
function navygroup:OnAfterTurningStopped(From, Event, To)
  local text="Group stopped turning"
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

-- Monitor entering and leaving zones. There are four zones named "Zone Leg 1", "Zone Leg 2", ...
local ZoneSet=SET_ZONE:New():FilterPrefixes("Zone Leg"):FilterOnce()

-- Set zones which are checked if the group enters or leaves it.
navygroup:SetCheckZones(ZoneSet)

--- Function called when the group enteres a zone.
function navygroup:OnAfterEnterZone(From, Event, To, Zone)
  local text=string.format("Group entered zone %s", Zone:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)    
end

--- Function called when the group leaves a zone.
function navygroup:OnAfterLeaveZone(From, Event, To, Zone)
  local text=string.format("Group left zone %s", Zone:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)    
end
