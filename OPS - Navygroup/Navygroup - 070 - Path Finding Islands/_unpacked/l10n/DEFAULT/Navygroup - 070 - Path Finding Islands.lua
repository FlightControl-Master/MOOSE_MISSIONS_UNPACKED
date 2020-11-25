---
-- NAVYGROUP: Path Finding Islands
-- 
-- A group of two ships, USS Lake Erie and USS Ford, is send on a path which leads right through a couple of islands.
-- The standard DCS behaviour would be that the group gets stuck and there is no way to free them as ships cannot go backwards.
-- 
-- Moose has a build in path finding algorithm, which will route the group around the obstacles (islands) as soon as a collision is detected.
-- 
-- Note: This mission takes place on the Persion Gulf map.
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Lake Erie Group")

-- Increase output to DCS log file.
navygroup:SetVerbosity(1)

-- Enable pathfinding. (Pathfinding is off by default as this could lead to high CPU usage). 
navygroup:SetPathfindingOn(1700)

--- Function called when a collision warning is issued.
function navygroup:OnAfterCollisionWarning(From, Event, To, Distance)

  -- Message.
  local text=string.format("Iceberg ahead in %.1f NM", UTILS.MetersToNM(Distance))
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end
