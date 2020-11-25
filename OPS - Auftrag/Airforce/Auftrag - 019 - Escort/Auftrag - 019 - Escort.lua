---
-- AUFTRAG: Escort
-- 
-- B-52s will take off from Senaki and fly to zone Alpha and Bravo.
-- A group of F-16s will escort them until they land at Batumi and then return to Senaki.
-- 
-- A group of enemy MiG-29s is also around...
---

local zoneAlpha=ZONE:New("Zone Alpha")
local zoneBravo=ZONE:New("Zone Bravo")

-- Create flight plan for the bomber group.
local b52=FLIGHTGROUP:New("B-52 Kobuleti")
b52:AddWaypoint(zoneAlpha:GetCoordinate():SetAltitude(7000))
b52:AddWaypoint(zoneBravo:GetCoordinate():SetAltitude(5000))
b52:Activate()

-- Once the final waypoint is passed
function b52:OnAfterPassingWaypoint(From, Event, To, Waypoint)
  if b52:HasPassedFinalWaypoint() then
    b52:RTB(AIRBASE:FindByName("Batumi"))
  end  
end

-- The escort group.
local f16=FLIGHTGROUP:New("F-16 CAP Group")

-- Escort the bombers. Engage all air threats withing 32 NM.
local escort=AUFTRAG:NewESCORT(b52:GetGroup(), nil, 32)
f16:AddMission(escort)
