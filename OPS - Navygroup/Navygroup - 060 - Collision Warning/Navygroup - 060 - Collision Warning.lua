---
-- NAVYGROUP: Collision Warning & Taking Actions
-- 
-- USS Lake Erie is send to a coordinate very close to the shore.
-- When a potential collision is detected, the group is send back to its inital position.
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Lake Erie Group")
navygroup:Activate(1)

-- Coordinate near shore at Kobuleti.
local Coordinate=ZONE:New("Zone Kobuleti Sea")

-- Add a waypoint new the shore.
navygroup:AddWaypoint(Coordinate)

--- Function called when a collision warning is issued.
function navygroup:OnAfterCollisionWarning(From, Event, To, Distance)

  -- Message.
  local text=string.format("Iceberg ahead in %.1f NM", UTILS.MetersToNM(Distance))
  MESSAGE:New(text, 120):ToAll()
  env.info(text)

  -- Tell group to go back to its initial (spawn) position, i.e. waypoint with UID=1.
  navygroup:GotoWaypoint(1)
end
