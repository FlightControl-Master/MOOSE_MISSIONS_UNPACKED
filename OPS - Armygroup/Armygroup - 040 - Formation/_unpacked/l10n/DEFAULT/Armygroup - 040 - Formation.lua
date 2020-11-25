---
-- ARMYGROUP: Switch Formation
-- 
-- A group ten Abrams tanks is conducting an exercise in the desert.
-- They are practicing to seemlessly change formations when certain waypoints are passed.
-- 
-- When reaching waypoint 7 (the first waypoint is the initial (spawn) position), the
-- group searches the closest road and will drive to Palmyra airbase.
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("M1A2 Abrams")
armygroup:Activate(1)

-- Default formation is Echelon Left. We switch to this right after the group is activated.
armygroup:SetDefaultFormation(ENUMS.Formation.Vehicle.EchelonLeft)

--- Function called when a group passes a waypoint.
function armygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
  
  if waypoint.uid==2 then
    armygroup:SwitchFormation(ENUMS.Formation.Vehicle.EchelonRight)
  elseif waypoint.uid==3 then
    armygroup:SwitchFormation(ENUMS.Formation.Vehicle.Vee)
  elseif waypoint.uid==4 then
    armygroup:SwitchFormation(ENUMS.Formation.Vehicle.Rank)
  elseif waypoint.uid==5 then
    armygroup:SwitchFormation(ENUMS.Formation.Vehicle.Cone)
  elseif waypoint.uid==6 then
    armygroup:SwitchFormation(ENUMS.Formation.Vehicle.Diamond)
  elseif waypoint.uid==7 then
    armygroup:AddWaypoint(ZONE:New("Zone Palmyra Airport"):GetCoordinate(), 30, nil, ENUMS.Formation.Vehicle.OnRoad)
  end
  
end