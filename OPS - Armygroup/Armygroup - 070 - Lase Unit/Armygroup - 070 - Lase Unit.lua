---
-- ARMYGROUP: Lase Unit
-- 
-- A JTAC infantry group is located on the roof of a building new the old airfield at Kobuleti and practicing to lase targets.
-- 
-- The target is a group of two BTR-80s. In this exercise, we want to lase a specific unit.
-- 
-- After 10 min, we switch the laser code from the default 1688 to 1711.
-- After 20 min, the laser is switched off.
-- 
-- PS: You can choose the JTAC/Operator slot and jump into a Bradley (RALT+J) or an A-10C client and turn on the night vision goggles to observe the LASER (or better the IR-pointer).
---

-- Create and ARMYGROUP.
local jtac=ARMYGROUP:New("JTAC Batcher")

-- Get a specific unit.
local Target=UNIT:FindByName("Red Target X-1")

-- Switch LASER on in one sec.
jtac:__LaserOn(1, Target)

-- Switch LASER code to 1711 after 10 min.
jtac:__LaserCode(10*60, 1711)

-- Turn LASER off after 20 min.
jtac:__LaserOff(20*60)

--- Function called when the LASER is switched on.
function jtac:OnAfterLaserOn(From, Event, To, Target)
  local text=string.format("Switching LASER On (code %d)", jtac:GetLaserCode())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

--- Function called when the LASER code is changed.
function jtac:OnAfterLaserCode(From, Event, To, Code)
  local text=string.format("Switching to LASER code %d", Code)
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