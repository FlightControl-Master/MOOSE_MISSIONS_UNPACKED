-------------------------------------------------------------------------
-- AWC-100 Basic Demo
-------------------------------------------------------------------------
-- Documentation
-- 
-- Ops AWACS https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.AWACS.html
--
-------------------------------------------------------------------------
-- Basic demo of AWACS functionality. You can join one of the planes 
-- and switch to AM 255 to listen in. Also, check out the F10 menu.
-------------------------------------------------------------------------
-- Date: May 2022
-------------------------------------------------------------------------

---- These are set in ME trigger
local hereSRSPath = mySRSPath or "C:\\Program Files\\DCS-SimpleRadio-Standalone"
local hereSRSPort = mySRSPort or 5002
local hereSRSGoogle = mySRSGKey or "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourkey.json"

--- SETTINGS
_SETTINGS:SetLocale("en")
_SETTINGS:SetImperial()
_SETTINGS:SetPlayerMenuOff()

-- We need an AirWing
local AwacsAW = AIRWING:New("AirForce WH-1","AirForce One")
--AwacsAW:SetReportOn()
AwacsAW:SetMarker(false)
AwacsAW:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Kutaisi))
AwacsAW:SetRespawnAfterDestroyed(900)
AwacsAW:SetTakeoffAir()
AwacsAW:__Start(2)

-- And a couple of Squads
-- AWACS itself
local Squad_One = SQUADRON:New("Awacs One",2,"Awacs North")
Squad_One:AddMissionCapability({AUFTRAG.Type.ORBIT},100)
Squad_One:SetFuelLowRefuel(true)
Squad_One:SetFuelLowThreshold(0.2)
Squad_One:SetTurnoverTime(10,20)
AwacsAW:AddSquadron(Squad_One)
AwacsAW:NewPayload("Awacs One One",-1,{AUFTRAG.Type.ORBIT},100)

-- Escorts
local Squad_Two = SQUADRON:New("Escorts",4,"Escorts North")
Squad_Two:AddMissionCapability({AUFTRAG.Type.ESCORT})
Squad_Two:SetFuelLowRefuel(true)
Squad_Two:SetFuelLowThreshold(0.3)
Squad_Two:SetTurnoverTime(10,20)
Squad_Two:SetTakeoffAir()
Squad_Two:SetRadio(255,radio.modulation.AM)
AwacsAW:AddSquadron(Squad_Two)
AwacsAW:NewPayload("Escorts",-1,{AUFTRAG.Type.ESCORT},100)

-- CAP
local Squad_Three = SQUADRON:New("CAP",10,"CAP North")
Squad_Three:AddMissionCapability({AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},80)
Squad_Three:SetFuelLowRefuel(true)
Squad_Three:SetFuelLowThreshold(0.3)
Squad_Three:SetTurnoverTime(10,20)
Squad_Three:SetTakeoffAir()
Squad_Two:SetRadio(255,radio.modulation.AM)
AwacsAW:AddSquadron(Squad_Three)
AwacsAW:NewPayload("Aerial-1-2",-1,{AUFTRAG.Type.ALERT5,AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},100)

-- We need a secondary AirWing for testing
local AwacsAW2 = AIRWING:New("AirForce WH-2","AirForce Two")
--AwacsAW2:SetReportOn()
AwacsAW2:SetMarker(false)
AwacsAW2:SetAirbase(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi))
AwacsAW2:SetRespawnAfterDestroyed(900)
AwacsAW2:SetTakeoffAir()
AwacsAW2:__Start(2)

-- CAP2
local Squad_ThreeOne = SQUADRON:New("CAP2",10,"CAP West")
Squad_ThreeOne:AddMissionCapability({AUFTRAG.Type.ALERT5, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},80)
Squad_ThreeOne:SetFuelLowRefuel(true)
Squad_ThreeOne:SetFuelLowThreshold(0.3)
Squad_ThreeOne:SetTurnoverTime(10,20)
Squad_ThreeOne:SetTakeoffAir()
Squad_Two:SetRadio(255,radio.modulation.AM)
AwacsAW2:AddSquadron(Squad_ThreeOne)
AwacsAW2:NewPayload("CAP 2-1",-1,{AUFTRAG.Type.ALERT5,AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT},100)

-- Get AWACS started
local testawacs = AWACS:New("AWACS North",AwacsAW,"blue",AIRBASE.Caucasus.Kutaisi,"Awacs Orbit",ZONE:FindByName("Rock"),"Fresno",255,radio.modulation.AM )
testawacs.debug = false
testawacs:SetEscort(2)
testawacs:SetAwacsDetails(CALLSIGN.AWACS.Darkstar,1,30,280,88,25)

-- Set up SRS
if hereSRSGoogle then
  -- use Google
  testawacs:SetSRS(hereSRSPath,"female","en-GB",hereSRSPort,"en-GB-Wavenet-F",0.9,hereSRSGoogle)
else
  -- use Windows
  testawacs:SetSRS(hereSRSPath,"male","en-GB",hereSRSPort,nil,0.9)
end

-- Set details
testawacs:SetTOS(4,4)
testawacs:DrawFEZ()
testawacs:SetRejectionZone(ZONE:FindByName("Red Border"),true)
testawacs:AddCAPAirWing(AwacsAW2)
testawacs:SetAICAPDetails(CALLSIGN.F16.Rattler,4,4,300)
testawacs:SetModernEraAgressive()

testawacs:__Start(5)

-- Red CAP Aggressors
function GetRedCAP()
  local caps = SPAWN:New("Red CAP")
    :InitLimit(2,10)
    :InitCleanUp(60)
    :SpawnScheduled(300,0.1)
  local TU22 = SPAWN:New("TU-22")
    :InitLimit(1,10)
    :InitCleanUp(60)
    :SpawnScheduled(360,0.1)
  local Fulcrum = SPAWN:New("Aerial-1")
    :InitLimit(4,10)
    :InitCleanUp(60)
    :SpawnScheduled(420,0.1) 
  local Bears = SPAWN:New("Aerial-2")
    :InitLimit(4,10)
    :InitCleanUp(60)
    :SpawnScheduled(480,0.1) 
end

local captimer = TIMER:New(GetRedCAP)
captimer:Start(600)

-- let the tanker disappear
function DestroyTanker()
  local tanker=GROUP:FindByName("Red Tanker")
  tanker:Destroy(true)
end

local tankertimer = TIMER:New(DestroyTanker)
tankertimer:Start(720)