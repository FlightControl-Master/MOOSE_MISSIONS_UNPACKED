---
-- NAVYGROUP: Steam Into Wind
-- 
-- This example shows how you let a group steam into the wind for a certain amount of time.
-- 
-- Naval group "USS Stennis Group" has two waypoint set in the Mission Editor. Mission starts at 0800 hours.
-- 
-- * At 0815 hours, the group will start to steam into the wind until 0830.
-- * Each time after reaching waypoint 2, the group will again steam into the wind.
-- * Each time after reaching waypoint 1, the group will steam into the wind.
---

-- Create a NAVYGROUP object.
local navygroup=NAVYGROUP:New("USS Stennis Group")
navygroup:Activate()

-- Mark waypoints on F10 map. The marks will be removed after 60 seconds.
navygroup:MarkWaypoints(60)

-- Set some parameters.
navygroup:SwitchTACAN(74, "XYZ")
navygroup:SwitchICLS(1, "ABC")
navygroup:SwitchRadio(130)
navygroup:SwitchAlarmstate(ENUMS.AlarmState.Red)
navygroup:SwitchROE(ENUMS.ROE.WeaponFree)

-- Group will turn into the wind at 8:15 hours until 8:30. Wind on deck is 15 knots. Afterwards, the group will return to the position where the turn started and go to the next waypoint.
navygroup:AddTurnIntoWind("8:15", "8:30", 15, true, -9)

--- Function called each time the group passes a waypoint.
function navygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  -- Debug info.
  local text=string.format("Group passed waypoint ID=%d, Index=%d for the %d time", waypoint.uid, navygroup:GetWaypointIndex(waypoint.uid), waypoint.npassed)
  env.info(text)

  if Waypoint.uid==1 then
    -- Turn into wind 15 min after waypoint ID=1 is passed for 20 min. U-turn=false, i.e. after turn into wind is over, it will directly go to the next waypoint.
    navygroup:AddTurnIntoWind(15*60, 20*60, 15, false, -9)
  elseif Waypoint.uid==2 then
    -- Turn into wind 15 minafter waypoint ID=2 is passed for 15 min. U-turn=true, i.e. group will resume its route at the position the turn started.
    navygroup:AddTurnIntoWind(15*60, 15*60, 20, true, -9)
  end

end

--- Function called each time the group starts turning into the wind.
function navygroup:OnAfterTurnIntoWind(From, Event, To, TurnIntoWind)
  local tiw=TurnIntoWind --Ops.NavyGroup#NAVYGROUP.IntoWind
  local text=string.format("Group is turning into the wind for %d seconds. Speed=%d knots. U-turn=%s", tiw.Tstop-tiw.Tstart, tiw.Speed, tostring(tiw.Uturn))
  env.info(text)
end
