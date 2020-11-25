---
-- NAVYGROUP: Scheduled "Fire At Point" Task 
-- 
-- USS Lake Erie is ordered to engage two targets:
-- 
-- * First target is engaged with with 10 cannon shots at 0805 hours.
-- * Second target with two cruise missiles at 0815 hours.
-- 
-- Note that:
-- * For the DCS fire at point task to be executed, the group must be in firing range. This is not checked. If the group is NOT in firing range, the task will start but the group will not shoot!
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Lake Erie Group")
navygroup:Activate(1)

-- Increase output in DCS log file.
navygroup:SetVerbosity(3)

-- Set ROE to "Open Fire" or the task will not work.  
navygroup:SwitchROE(ENUMS.ROE.OpenFire)

-- The target.
local TargetCoord1=GROUP:FindByName("Red Target X"):GetCoordinate()
local TargetCoord2=GROUP:FindByName("Red Target Poti"):GetCoordinate()

-- Add scheduled tasks.
navygroup:AddTaskFireAtPoint(TargetCoord1, "8:05", 100, 10, ENUMS.WeaponFlag.Cannons)
navygroup:AddTaskFireAtPoint(TargetCoord2, "8:15", 100,  2, ENUMS.WeaponFlag.CruiseMissile)

-- Add a waypoint.
local wp1=navygroup:AddWaypoint(ZONE:New("Zone Alpha"):GetCoordinate())

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
