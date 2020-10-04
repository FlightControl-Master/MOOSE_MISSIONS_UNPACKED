---
-- Divert
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