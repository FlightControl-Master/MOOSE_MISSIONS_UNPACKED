---
-- ARMYGROUP: Lase Group
-- 
-- A JTAC infantry group is located on the roof of a building new the old airfield at Kobuleti and practicing to lase targets.
-- 
-- The target is a group of two BTR-80s. The JTAC will start to lase the unit in the group with the highest threat level (not important here).
-- When the lased unit is dead, the JTAC will automatically switch to the next highest threat of the group until the whole group is dead.
-- 
-- PS: You can choose the JTAC/Operator slot and jump into a Bradley (RALT+J) or an A-10C client and turn on the night vision goggles to observe the LASER (or better the IR-pointer).
---

-- Create and ARMYGROUP.
local jtac=ARMYGROUP:New("JTAC Batcher")

-- Get first unit.
local Target=GROUP:FindByName("Red Target X")

-- Switch LASER on after 5 seconds.
jtac:__LaserOn(5, Target)

-- Turn LASER off after 25 min.
jtac:__LaserOff(25*60)

--- Function called when the LASER is switched on.
function jtac:OnAfterLaserOn(From, Event, To, Target)
  local text=string.format("Switching LASER On (code %d)", jtac:GetLaserCode())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)        
end

--- Function called when the LASER is switched off.
function jtac:OnAfterLaserOff(From, Event, To)
  local text=string.format("Switching LASER Off")
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

--- Function called when the lasing unit gotline of sight.
function jtac:OnAfterLaserGotLOS(From, Event, To)
  local text=string.format("Got line of sight to target!")
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

--- Function called when the lasing unit lost line of sight.
function jtac:OnAfterLaserLostLOS(From, Event, To)
  local text=string.format("Lost Line of Sight to target. Switching laser off temporarily until we regrain LOS")
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

---
-- Unrelated helper stuff.
---

-- Destroy target a unit of the target group every 5 min.
local function destroy()
  local unit=jtac:GetLaserTarget()
  if unit then
    unit:Explode()
  end
end
TIMER:New(destroy):SetMaxFunctionCalls(#Target:GetUnits()):Start(5*60, 5*60)

-- Info on LASER target and code.
local function jtactarget()
  local unit=jtac:GetLaserTarget()
  local text="No target"
  if unit then
    text=string.format("Lasing target %s at code %d", unit:GetName(), jtac:GetLaserCode())
  end
  text=text..string.format(" (ON=%s, LOS=%s)", tostring(jtac:IsLasing()), tostring(jtac.spot.LOS))
  MESSAGE:New(text, 25):ToAll()
  env.info(text)
end
TIMER:New(jtactarget):Start(30, 30)