---
-- ARMYGROUP: Basics
-- 
-- A group of two TPz Fuchs are located near the old airfield at Kobuleti.
-- We add two waypoints on road to guide them to the airfield.
-- 
-- When the group passes a waypoint, a message is displayed. Also when the group enters a given zone.
---

-- Create an ARMYGROUP object.
local armygroup=ARMYGROUP:New("TPz Fuchs Group")
armygroup:Activate()

-- Increase verbosity of DCS log file a bit for debugging.
armygroup:SetVerbosity(1)

-- Enable patrol ad infinitum.
armygroup:SetPatrolAdInfinitum()

-- Set of all zones defined in the ME.
local AllZones=SET_ZONE:New():FilterOnce()

-- Set a set of zones which are checked and trigger FSM events when the group enters or leaves the zones.
armygroup:SetCheckZones(AllZones)

-- Some zone.
local zoneWP1=ZONE:New("Zone Waypoint 1")
local zoneWP2=ZONE:New("Zone Waypoint 2")

-- Add waypoints
local wp1=armygroup:AddWaypoint(zoneWP1:GetCoordinate(), 30, nil, ENUMS.Formation.Vehicle.OnRoad)
local wp2=armygroup:AddWaypoint(zoneWP2:GetCoordinate(), 30, nil, ENUMS.Formation.Vehicle.OnRoad)


--- Function called when the group passes a waypoint.
function armygroup:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint

  -- Get unique ID of this waypoint.
  local uid=armygroup:GetWaypointUID(waypoint)
  
  -- Is this the final waypoint?
  local final=armygroup:HasPassedFinalWaypoint()
  
  -- Info message.
  local text=string.format("Group passed waypoint UID=%d for the %d. time. Final=%s", uid, waypoint.npassed, tostring(final))
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end

--- Function called when the group enteres a zone.
function armygroup:OnAfterEnterZone(From, Event, To, Zone)
  local zone=Zone --Core.Zone#ZONE
  
  -- Message.
  local text=string.format("Group %s entered zone %s", armygroup:GetName(), zone:GetName())
  MESSAGE:New(text, 120):ToAll()
  env.info(text)

end

--- Function called when the group leaves a zone.
function armygroup:OnAfterLeaveZone(From,Event,To,Zone)
  local zone=Zone --Core.Zone#ZONE

  -- Message.  
  local text=string.format("Group %s left zone %s", armygroup:GetName(), zone:GetName())
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end