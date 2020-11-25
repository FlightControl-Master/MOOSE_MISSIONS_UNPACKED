---
-- ARMYGROUP: Task "Fire At Point" (Scheduled)
-- 
-- A group of rocked launchers is ordered to fire 20 shots at a target near the old airfield at Kobuleti.
-- Attack is scheduled for 0805 hours local time. Mission starts at 0800.
-- 
-- Note that the fire at point task is only executed if the group is in range (not too far and not too close).
-- This information is not available via scripting. So YOU need to make sure, that this is the case!
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("MLRS M270")
armygroup:Activate()

-- Ammo table.
local ammo0=armygroup:GetAmmoTot()

-- Target GROUP object.
local target=GROUP:FindByName("Red Target X")

-- Fire at point task. Fire 20 shots at 0805 hours.
local fireatpoint=armygroup:AddTaskFireAtPoint(target:GetCoordinate(), "8:05", 500, 20)

--- Function called when a DCS task is executed.
function armygroup:OnAfterTaskExecute(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Check that this is the task we want.
  if task.id==fireatpoint.id then
  
    -- Message.
    local text=string.format("Executing task %s!", task.description)
    env.info(text)
    MESSAGE:New(text, 60):ToAll()        

    -- Update ammo table at the beginning of the task.
    ammo0=armygroup:GetAmmoTot()
  
  end  
end

--- Function called when a DCS task is over.
function armygroup:OnAfterTaskDone(From, Event, To, Task)
  local task=Task --Ops.OpsGroup#OPSGROUP.Task
  
  -- Check that this is the right task.
  if task.id==fireatpoint.id then
  
    -- Get current ammo table.
    local ammo=armygroup:GetAmmoTot()
    
    -- Calculate diff used during the task.
    local nshots=ammo0.Total-ammo.Total
  
    -- Message.
    local text=string.format("Task DONE! Fired %d shots", nshots)
    env.info(text)
    MESSAGE:New(text, 60):ToAll()
  
  end
end
