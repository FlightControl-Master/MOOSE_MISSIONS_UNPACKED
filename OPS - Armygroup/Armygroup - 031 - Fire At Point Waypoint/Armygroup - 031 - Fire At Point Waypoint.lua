---
-- ARMYGROUP: Task "Fire At Point" at Waypoints
-- 
-- A group of two M109 Paladin is ordered to fire at two targets.
-- Each target is out of range. We create two waypoints. At each of the waypoint a "Fire at Point" task is executed.
-- 
-- Note that the fire at point task is only executed if the group is in range (not too far and not too close).
-- This information is not available via scripting. So YOU need to make sure, that this is the case!
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("M109 Paladin")
armygroup:Activate()

-- Increase DCS log output.
armygroup:SetVerbosity(3)

-- Targets.
local target1=GROUP:FindByName("Red Target X")
local target2=ZONE:New("Zone Poti")

-- Waypoints where the tasks are executed. Not that the group will stop at the waypoints until all waypoint tasks are over.
local wpAlpha=armygroup:AddWaypoint(ZONE:New("Zone Firepoint Alpha"))
local wpBravo=armygroup:AddWaypoint(ZONE:New("Zone Firepoint Bravo"), nil, nil, ENUMS.Formation.Vehicle.OnRoad)

-- Fire at point task.
local fireatpoint1=armygroup:AddTaskWaypointFireAtPoint(target1, wpAlpha, 250, 10)
local fireatpoint2=armygroup:AddTaskWaypointFireAtPoint(target2, wpBravo, 500, 15)

--- Function called when a DCS task is executed.
function armygroup:OnAfterTaskExecute(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Message.
  local text=string.format("Executing task %s!", task.description)
  env.info(text)
  MESSAGE:New(text, 60):ToAll()
  
end

--- Function called when a DCS task is over.
function armygroup:OnAfterTaskDone(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Message.
  local text=string.format("Task %s DONE!", task.description)
  env.info(text)
  MESSAGE:New(text, 60):ToAll()

end
