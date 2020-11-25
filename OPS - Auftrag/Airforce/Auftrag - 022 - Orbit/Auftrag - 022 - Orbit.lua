---
-- AUFTRAG: Orbit
-- 
-- Hornet group is assigned missions to orbit at different zones.
-- Adding, cancelling Missions and setting priorities and importance.
-- 
-- 1.) Flight will first orbit at zone Charlie as this has the highest priority (lowest value). 5 min after the mission is executed, it is cancelled.
-- 2.) Flight will then orbit at zone Delta. But the mission starts at 8:15. So the flight will wait at its current position until the mission starts.
-- 3.) At 8:30 the previous mission ends and the flight proceeds to zone Bravo. Note that this mission has a lower importances than mission Delta and will therefore only be executed when mission Delta is finished.
-- 4.) When mission Bravo is executed, mission Alpha is added. It has a higher prio AND is urgent. So when mission Alpha starts at 8:45
---

-- Orbit zones.
local zoneAlpha=ZONE:New("Zone Alpha")
local zoneBravo=ZONE:New("Zone Bravo")
local zoneCharlie=ZONE:New("Zone Charlie")
local zoneDelta=ZONE:New("Zone Delta")

-- Create a flight group.
local flightgroup=FLIGHTGROUP:New("F/A-18 Batumi")
flightgroup:SetVerbosity(2)

-- Table of missions.
local mission={}

-- Create orbit missions at different zones.
mission.Alpha=AUFTRAG:NewORBIT_CIRCLE(zoneAlpha:GetCoordinate(), 5000, 350):SetName("Orbit Alpha")
mission.Bravo=AUFTRAG:NewORBIT_RACETRACK(zoneBravo:GetCoordinate(), 10000, 400, 090, 20):SetName("Orbit Bravo")
mission.Charlie=AUFTRAG:NewORBIT_CIRCLE(zoneCharlie:GetCoordinate(), 12000, 450):SetName("Orbit Charlie")
mission.Delta=AUFTRAG:NewORBIT_CIRCLE(zoneDelta:GetCoordinate(), 20000, 420):SetName("Orbit Delta")
mission.Foxtrot=AUFTRAG:NewORBIT_CIRCLE(zoneAlpha:GetCoordinate(), 20000, 420):SetName("Orbit Foxtrot")

mission.Charlie:SetPriority(10)
mission.Delta:SetPriority(20, nil, 1)
mission.Delta:SetTime("8:15", "8:30")
mission.Bravo:SetPriority(30, nil, 2)
mission.Alpha:SetPriority(25, true)
mission.Alpha:SetTime("8:45", "9:15")


--- Function called when mission Charlie is executed, i.e. the orbit task is started.
function mission.Charlie:OnAfterExecuting(From, Event, To)
  -- Mission is cancelled 5 min after it is executed.
  mission.Charlie:__Cancel(5*60)
end

--- Function called when mission Bravo is executed.
function mission.Bravo:OnAfterExecuting(From,Event,To)
  -- Add mission Alpha.
  flightgroup:AddMission(mission.Alpha)
end

-- Mission is cancelled after 10 min. It will never be started.
mission.Foxtrot:__Cancel(10*60)


-- Add all missions execpt 
for _,auftrag in pairs(mission) do
  if auftrag:GetName()~="Orbit Alpha" then
    flightgroup:AddMission(auftrag)
  end
end
