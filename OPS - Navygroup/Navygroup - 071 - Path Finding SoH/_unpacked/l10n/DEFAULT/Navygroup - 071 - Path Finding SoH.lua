---
-- NAVYGROUP: Path Finding
-- 
-- CVN-74 USS Stennis is supposed to drive through the Strait of Hormuz. The waypoints lead through a big chuck of land mass.
-- However, the build in path finding algorithm will guide the ship to its destination.
-- 
-- Note: This mission takes place on the Persion Gulf map.
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("Strike Group")

-- Do not go back.
navygroup:SetPatrolAdInfinitum(false)

-- Increase output to DCS log file.
navygroup:SetVerbosity(1)

-- Enable pathfinding. (Pathfinding is off by default as this could lead to high CPU usage). 
navygroup:SetPathfindingOn()

--- Function called when a collision warning is issued.
function navygroup:OnAfterCollisionWarning(From, Event, To, Distance)

  -- Message.
  local text=string.format("Iceberg ahead in %.1f NM", UTILS.MetersToNM(Distance))
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end
