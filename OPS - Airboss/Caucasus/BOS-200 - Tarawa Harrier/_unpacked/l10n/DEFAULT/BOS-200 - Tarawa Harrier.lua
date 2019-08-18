----------------------------------------------------------------------------------------
---
-- Name: BOS-200 - Tarawa Harrier
-- Author: funkyfranky
-- Date Created: 18 August 2019
--
-- # Situation:
-- 
-- Practice Case I/II/III recovery using the AV-8B Harrier on the USS Tarawa.
-- 
-- See mission briefing for further details.
-- 
-- *** IMPORTANT ***
-- If you run the mission in single player, hit ESC twice before entering a slot!
-- Otherwise the script will not load due to a long standing DCS bug.
--
----------------------------------------------------------------------------------------

-- No MOOSE settings menu. Comment out this line if required.
_SETTINGS:SetPlayerMenuOff()

-- Rescue Helo with home base USS Viksburg. Has to be a global object!
rescuehelo=RESCUEHELO:New("USS Tarawa", "Rescue Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("USS Viksburg"))
rescuehelo:SetModex(42)
  
-- Create AIRBOSS object.
local AirbossTarawa=AIRBOSS:New("USS Tarawa")

-- Add recovery windows:
-- Case I from 9:00 to 10:00 am.
local window1=AirbossTarawa:AddRecoveryWindow( "9:00", "10:00", 1, nil, true, 25)
-- Case II with +15 degrees holding offset from 15:00 for 60 min.
local window2=AirbossTarawa:AddRecoveryWindow("15:00", "16:00", 2, 15, true, 20)
-- Case III with +30 degrees holding offset from 2100 to 2200.
local window3=AirbossTarawa:AddRecoveryWindow("21:00", "22:00", 3, 30, true, 20)

-- Set TACAN.
AirbossTarawa:SetTACAN(73, "X", "LHA")

-- Not sure if Tarawa has ICLS?
--AirbossTarawa:SetICLSoff()

-- Load all saved player grades from your "Saved Games\DCS" folder (if lfs was desanitized).
AirbossTarawa:Load()

-- Automatically save player results to your "Saved Games\DCS" folder each time a player get a final grade from the LSO.
AirbossTarawa:SetAutoSave()

-- Set radio relay units in order to properly send transmissions with subtitles only visible if correct frequency is tuned in.
AirbossTarawa:SetRadioRelayLSO("CH-53E Radio Relay")
AirbossTarawa:SetRadioRelayMarshal("SH-60B Radio Relay")

-- Radios.
AirbossTarawa:SetMarshalRadio(243)
AirbossTarawa:SetLSORadio(265)

--Set folder of airboss sound files within miz file.
AirbossTarawa:SetSoundfilesFolder("Airboss Soundfiles/")

-- Remove landed AI planes from flight deck.
AirbossTarawa:SetDespawnOnEngineShutdown()

-- Single carrier menu optimization.
AirbossTarawa:SetMenuSingleCarrier()

-- Add Skipper menu to start recovery via F10 radio menu.
AirbossTarawa:SetMenuRecovery(30, 20, true)

-- Start Airboss.
AirbossTarawa:Start()


--- Function called when a recovery starts.
function AirbossTarawa:OnAfterRecoveryStart(From, Event, To, Case, Offset)
  -- Start helo.
  rescuehelo:Start()
end

--- Function called when a recovery ends.
function AirbossTarawa:OnAfterRecoveryStop(From,Event,To)
  -- Send helo RTB.
  rescuehelo:RTB()
end

--- Function called when the rescue helo has returned to base.
function rescuehelo:OnAfterReturned(From, Event, To, airbase)
  -- Stop helo.
  self:__Stop(3)
end

--- Function called when a player gets graded by the LSO.
function AirbossTarawa:OnAfterLSOGrade(From, Event, To, playerData, grade)
  local PlayerData=playerData --Ops.Airboss#AIRBOSS.PlayerData
  local Grade=grade --Ops.Airboss#AIRBOSS.LSOgrade

  ----------------------------------------
  --- Interface your Discord bot here! ---
  ----------------------------------------
  
  local score=tonumber(Grade.points)
  local name=tostring(PlayerData.name)
  
  -- Report LSO grade to dcs.log file.
  env.info(self.lid..string.format("Player %s scored %.1f", name, score))
end


---------------------------
--- Generate AI Traffic ---
---------------------------

local AV8B1=SPAWN:New("Harrier Group 1"):InitModex(70)
local AV8B2=SPAWN:New("Harrier Group 2"):InitModex(80)

-- Spawn always 9 min before the recovery window opens.
local spawntimes={"9:06", "14:51", "20:51"}
for _,spawntime in pairs(spawntimes) do
  local _time=UTILS.ClockToSeconds(spawntime)-timer.getAbsTime()
  if _time>0 then
    SCHEDULER:New(nil, AV8B1.Spawn, {AV8B1}, _time)
    SCHEDULER:New(nil, AV8B2.Spawn, {AV8B2}, _time)
  end
end
