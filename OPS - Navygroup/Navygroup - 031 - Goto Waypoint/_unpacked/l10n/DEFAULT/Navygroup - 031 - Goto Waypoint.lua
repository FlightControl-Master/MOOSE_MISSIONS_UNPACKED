---
-- NAVYGROUP: Goto Specific Waypoints.
-- 
-- USS Normandy has four waypoints set in the Mission Editor.
-- The normal route would be -->2-->3-->4-->1-->2... (ad infinitum)
--
-- Here, when the group passes a waypoint, we give a command to goto some other waypoint.
-- 
-- When reaching waypoint 2, we goto waypoint 4
-- When reaching waypoint 4, we goto waypoint 3
-- When reaching waypoint 3, we goto waypoint 1
-- When reaching waypoint 1, we goto waypoint 2.
-- 
-- So effectively, the route becomes -->2-->4-->3-->1-->2-->4-->3-->1... (ad infinitum)
---

-- Create a new NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Normandy Group")
navygroup:Activate()

-- Increase verbosity to DCS log file.
navygroup:SetVerbosity(1)

-- Put F10 marks on waypoints.
navygroup:MarkWaypoints()

--- Function called each time the group passes a waypoint.
function navygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Get uid of the passed waypoint.
  local uid=navygroup:GetWaypointUID(waypoint)

  -- Message
  local text=string.format("Group passed waypoint with UID=%d!", uid)
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
  
  if uid==1 then
    navygroup:GotoWaypoint(2)  
  elseif uid==2 then
    navygroup:GotoWaypoint(4)
  elseif uid==3 then
    navygroup:GotoWaypoint(1)
  elseif uid==4 then
    navygroup:GotoWaypoint(3)    
  end
  
end