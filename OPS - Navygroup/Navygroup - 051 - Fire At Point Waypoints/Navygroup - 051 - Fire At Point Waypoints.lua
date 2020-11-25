---
-- NAVYGROUP: Waypoint "Fire At Point" Task 
-- 
-- USS Lake Erie is ordered to engage two targets. The first target is engaged with with cannons, the second target with cruise missiles.
-- 
-- We add two waypoints for the group. The tasks are executed when the group reaches the waypoints. While the task is beeing executed, the group will stop at the given waypoint.
-- 
-- Note that:
-- * For the DCS fire at point task to be executed, the group must be in firing range. This is not checked. If the group is NOT in firing range, the task will start but the group will not shoot!
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Lake Erie Group")
navygroup:SetVerbosity(3)
navygroup:Activate(1)

-- Set ROE to "Open Fire" or the task will not work.  
navygroup:SwitchROE(ENUMS.ROE.OpenFire)

-- The target.
local TargetCoord1=GROUP:FindByName("Red Target X"):GetCoordinate()
local TargetCoord2=GROUP:FindByName("Red Target Poti"):GetCoordinate()

-- The target coordinates (needed for the fire at point task).
local FirePoint1=ZONE:New("Zone Fireing Pos Alpha"):GetCoordinate()
local FirePoint2=ZONE:New("Zone Fireing Pos Bravo"):GetCoordinate()

-- Add waypoints where we want to execute the tasks.
local wp1=navygroup:AddWaypoint(FirePoint1)
local wp2=navygroup:AddWaypoint(FirePoint2)

-- Fire at point tasks.
local task1=navygroup:AddTaskWaypointFireAtPoint(FirePoint1, wp1, 500, 10, ENUMS.WeaponFlag.Cannons, nil, 10*60)
local task2=navygroup:AddTaskWaypointFireAtPoint(FirePoint2, wp2, 100, 10, ENUMS.WeaponFlag.CruiseMissile, nil, 10*60)

--- Function called when the group passes a waypoint.
function navygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  if waypoint.uid==wp1.uid then

    -- Message
    local text=string.format("Reached waypoint UID=%d! Should now execute task %d", waypoint.uid, task1.id)
    MESSAGE:New(text, 120):ToAll()
    env.info(text)

  elseif waypoint.uid==wp2.uid then

    -- Message
    local text=string.format("Reached waypoint UID=%d! Should now execute task %d", waypoint.uid, task2.id)
    MESSAGE:New(text, 120):ToAll()
    env.info(text)
    
  end
  
  -- Remove waypoint.
  navygroup:RemoveWaypointByID(waypoint.uid)

end

--- Function called when the group executes a DCS task.
function navygroup:OnAfterTaskExecute(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Message
  local text=string.format("Executing task %s!", task.description)
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
end


--- Function called when the group executes a DCS task.
function navygroup:OnAfterTaskDone(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Message
  local text=string.format("Done with task %s!", task.description)
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
end
