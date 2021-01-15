--- MEN-003-MENU_MISSION_COMMAND
-- Name: MEN-003-MENU_MISSION_COMMAND.lua
-- Author: Wingthor and Saint185
-- Date Created: 15 January 2021
--
-- # Situation:
-- A squad with SU15T. After a few seconds a menu with call to check Wingmens current Ordnance.
-- Check code for how to create a dynamic menu with a for iteration and table.
-- Check code for forward declaration of a function.

-- This logic is Universal, it will work with any human flyable plane RED or BLUE just name your GROUP "Player". Under the Skill box select "client" as your plane 
BASE:TraceOnOff(true)
BASE:TraceAll(true)
-- GLOBALS For easy mission tweaking
env.info ("------------------------- STARING SCRIPT ---------------------------------")
CASZone = "Zone Charlie"
PlayersGroupName = "Player"
BuildMenu = function() end -- Forward declaration  
------------------------------------END GLOBALS-------------------------------------------------------------
--Create TASK Zone
local zoneCharlie=ZONE:New(CASZone)
-- Add scheduled command, now holds the BuildMenu Call
local start = SCHEDULER:New(nil,function()
  -- Create a flight group.
  flightgroup = FLIGHTGROUP:New(PlayersGroupName)
  flightgroup:SetDetection(true)
  --- Function called when the group detectes a previously unkwown unit.
  function flightgroup:OnAfterDetectedUnitNew(From, Event, To, Unit)
    local unit=Unit --Wrapper.Unit#UNIT
    -- Message to everybody and in the DCS log file.
    local text=string.format("Detected unit %s", unit:GetName())
    MESSAGE:New(text, 20,flightgroup:GetName()):ToAll()
    env.info(text)
  end
  -- Create a CAS mission.
  local mission=AUFTRAG:NewCAS(zoneCharlie)
  mission:SetEngageAltitude(10000)
  mission:SetWeaponExpend(AI.Task.WeaponExpend.ONE)
  -- Assign mission to pilot.
  flightgroup:AddMission(mission)
  -- Build Menu for Ammo Check
  BuildMenu()
  end,
{},1,30000 ) 

---function to check ammo for a give wingman
---@param Wingman number
local function AmmoCheck(Wingman)--function for wingman 2
  local unitsAmmoTable = units[Wingman]:GetAmmo()--gets the ammo for each unit and dumps it into unittable TABLE
  local callsign = units[Wingman]:GetCallsign()--gets the callsign for each unit and dumps it into callsign TABLE
--this logic splits out each ammo type and name and inserts it into the Message
  local count = {}
  local desc = {}
  -- local ammoUnits = ammo[2]
  local WepMessage = "   "
  for i = 1, #unitsAmmoTable do
    local ammocount = unitsAmmoTable[i].count
    local ammodesc = unitsAmmoTable[i].desc.displayName
    table.insert (count,ammocount)
    table.insert (desc,ammodesc)
    WepMessage = WepMessage .. desc[i] .. ": " .. count[i] .. "\n   "
    
  end
  MESSAGE:New( callsign ..":\n------------------------------------\n" .. WepMessage, 10):ToAll()
end

local function CheckAll()
  units =  GROUP:FindByName( PlayersGroupName ):GetUnits() --gets the number of units in the group
  for i = 2, #units do
    AmmoCheck(i)
  end
end

BuildMenu = function()
  BASE:E("--- Info: Building menu ---")
  units =  GROUP:FindByName( PlayersGroupName ):GetUnits() --gets the number of units in the group
  --AmmoCheckMainMenu
  Level1 = MENU_MISSION:New( "Flight Ammo Check" )
  LevelMenues = {}
  CommandMenues = {}
  for i = 2, #units do
    LevelMenues[i] = MENU_MISSION:New( "Wingman " .. i ,Level1 )
    CommandMenues[i] = MENU_MISSION_COMMAND:New("AmmoStatus " ..  i, LevelMenues[i], AmmoCheck,i)
  end
  CommandMenuesAll = MENU_MISSION_COMMAND:New("AmmoStatus All", Level1, CheckAll)
end

-- BASE:ScheduleOnce(10,BuildMenu) If you prefer a scheduled command

HandleDeath = EVENTHANDLER:New():HandleEvent(EVENTS.Dead)
function HandleDeath:OnEventDead(EventData)
  if EventData.IniGroupName == PlayersGroupName then
    BuildMenu()
  end
end