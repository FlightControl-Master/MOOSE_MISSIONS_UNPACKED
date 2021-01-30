---
-- FLIHGTGROUP: Helo Escorting Tanks
-- 
-- An AH-64D Apache Group is assigned to escort a group of Abrams tanks along its route.
--
-- The Apache commander is cleared to engage all enemy ground targets within a range of 5 NM of its position. 
---

-- Escorted tank group.
local tanks=GROUP:FindByName("Abrams")

-- Escort helo (late activated, could also be spawned).
local apache=FLIGHTGROUP:New("Apache")
apache:Activate(1)

-- Auto engage detected ground units within 5 NM.
apache:SetEngageDetectedOn(5, {"Ground Units"})

-- Current follow waypoint.
local followWP=nil --Ops.OpsGroup#OPSGROUP.Waypoint

--- Function called when the group gets alive.
function apache:OnAfterSpawned()  
  -- Create waypoint at the position of the tanks.
  local Coordinate=tanks:GetCoordinate()    
  followWP=apache:AddWaypoint(Coordinate, nil, nil, 500)      
end

--- Function called when the group is tasked to engage a target.
function apache:OnAfterDisengage(From, Event, To)
  if followWP then
    apache:RemoveWaypointByID(followWP.uid)
  end
  -- Create a new waypoint at the current pos of the tanks.
  local Coordinate=tanks:GetCoordinate()    
  followWP=apache:AddWaypoint(Coordinate, nil, nil, 500)    
end
  
--- Function called when a waypoint is passed.
function apache:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Remove this waypoint as we do not need it anymore.
  if waypoint.uid==followWP.uid then
    apache:RemoveWaypointByID(waypoint.uid)
  end
  
  if tanks and tanks:IsAlive() then    
  
    -- Get position and speed of the tanks.
    local Coordinate=tanks:GetCoordinate()    
    local Speed=tanks:GetVelocityKNOTS()
    
    -- Calcucate 2D distance and increase catchup speed.
    local dist=Coordinate:Get2DDistance(apache:GetCoordinate())
    if dist>200 then
      Speed=Speed+5
    elseif dist>500 then
      Speed=Speed+10
    elseif dist>1000 then
      Speed=Speed+20
    end
        
    -- Add a waypoint. Usually, UpdateRoute is called automatically after 1 sec. This is too slow. So we disable it and call it manually.
    followWP=apache:AddWaypoint(Coordinate, Speed, nil, 500, false)    
    apache:UpdateRoute()      
  end
end