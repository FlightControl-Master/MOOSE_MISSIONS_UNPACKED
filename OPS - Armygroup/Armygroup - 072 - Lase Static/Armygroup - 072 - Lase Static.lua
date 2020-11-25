---
-- ARMYGROUP: Lase Static
-- 
-- A JTAC infantry group is located on the roof of a building new the old airfield at Kobuleti and practicing to lase targets.
-- 
-- The target is a watch tower in the vicinity. We use 1689 as laser code.
-- 
-- The target is destroyed after 10 min. Then the laser is switched off automatically.
-- 
-- PS: You can choose the JTAC/Operator slot and jump into a Bradley (RALT+J) or an A-10C client and turn on the night vision goggles to observe the LASER (or better the IR-pointer).
---

-- Create and ARMYGROUP.
local jtac=ARMYGROUP:New("JTAC Batcher")

-- Set LASER code. Default is 1688, which would NOT need to be set explicitly.
jtac:SetLaser(1689)

-- Get static target.
local Target=STATIC:FindByName("Static Watch Tower")

-- The target is destroyed.
Target:GetCoordinate():Explosion(1000, 10*60)

-- Switch LASER on.
jtac:LaserOn(Target)

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