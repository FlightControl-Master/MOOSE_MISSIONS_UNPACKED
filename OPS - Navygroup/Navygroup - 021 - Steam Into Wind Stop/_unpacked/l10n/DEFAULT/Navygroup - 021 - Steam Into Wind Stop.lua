---
-- NAVYGROUP: Stopping and Removing Turns Into Wind
-- 
-- Naval group "USS Stennis Group" has two waypoint set in the Mission Editor. Mission starts at 0800 hours.
-- 
-- We add three "recovery windows", where the group turns into the wind for a given amount of time.
-- 
-- The first window, which is supposed to last for 25 min, is stopped already after 10 min.
-- The second window is removed from the queue as soon as it opens. That also stopps the window.
-- The third window is removed from the queue when the first window is started. It will never be executed.
-- 
-- There are also a couple of events created when the turn is starting, the group is directly facing the wind, the window was stopped and when it is over. 
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Stennis Group")
navygroup:Activate()

-- Increase DCS log output.
navygroup:SetVerbosity(3)


-- Turn into the wind at 8:05 until 8:30 hours. Wind on deck is 15 knots. U-turn is false. Course offset is -9 degrees to account for the angled deck. 
local tiw1=navygroup:AddTurnIntoWind("8:05", "8:30", 15, false, -9)

-- Turn into the wind at 8:45 for 30 min. Wind on deck is 25 knots. U-turn is true. Course offset is -9 degrees to account for the angled deck.
local tiw2=navygroup:AddTurnIntoWind("8:45", 30*60, 25, true, -9)

-- Turn into the wind at 9:30. Wind on deck is 5 knots. U-turn is off. Course offset is -9 degrees to account for the angled deck.
local tiw3=navygroup:AddTurnIntoWind("9:30", "9:45",  5, nil, -9)


--- Function called each time the group starts turning into the wind.
function navygroup:OnAfterTurnIntoWind(From, Event, To, TurnIntoWind)
  local tiw=TurnIntoWind --Ops.NavyGroup#NAVYGROUP.IntoWind
  
  -- Debug text.  
  local text=string.format("Group is turning into the wind (ID=%d) for %d seconds. Speed=%d knots. U-turn=%s", tiw.Id, tiw.Tstop-tiw.Tstart, tiw.Speed, tostring(tiw.Uturn))
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
  
  
  if tiw.Id==tiw1.Id then
  
    -- After 10 min, stop this window. Group will resume its route. 
    navygroup:__TurnIntoWindStop(10*60)
    
    -- We also changed our mind and remove the third window before it even started
    navygroup:RemoveTurnIntoWind(tiw3)
    
  elseif tiw.Id==tiw2.Id then
    
    -- We also remove the second window when it starts. This automatically stops the turn into wind.
    navygroup:RemoveTurnIntoWind(tiw)
  end
  
end


--- Function called when the actual turn into the wind is over and the group is facing directly into the wind (apart from the given offset, if any).
function navygroup:OnAfterTurnedIntoWind(From, Event, To)

  -- Info message.
  local text=string.format("Group finished turn and is now steaming directly into the wind!")
  MESSAGE:New(text, 360):ToAll()
  env.info(text)

end
--- Function called when the current window is stopped.
function navygroup:OnAfterTurnIntoWindStop(From, Event, To)

  -- Info message.
  local text=string.format("Group will stop turning into the wind now!")
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
  
end

--- Function called when the current window is over. Time was up or stopped.
function navygroup:OnAfterTurnIntoWindOver(From, Event, To, TurnIntoWind)
  local tiw=TurnIntoWind --Ops.NavyGroup#NAVYGROUP.IntoWind

  -- Info message.
  local text=string.format("Turn into the wind (ID=%d) is over. Speed was %d knots. U-turn was %s", tiw.Id, tiw.Speed, tostring(tiw.Uturn))
  MESSAGE:New(text, 360):ToAll()
  env.info(text)

end