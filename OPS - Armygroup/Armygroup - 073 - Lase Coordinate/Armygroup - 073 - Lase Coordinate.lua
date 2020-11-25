---
-- ARMYGROUP: Lase Coordinate
-- 
-- A JTAC infantry group is located on the roof of a building new the old airfield at Kobuleti and practicing to lase targets.
-- 
-- The target is a watch tower in the vicinity. We use its coordinate and lase it at the top of the building. We use the default 1688 as laser code.
-- 
-- PS: You can choose the JTAC/Operator slot and jump into a Bradley (RALT+J) or an A-10C client and turn on the night vision goggles to observe the LASER (or better the IR-pointer).
---

-- Create and ARMYGROUP.
local jtac=ARMYGROUP:New("JTAC Batcher")

-- Get the coordinate of a static target. We lase 5 meters above ground.
local Watchtower=STATIC:FindByName("Static Watch Tower")

-- Get dimensions of the target.
local sizemax, length, height, width=Watchtower:GetObjectSize()

-- Specify the target coordinate of the laser.
local Target=Watchtower:GetCoordinate():SetAltitude(height)

-- Switch LASER on.
jtac:LaserOn(Target)

-- Switch LASER on.
jtac:__LaserOff(20*60)

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