-------------------------
-- AIRBOSS Test Script --
-------------------------

-- Set mission menu.
AIRBOSS.MenuF10Root=MENU_MISSION:New("Airboss").MenuPath

-- No MOOSE settings menu.
_SETTINGS:SetPlayerMenuOff()

-- S-3B Recovery Tanker spawning in air.
local tanker=RECOVERYTANKER:New("USS Stennis", "Texaco Group")
tanker:SetTakeoffAir()
tanker:SetRadio(250)
tanker:SetModex(511)
tanker:SetTACAN(1, "TKR")
tanker:__Start(1)

-- E-2D AWACS spawning on Stennis.
local awacs=RECOVERYTANKER:New("USS Stennis", "E-2D Wizard Group")
awacs:SetAWACS()
awacs:SetRadio(260)
awacs:SetAltitude(20000)
awacs:SetCallsign(CALLSIGN.AWACS.Darkstar)
awacs:SetRacetrackDistances(30, 15)
awacs:SetModex(611)
awacs:SetTACAN(2, "WIZ")
awacs:__Start(1)

-- Rescue Helo with home base Lake Erie. Has to be a global object!
rescuehelo=RESCUEHELO:New("USS Stennis", "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("Lake Erie"))
rescuehelo:SetModex(42)
rescuehelo:__Start(1)
  
-- Create AIRBOSS object.
local AirbossStennis=AIRBOSS:New("USS Stennis")

-- Add recovery windows:
-- Case I from 9 to 10 am.
local window1=AirbossStennis:AddRecoveryWindow( "9:00", "10:00", 1, nil, true, 25)
-- Case II with +15 degrees holding offset from 15:00 for 60 min.
local window2=AirbossStennis:AddRecoveryWindow("15:00", "16:00", 2,  15, true, 23)
-- Case III with +30 degrees holding offset from 2100 to 2200.
local window3=AirbossStennis:AddRecoveryWindow("21:00", "22:00", 3,  30, true, 21)

-- Set folder of airboss sound files within miz file.
AirbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")

-- Single carrier menu optimization.
AirbossStennis:SetMenuSingleCarrier()

-- Skipper menu.
AirbossStennis:SetMenuRecovery(30, 20, false)

-- Remove landed AI planes from flight deck.
AirbossStennis:SetDespawnOnEngineShutdown()

-- Load all saved player grades from your "Saved Games\DCS" folder (if lfs was desanitized).
AirbossStennis:Load()

-- Automatically save player results to your "Saved Games\DCS" folder each time a player get a final grade from the LSO.
AirbossStennis:SetAutoSave()

-- Enable trap sheet.
AirbossStennis:SetTrapSheet()

-- Set recovery tanker.
AirbossStennis:SetRecoveryTanker(tanker)

-- Set AWACS.
AirbossStennis:SetAWACS(awacs)

-- Start airboss class.
AirbossStennis:Start()

-- Use recovery tanker as radio relay for LSO.
function tanker:OnAfterStart(From,Event,To)
  AirbossStennis:SetRadioRelayLSO(self:GetUnitName())
end

-- Use rescue helo as radio relay for Marshal.
function rescuehelo:OnAfterStart(From,Event,To)
  AirbossStennis:SetRadioRelayMarshal(self:GetUnitName())
end

-- Report LSO grade to dcs.log file.
function AirbossStennis:OnAfterLSOgrade(From,Event,To,playerData,grade)
  local PlayerData=playerData --Ops.Airboss#AIRBOSS.PlayerData
  local Grade=grade --Ops.Airboss#AIRBOSS.LSOgrade
  
  local score=Grade.points
  local name=PlayerData.name

  env.info(string.format("Player %s scored %.1f", name, score))

end


---------------------------
--- Generate AI Traffic ---
---------------------------

-- Spawn some AI flights as additional traffic.
local F181=SPAWN:New("FA-18C Group 1"):InitModex(111) -- Coming in from NW after  ~6 min
local F182=SPAWN:New("FA-18C Group 2"):InitModex(112) -- Coming in from NW after ~20 min
local F183=SPAWN:New("FA-18C Group 3"):InitModex(113) -- Coming in from W  after ~18 min
local F14=SPAWN:New("F-14B 2ship"):InitModex(211)   -- Coming in from SW after  ~4 min
local E2D=SPAWN:New("E-2D Group"):InitModex(311)    -- Coming in from NE after ~10 min
local S3B=SPAWN:New("S-3B Group"):InitModex(411)    -- Coming in from S  after ~16 min
  
-- Spawn always 9 min before the recovery window opens.
local spawntimes={"8:51", "14:51", "20:51"}
for _,spawntime in pairs(spawntimes) do
  local _time=UTILS.ClockToSeconds(spawntime)-timer.getAbsTime()
  if _time>0 then
    SCHEDULER:New(nil, F181.Spawn, {F181}, _time)
    SCHEDULER:New(nil, F182.Spawn, {F182}, _time)
    SCHEDULER:New(nil, F183.Spawn, {F183}, _time)
    SCHEDULER:New(nil, F14.Spawn,  {F14},  _time)
    SCHEDULER:New(nil, E2D.Spawn,  {E2D},  _time)
    SCHEDULER:New(nil, S3B.Spawn,  {S3B},  _time)
  end
end



local function checkmem()
  local time=timer.getTime()
  local clock=UTILS.SecondsToClock(time)
  local mem=collectgarbage("count")
  env.info(string.format("T=%s  Memory usage %d kByte = %.2f MByte", clock, mem, mem/1024))
end

SCHEDULER:New(nil, checkmem, {}, 60, 5*60)