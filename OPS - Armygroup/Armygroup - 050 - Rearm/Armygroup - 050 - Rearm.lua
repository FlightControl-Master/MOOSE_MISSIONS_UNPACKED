---
-- ARMYGROUP: Rearming
-- 
-- A group of rocket launchers is ordered to fire all it has at a target near the old airfield at Kobuleti at 0805 hours.
--
-- Once it has fired all its rockets, it is ordered to drive to a rearming truck located nearby.
-- 
-- When the rearming is finished, the group is send to its initial position where it will start another attack on the target coordinates.
-- (We do not check if the target has already been destroyed here.)
-- 
-- Firing and rearming will go on "forever".
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("MLRS M270")
armygroup:Activate()

-- Increase output to DCS log file.
armygroup:SetVerbosity(3)

-- Initial amount of ammo.
local ammo0=armygroup:GetAmmo0()

-- Target GROUP object.
local target=GROUP:FindByName("Red Target X")

-- The target coordinate.
local targetCoordinate=target:GetCoordinate()

-- Fire at point task.
local fireatpoint=armygroup:AddTaskFireAtPoint(targetCoordinate, "8:05", 500, ammo0.Rockets)

-- Rearming truck zone.
local RearmingTruck=ZONE_UNIT:New("Rearming Truck", UNIT:FindByName("M818-1"), 25)

--- Function called when the group is completely out of ammo.
function armygroup:OnAfterOutOfAmmo()

  -- Message.
  local text=string.format("Group is completely out of ammo!")
  env.info(text)
  MESSAGE:New(text, 60):ToAll()

  -- Get a coordinate near the rearming truck.
  local coordinate=RearmingTruck:GetRandomCoordinate(10, 25)

  -- Order group to rearm at a specific coordinate.
  self:Rearm(coordinate)

end

--- Function called when the group is out of rockets.
function armygroup:OnAfterOutOfRockets()

  -- Message.
  local text=string.format("Group is out of rockets!")
  env.info(text)
  MESSAGE:New(text, 60):ToAll()

end

--- Function called when the group is completely out of ammo.
function armygroup:OnAfterRearm(Coordinate)

  -- Message.
  local text=string.format("Group is send to rearm")
  env.info(text)
  MESSAGE:New(text, 60):ToAll()

end

--- Function called when the group has arrived at the rearming location.
function armygroup:OnAfterRearming()

  -- Message.
  local text=string.format("Group waiting to be rearmed")
  env.info(text)
  MESSAGE:New(text, 60):ToAll()

end

--- Function called when the group was rearmed.
function armygroup:OnAfterRearmed()

  -- Get current ammo.
  local ammo=armygroup:GetAmmoTot()

  -- Message.
  local text=string.format("Group is rearmed. Number of rockets %d", ammo.Rockets)
  env.info(text)
  MESSAGE:New(text, 60):ToAll()
  
  -- Get first waypoint (initial position).
  local wp=armygroup:GetWaypointByID(1)

-- Fire at point task when waypoint 1 is reached.
  local fireatpoint=armygroup:AddTaskWaypointFireAtPoint(targetCoordinate, wp, 500, ammo0.Rockets)
  
  -- Goto first waypoint at default speed in Vee formation.
  armygroup:GotoWaypoint(1, nil, ENUMS.Formation.Vehicle.Vee)
  
end


-- Monitor ammo status every 30 sec.
local function CheckAmmo()
  local ammo=armygroup:GetAmmoTot()
  local text=string.format("Rockets %d/%d [%s]", ammo.Rockets, ammo0.Rockets, armygroup:GetState())
  MESSAGE:New(text, 25, armygroup:GetName()):ToAll() 
end
local timer=TIMER:New(CheckAmmo):Start(30, 30)

