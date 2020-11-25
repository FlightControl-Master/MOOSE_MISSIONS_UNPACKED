---
-- ARMYGROUP: Zone Hopping
-- 
-- A couple of trigger zones were created in the mission editor.
-- 
-- A TPz Fuchs group is ordered to go to a random zone. Once it enters the zone, another random zone is selected as next waypoint.
---

-- Create ARMYGROUP object.
local armygroup=ARMYGROUP:New("TPz Fuchs Group")
armygroup:Activate()

-- Set of all zones defined in the ME.
local AllZones=SET_ZONE:New():FilterOnce()

-- Trigger events when group enters or leaves zhe defined zones.
armygroup:SetCheckZones(AllZones)

-- Zones where to go to.
local zones={
  ZONE:New("Zone Kobuleti X"),
  ZONE:New("Zone Poti"),
  ZONE:New("Zone Sukhumi"),
  ZONE:New("Zone Batumi"),
  ZONE:New("Zone Kutaisi"),
  ZONE:New("Zone Zugdidi"),
  ZONE:New("Zone Honi"),
  ZONE:New("Zone Lanchhuti"),
  ZONE:New("Zone Vani"),
}

-- Get a random zone and remove it.
local function GetRandomZone()
  local N=#zones
  if N>0 then
    local i=math.random(N)
    local zone=zones[i]
    table.remove(zones, i)
    return zone
  else
    return nil
  end
end

-- Get a random zone.
local zonenext=GetRandomZone() --Core.Zone#ZONE

-- Add waypoint.
armygroup:AddWaypoint(zonenext:GetCoordinate():GetClosestPointToRoad(), 30, nil, ENUMS.Formation.Vehicle.OnRoad)

--- Function called when the group enteres a zone.
function armygroup:OnAfterEnterZone(From, Event, To, Zone)
  local zone=Zone --Core.Zone#ZONE

  -- Get a random zone.
  local zonenext=GetRandomZone() --Core.Zone#ZONE
  
  if zonenext then
    
    -- Add waypoint.
    armygroup:AddWaypoint(zonenext:GetCoordinate():GetClosestPointToRoad(), 30, nil, ENUMS.Formation.Vehicle.OnRoad)
  
    -- Message.
    local text=string.format("Group %s entered zone %s. Next stop zone %s", armygroup:GetName(), zone:GetName(), zonenext:GetName())
    MESSAGE:New(text, 120):ToAll()
    env.info(text)
  
  end
  
end

--- Function called when the group leaves a zone.
function armygroup:OnAfterLeaveZone(From,Event,To,Zone)
  local zone=Zone --Core.Zone#ZONE
  
  -- Message.
  local text=string.format("Group %s left zone %s", armygroup:GetName(), zone:GetName())
  MESSAGE:New(text, 120):ToAll()
  env.info(text)
  
end

