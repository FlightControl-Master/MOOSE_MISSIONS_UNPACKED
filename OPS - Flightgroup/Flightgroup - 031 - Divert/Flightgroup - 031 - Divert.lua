---
-- FLIGHTGROUP: Divert
-- 
-- Just like in example mission "Flightgroup - 030 - Destination" we set the destination to Kobuleti.
-- However, when the group has passed the final waypoint, we let the group divert to Senaki.
-- Note that the group needs to have at least one waypoint to have the OnAfterPassingWaypoint function to be called. 
---

-- Create a FLIGHTGROUP object.
local flightgroup=FLIGHTGROUP:New("F/A-18 Batumi")
flightgroup:Activate()

-- Set Kobuleti as destination.
flightgroup:SetDestinationbase(AIRBASE:FindByName("Kobuleti"))

-- Add a waypoint at zone Alpha.
flightgroup:AddWaypoint(ZONE:New("Zone Alpha"):GetCoordinate(), 350, nil, 5000)


--- Function called when the group has passed a waypoint.
function flightgroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)

  -- At final waypoint, divert to Senaki instead of going to Kobuleti.
  if flightgroup:HasPassedFinalWaypoint() then
    flightgroup:RTB(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi))
 end

end

--- Function called when the group is ordered to return to an airbase.
function flightgroup:OnAfterRTB(From, Event, To, airbase)
  local text=string.format("Group is RTB to %s", airbase:GetName())
  MESSAGE:New(text, 10, flightgroup:GetName()):ToAll()
  flightgroup:I(text)
end