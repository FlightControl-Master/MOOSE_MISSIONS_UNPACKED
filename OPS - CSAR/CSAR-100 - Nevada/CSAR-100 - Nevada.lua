-------------------------------------------------------------------------
-- CSAR 100 - Nevasa - Test Mission
-------------------------------------------------------------------------
-- Documentation
-- 
-- MANTIS: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.CSAR.html
-- 
-- Note: As of today, Ops.CSAR.lua is WIP. You need a develop branch Moose.lua => 14 Jun 2021 for this to work.

-------------------------------------------------------------------------
-- Join a Helicopter. 30 seconds after mission start, foru pilots will be
-- spawned into the field. One is close enough to run to you and be picked
-- up. Since you're on a FARP, she'll be immediately rescued.
-------------------------------------------------------------------------
-- Date: 14 June 2021
-------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BULLS()
_SETTINGS:SetImperial()

my_scoring = SCORING:New("CSAR")

local BlueCsar = CSAR:New(coalition.side.BLUE,"Downed Pilot","Luftrettung")
BlueCsar.coordtype = 2
BlueCsar:__Start(5)

function BlueCsar:OnAfterRescued(From, Event, To, HeliUnit, HeliName, NumberSaved)
  -- add score to player
  local NumberSaved = NumberSaved or 1
  local points = 100 * NumberSaved
  local PlayerName = HeliUnit:GetPlayerName()
  my_scoring:_AddPlayerFromUnit( HeliUnit )
  my_scoring:AddGoalScore(HeliUnit, "CSAR", string.format("Pilot %s has been awarded %d points!", HeliName, points), points)
end

function Spawn_CSAR(BlueCSAR)
  BlueCSAR:SpawnCSARAtZone( "CSAR_Start_1", coalition.side.BLUE,"Pilot Maulwurf", true )
  BlueCSAR:SpawnCSARAtZone( "CSAR_Start_2", coalition.side.BLUE,"Pilot Schnake", true )
  BlueCSAR:SpawnCSARAtZone( "CSAR_Start_3", coalition.side.BLUE,"Pilot Chickendog", true )
  BlueCSAR:SpawnCSARAtZone( "CSAR_Start_4", coalition.side.BLUE,"Pilot Wagner", true )
end

local maulwuerfe = TIMER:New(Spawn_CSAR,BlueCsar)
maulwuerfe:Start(30)
