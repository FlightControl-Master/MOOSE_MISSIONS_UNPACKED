---
-- FLIGHGROUP: Set Destination
-- 
-- The group has no pre-defined waypoints in the Mission editor.
-- We set the destination to Kobuleti. So the group will take of from Batumi and land there.
---

-- Create a FLIGHTGROUP object.
local flightgroup=FLIGHTGROUP:New("F/A-18 Batumi")
flightgroup:Activate()

-- Set the destination base. Once the group passes the last waypoint and has no more missions it will go there.
flightgroup:SetDestinationbase(AIRBASE:FindByName("Kobuleti"))

--- Function called when the group is ordered to return to an airbase.
function flightgroup:OnAfterRTB(From, Event, To, airbase)
  local text=string.format("Group is RTB to %s", airbase:GetName())
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end
