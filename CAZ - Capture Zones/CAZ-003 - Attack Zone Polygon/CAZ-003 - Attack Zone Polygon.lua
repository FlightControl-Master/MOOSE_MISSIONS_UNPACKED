---
-- Name: CAZ-003 - Capture Zone, Zone as ZONE_POLYGON
-- Author: Applevangelist
-- Date Created: Sept 2022
--
-- # Situation: Capture the zone around the Ammo Storage, jump into one of the tanks (requires Combined Arms)
--
-- # Test cases: Watch the state changes as you shoot, destroy the storage and enter the zone with the tank.
-- 

do -- Setup the Command Centers
  
  RU_CC = COMMANDCENTER:New( GROUP:FindByName( "REDHQ" ), "Russia HQ" )
  US_CC = COMMANDCENTER:New( GROUP:FindByName( "BLUEHQ" ), "USA HQ" )

end

do -- Missions
  
  US_Mission_EchoBay = MISSION:New( US_CC, "Echo Bay", "Primary",
    "Welcome trainee. The airport Groom Lake in Echo Bay needs to be captured.\n" ..
    "There are five random capture zones located at the airbase.\n" ..
    "Move to one of the capture zones, destroy the fuel tanks in the capture zone, " ..
    "and occupy each capture zone with a platoon.\n " .. 
    "Your orders are to hold position until all capture zones are taken.\n" ..
    "Use the map (F10) for a clear indication of the location of each capture zone.\n" ..
    "Note that heavy resistance can be expected at the airbase!\n" ..
    "Mission 'Echo Bay' is complete when all five capture zones are taken, and held for at least 5 minutes!"
    , coalition.side.RED)
    
  US_Score = SCORING:New( "CAZ-001 - Capture Zone" )
    
  US_Mission_EchoBay:AddScoring( US_Score )
  
  US_Mission_EchoBay:Start()

end



BASE:TraceOn()
BASE:TraceClass("ZONE_CAPTURE_COALITION")

-- Draw Zone on Map
CaptureZone = ZONE_POLYGON:NewFromGroupName("CapZone")
CaptureZone:DrawZone(-1,{0,1,0},nil,nil,nil,1,true)

-- Start ZONE_CAPTURE_COALITION
ZoneCaptureCoalition = ZONE_CAPTURE_COALITION:New( "CapZone", coalition.side.RED ) 
ZoneCaptureCoalition:SetSmokeZone(true)
ZoneCaptureCoalition:SetMonitorHits(true,60)

--- @param Functional.ZoneCaptureCoalition#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalition:OnEnterGuarded( From, Event, To )
  if From ~= To then
    local Coalition = self:GetCoalition()
    self:E( { Coalition = Coalition } )
    if Coalition == coalition.side.BLUE then
      ZoneCaptureCoalition:Smoke( SMOKECOLOR.Blue )
      US_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
      RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    else
      ZoneCaptureCoalition:Smoke( SMOKECOLOR.Red )
      RU_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
      US_CC:MessageTypeToCoalition( string.format( "%s is under protection of Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    end
  end
end

--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalition:OnEnterEmpty()
  ZoneCaptureCoalition:Smoke( SMOKECOLOR.Green )
  US_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
  RU_CC:MessageTypeToCoalition( string.format( "%s is unprotected, and can be captured!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
end


--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalition:OnEnterAttacked()
  ZoneCaptureCoalition:Smoke( SMOKECOLOR.White )
  local Coalition = self:GetCoalition()
  self:E({Coalition = Coalition})
  if Coalition == coalition.side.BLUE then
    US_CC:MessageTypeToCoalition( string.format( "%s is under attack by Russia", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    RU_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
  else
    RU_CC:MessageTypeToCoalition( string.format( "%s is under attack by the USA", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    US_CC:MessageTypeToCoalition( string.format( "We are attacking %s", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
  end
end

--- @param Functional.Protect#ZONE_CAPTURE_COALITION self
function ZoneCaptureCoalition:OnEnterCaptured()
  local Coalition = self:GetCoalition()
  self:E({Coalition = Coalition})
  if Coalition == coalition.side.BLUE then
    RU_CC:MessageTypeToCoalition( string.format( "%s is captured by the USA, we lost it!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    US_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
  else
    US_CC:MessageTypeToCoalition( string.format( "%s is captured by Russia, we lost it!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
    RU_CC:MessageTypeToCoalition( string.format( "We captured %s, Excellent job!", ZoneCaptureCoalition:GetZoneName() ), MESSAGE.Type.Information )
  end
  
  self:AddScore( "Captured", "Zone captured: Extra points granted.", 200 )    
  
  self:__Guard( 30 )
end

ZoneCaptureCoalition:__Guard( 1 )
  
ZoneCaptureCoalition:Start( 30, 30 )
  


