---
-- ARMYGROUP: Detection Groups
-- 
-- A Humvee is located at the old airfield at Kobuleti and will report all enemy groups it detects.
-- 
-- A couple of different red groups will pass along. All have ROE=Weapon Hold.
-- 
-- PS: Keep in mind that DCS detection works in mysterious ways.
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("JTAC Hmmwv")
armygroup:Activate()

-- Switch detection on.
armygroup:SetDetection(true)

--- Function called whenever a group has been detected for the first time.
function armygroup:OnAfterDetectedGroupNew(From, Event, To, Group)
  local group=Group --Wrapper.Group#GROUP
  local text=string.format("Detected NEW group %s", group:GetName())
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
end

--- Function called whenever a dected group could not be detected anymore.
function armygroup:OnAfterDetectedGroupLost(From, Event, To, Group)
  local group=Group --Wrapper.Group#GROUP
  local text=string.format("LOST detected group %s", group:GetName())
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
end

-- Info on LASER target and code.
local function CheckDetection()

  -- Set of detected units.
  local detectedset=armygroup:GetDetectedGroups()
  
  -- Cound number of alive detected units. 
  local ndetected=detectedset:CountAlive()
  
  -- Info on detected units.
  local text=string.format("Detected groups (%d):", ndetected)
  if ndetected>0 then  
    for _,_group in pairs(detectedset:GetSet()) do
      local group=_group --Wrapper.Group#GROUP
      text=text..string.format("\n- %s [threat level=%d]", group:GetName(), group:GetThreatLevel())
    end
  else
    text=text.." None"
  end

  -- Info message.
  MESSAGE:New(text, 25):ToAll()
  env.info(text)
end

-- Timer to check threats every 30 sec.
TIMER:New(CheckDetection):Start(10, 30)