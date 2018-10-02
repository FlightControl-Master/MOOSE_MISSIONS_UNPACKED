---
-- Name: ZON-110 - ZONE declared in ME
-- Author: FlightControl
-- Date Created: 21 May 2018
--
-- # Situation:
-- 
-- A ZONE has been defined using the Mission Editor, which boundaries are smoking.
-- A vehicle is driving through the zone perimeters.
-- When the vehicle is driving in the zone, a red smoke is fired from the vehicle location.
-- 
-- # Test cases:
-- 
-- 1. Observe the zone perimeter smoke.
-- 2. Observe the vehicle smoking a red smoke when driving through the zone.


GroupInside = GROUP:FindByName( "Test Inside" )
GroupOutside = GROUP:FindByName( "Test Outside" )

-- Now I can find the zone instead of doing ZONE:New, because the ZONE object is already in MOOSE.
--ZoneA = ZONE:New( "Zone A" )
ZoneA = ZONE:FindByName( "Zone A" )
ZoneA:SmokeZone( SMOKECOLOR.White, 30 )

Messager = SCHEDULER:New( nil,
  function()
    GroupInside:MessageToAll( ( GroupInside:IsCompletelyInZone( ZoneA ) ) and "Inside Zone A" or "Outside Zone A", 1 )
    if GroupInside:IsCompletelyInZone( ZoneA ) then
      GroupInside:GetUnit(1):SmokeRed()
    end
  end, 
  {}, 0, 1 )

