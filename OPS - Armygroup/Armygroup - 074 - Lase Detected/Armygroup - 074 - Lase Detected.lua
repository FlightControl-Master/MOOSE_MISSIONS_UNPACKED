---
-- ARMYGROUP: Lase Detected Units
-- 
-- A JTAC Humvee group is located on the roof of a building new the old airfield at Kobuleti and practicing to lase targets.
-- 
-- Only targets that are detected by the group are lased. If the detected target is lost, the laser is switched off.
-- If a new target with a higher threat level is detected, the JTAC will automatically switch to that target.
-- 
-- The first target the group detects should be a rather harmless group of BTRs.
-- Later in the mission, some T-90 tanks enter the battlefield. These are a higher threat and the JTAC will switch the laser to the tanks.
---

-- Create and ARMYGROUP.
local jtac=ARMYGROUP:New("JTAC Hmmwv")

-- Switch detection on.
jtac:SetDetection(true)

-- Activate highter threat after 10 min.
local T90=GROUP:FindByName("T-90")
T90:Activate(10*60)

--- Function called when the LASER is switched on.
function jtac:OnAfterLaserOn(From, Event, To, Target)
  local text=string.format("Switching LASER On (code %d) at target %s", jtac:GetLaserCode(), Target:GetName())
  MESSAGE:New(text, 60):ToAll()
  env.info(text)        
end

--- Function called when the LASER is switched off.
function jtac:OnAfterLaserOff(From, Event, To)
  local text=string.format("Switching LASER Off")
  MESSAGE:New(text, 60):ToAll()
  env.info(text)
end

-- Info on LASER target and code.
local function CheckThreats()

  -- Get the highst (detected) threat to the group.
  local threatunit,threatlevel=jtac:GetHighestThreat()
  
  -- Set of detected units.
  local detectedset=jtac:GetDetectedUnits()
  
  -- Cound number of alive detected units. 
  local ndetected=detectedset:CountAlive()
  
  -- Info on detected units.
  local text=string.format("Detected units (%d):", ndetected)
  if ndetected>0 then  
    for _,_unit in pairs(detectedset:GetSet()) do
      local unit=_unit --Wrapper.Unit#UNIT
      text=text..string.format("\n- %s [threat level=%d]", unit:GetName(), unit:GetThreatLevel())
    end
  else
    text=text.." None"
  end
  
  -- We got a threat to the group.
  if threatunit then

    text=text..string.format("\nHighest detected threat %s with threat level %d", threatunit:GetName(), threatlevel)
    
    -- Current laser target.
    local target=jtac:GetLaserTarget()
    
    local newtarget=nil --Wrapper.Unit#UNIT
    if target then
    
      local currentthreatlevel=target:GetThreatLevel()
      
      if threatlevel>currentthreatlevel then
        env.info("FF higher threat detected!")
        newtarget=threatunit
      end
    
    else
      env.info("FF no current target using this one")
      newtarget=threatunit
    end
    
    if newtarget then
      if jtac:IsLasing() then
        jtac:LaserOff()
      end
      env.info("FF New target "..newtarget:GetName())
      jtac:LaserOn(newtarget)
    end
  
  end


  -- Get current laser target.
  local unit=jtac:GetLaserTarget()
  if unit then
    text=text..string.format("\nLasing target %s at code %d", unit:GetName(), jtac:GetLaserCode())
  else
    text=text.."\nNot lasing any target"
  end
  text=text..string.format(" (ON=%s, LOS=%s)", tostring(jtac:IsLasing()), tostring(jtac.spot.LOS))

  -- Info message.
  MESSAGE:New(text, 25):ToAll()
  env.info(text)
end

-- Timer to check threats every 30 sec.
TIMER:New(CheckThreats):Start(10, 10)
