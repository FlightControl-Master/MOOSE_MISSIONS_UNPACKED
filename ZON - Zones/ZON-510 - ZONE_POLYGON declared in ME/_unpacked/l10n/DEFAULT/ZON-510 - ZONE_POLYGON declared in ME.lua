---
-- Name: ZON-510 - ZONE_POLYGON declared in ME
-- Author: FlightControl
-- Date Created: 21 May 2018
--
-- # Situation:
-- 
-- A ZONE_POLYGON has been defined, within the mission editor using ~ZONE_POLYGON in the group name.
-- Its boundaries are smoking.
-- A vehicle is driving through the zone perimeters.
-- When the vehicle is driving in the zone, a red smoke is fired from the vehicle location.
-- 
-- # Test cases:
-- 
-- 1. Observe the polygon perimeter smoke.
-- 2. Observe the vehicle smoking a red smoke when driving through the zone.
 
GroupInside = GROUP:FindByName( "Test Inside Polygon" )
GroupOutside = GROUP:FindByName( "Test Outside Polygon" )

PolygonZone = ZONE_POLYGON:FindByName( "Polygon A" )
PolygonZone:SmokeZone( SMOKECOLOR.White, 10 )

Messager = SCHEDULER:New( nil,
  function()
    GroupInside:MessageToAll( ( GroupInside:IsCompletelyInZone( PolygonZone ) ) and "Inside Polygon A" or "Outside Polygon A", 1 )
    if GroupInside:IsCompletelyInZone( PolygonZone ) then
      GroupInside:GetUnit(1):SmokeRed()
    end
  end, 
  {}, 0, 1 )

