---
-- Mission: INTERCEPT
-- 
-- F-16s are send to intercept a group of Tu-22s.
---


local zoneAlpha=ZONE:New("Zone Alpha")
local zoneBravo=ZONE:New("Zone Bravo")

-- Intruder group.  
local tu22=FLIGHTGROUP:New("Tu-22 Air Group")
tu22:AddWaypoint(zoneAlpha:GetCoordinate():SetAltitude(7000))
tu22:AddWaypoint(zoneBravo:GetCoordinate():SetAltitude(10000))
tu22:Activate()

-- If the intruder makes it to zone Bravo, we send it RTB.
function tu22:OnAfterEnterZone(From, Event, To, zone)
  if zone:GetName()==zoneBravo:GetName() then
    tu22:RTB(AIRBASE:FindByName(AIRBASE.Caucasus.Gudauta))
  end  
end


-- Create an Intercept mission.
local mission=AUFTRAG:NewINTERCEPT(tu22:GetGroup())

-- Interceptor group.
local f16=FLIGHTGROUP:New("F-16 CAP Group")
f16:AddMission(mission)
