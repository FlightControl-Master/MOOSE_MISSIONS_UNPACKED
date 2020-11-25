---
-- FLIGHTGROUP: Lase Scenery
-- 
-- A reaper is practicing to lase buildings (scenery objects) in the vicinity of Kobuleti.
-- 
-- First assignment is to lase a VOR station. Once the reaper is on station it will switch on its LASER.
-- If the target is destroyed, the reaper will switch off its LASER and proceed to the second target,
-- which is a warehouse structure of Kobuleti airbase.
-- 
-- Again, once on station the LASER will be turned on until the target is destroyed.
-- 
-- Once the second target is destroyed, the reaper will RTB to Kobuleti.
-- 
-- PS: In order to observe the LASER, enter the TACTICAL COMMANDER slot and jump into a Bradley
--     ("Observer 1" or "Observer 2") by clicking on the unit and hitting RALT+J.
---

-- Create flight group.
local reaper=FLIGHTGROUP:New("Reaper")

-- Set destination base.
reaper:SetDestinationbase(AIRBASE:FindByName(AIRBASE.Caucasus.Kobuleti))

-- Set LASER code. Default would be 1688.
reaper:SetLaser(1689)

-- Zone.
local zone1=ZONE:New("Zone Building 1")
local zone2=ZONE:New("Zone Building 2")

-- Get scenery objects.
local scenery1=zone1:GetCoordinate():FindClosestScenery(100)
local scenery2=zone2:GetCoordinate():FindClosestScenery(100)

-- Set targets.
local target1=TARGET:New(scenery1)
local target2=TARGET:New(scenery2)

-- Define missions.
local auftrag1=AUFTRAG:NewORBIT_CIRCLE(scenery1:GetCoordinate(), 10000, 200)
local auftrag2=AUFTRAG:NewORBIT_CIRCLE(scenery2:GetCoordinate(), 12000, 150)

-- Assign missions to reaper.
reaper:AddMission(auftrag1)
reaper:AddMission(auftrag2)


--- Function called when a mission is executed.
function reaper:OnAfterMissionExecute(From, Event, To, Mission)
  local mission=Mission --Ops.Auftrag#AUFTRAG

  local text=string.format("Executing mission %s",mission:GetName())
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)

  if mission.auftragsnummer==auftrag1.auftragsnummer then

    -- Switch LASER on. We set an altitude of 2 meters above ground or we get problems with the line of sight check!
    reaper:LaserOn(scenery1) --:GetCoordinate():SetAltitude(2))
  
    -- After 5 min, destroy the target simulating a successful attack.
    target1:GetCoordinate():Explosion(5000, 5*60)
  
  elseif mission.auftragsnummer==auftrag2.auftragsnummer then

    -- Switch LASER on. We set an altitude of 2 meters above ground or we get problems with the line of sight check!
    reaper:LaserOn(scenery2) --:GetCoordinate():SetAltitude(2))
  
    -- After 5 min, destroy the target.
    target2:GetCoordinate():Explosion(5000, 5*60)
  
  end

end

--- Function called when a mission is over.
function reaper:OnAfterMissionDone(From, Event, To, Mission)
  local mission=Mission --Ops.Auftrag#AUFTRAG

  local text=string.format("Mission %s done!",mission:GetName())
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)
  
  -- Switch LASER off.
  reaper:LaserOff()
  
end

--- Function called when the LASER is switched on.
function reaper:OnAfterLaserOn(From, Event, To, Target)
  local target=Target --Wrapper.Positionable#POSITIONABLE 
  
  local text=string.format("Lasing target at code %d", reaper:GetLaserCode())
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)

end

--- Function called when the LASER is switched off.
function reaper:OnAfterLaserOff(From, Event, To)

  local text=string.format("Switching LASER off")
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)

end


--- Function called when target is destroyed.
function target1:OnAfterDestroyed(From, Event, To)

  local text=string.format("Target %s destroyed", target1:GetName())
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)
  target1:GetCoordinate():SmokeRed()

  -- Get current mission, which should be the orbit mission.
  local mission=reaper:GetMissionCurrent()
  
  if mission then
    reaper:MissionCancel(mission)
  end

end

--- Function called when target is destroyed.
function target2:OnAfterDestroyed(From, Event, To)

  local text=string.format("Target %s destroyed", target2:GetName())
  MESSAGE:New(text, 60, reaper:GetName()):ToAll()
  env.info(text)
  target2:GetCoordinate():SmokeRed()

  -- Get current mission, which should be the orbit mission.
  local mission=reaper:GetMissionCurrent()
  
  if mission then
    reaper:MissionCancel(mission)
  end

end
