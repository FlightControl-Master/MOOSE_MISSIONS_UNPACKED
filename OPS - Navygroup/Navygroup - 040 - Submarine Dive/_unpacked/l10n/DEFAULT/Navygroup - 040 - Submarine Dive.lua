  ---
  -- NAVYGROUP: Submarine Dive & Surface.
  -- 
  -- A submarine has the following waypoint pre-defined in the mission editor:
  -- 
  -- UID=1: Spawnposition, speed 0 knots, depth 0 meters
  -- UID=2: First waypoint, speed 15 knots, depth 0 meters,
  -- UID=3: Second waypoint, speed 17 knots, depth 0 meters,
  -- 
  -- By default, the sub will then automatically go to its initial position (UID=1) and resume its route from there.
  -- 
  -- At the first waypoint (UID=2), we will let the submarine dive. If not ordered to surface again, the sub would remain under water for the remaining route.
  -- At the second waypoint (UID=3), the submarine is ordered surface again.
  -- When the sub reaches its initial position (UID=1), we set the cruise speed to 20 knots. This is the speed until the next waypoint (UID=2) is reached.
  -- Once reaching the next waypoint, the speed is set according to the waypoint parameter (here 15 knots).
  ---

-- Create a NAVYGROUP object.
local Uboot=NAVYGROUP:New("Sub 093 Group")
Uboot:SetVerbosity(1)
Uboot:Activate(1)

--- Function called each time the group passes a waypoint.
function Uboot:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  
  if Waypoint.uid==2 then
    -- At waypoint 2 we let the sub dive to 10 meters.
    Uboot:Dive(10)
  elseif Waypoint.uid==3 then
    -- At waypoint 3 we let the sub come up to the surface again.
    Uboot:Surface()
  elseif Waypoint.uid==1 then
    -- At waypoint 1 we order the sub to cruise at 20 knots. Note that this is the speed until the next waypoint is reached.
    Uboot:Cruise(20)
  end

end

--- Function called when sub is about to dive.
function Uboot:OnAfterDive(From, Event, To, Depth, Speed)

  -- Message.
  local text=string.format("Diving!")
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end

--- Function called when sub is about surface.
function Uboot:OnAfterSurface(From, Event, To, Speed)

  -- Message.
  local text=string.format("Coming up to surface!")
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end