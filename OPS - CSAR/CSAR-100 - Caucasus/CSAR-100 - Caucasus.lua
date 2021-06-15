-------------------------------------------------------------------------
-- CSAR 100 - Caucasus - Test Mission
-------------------------------------------------------------------------
-- Documentation
-- 
-- MANTIS: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.CSAR.html
-- 
-- Note: As of today, Ops.CSAR.lua is WIP. You need a develop branch Moose.lua => 14 Jun 2021 for this to work.

-------------------------------------------------------------------------
-- Join a Helicopter. 30 seconds after mission start, four pilots will be
-- spawned into the field. One is close enough to run to you and be picked
-- up. Since you're on a FARP, she'll be immediately rescued.
-------------------------------------------------------------------------
-- Date: 15 June 2021
-------------------------------------------------------------------------

_SETTINGS:SetPlayerMenuOff()
_SETTINGS:SetA2G_BR()
_SETTINGS:SetA2A_BULLS()
_SETTINGS:SetImperial()

my_scoring = SCORING:New("CSAR")

local RedCsar = CSAR:New("red","Downed Pilot","Blue Cross")
RedCsar.coordtype = 4
RedCsar.verbose = 2
RedCsar:__Start(5)

function RedCsar:OnAfterRescued(From, Event, To, HeliUnit, HeliName, NumberSaved)
  -- add score to player
  local NumberSaved = NumberSaved or 1
  local points = 100 * NumberSaved
  local PlayerName = HeliUnit:GetPlayerName()
  my_scoring:_AddPlayerFromUnit( HeliUnit )
  my_scoring:AddGoalScore(HeliUnit, "Red CSAR", string.format("Pilot %s has been awarded %d points!", HeliName, points), points)
end

function Spawn_CSAR(RedCSAR)
  RedCSAR:_SpawnCsarAtZone( "CSAR_Start_1", coalition.side.RED,"Pilot Maulwurf", true )
  RedCSAR:_SpawnCsarAtZone( "CSAR_Start_2", coalition.side.RED,"Pilot Schnake", true )
  RedCSAR:_SpawnCsarAtZone( "CSAR_Start_3", coalition.side.RED,"Pilot Chickendog", true )
  RedCSAR:_SpawnCsarAtZone( "CSAR_Start_4", coalition.side.RED,"Pilot Wagner", true )
end

local maulwuerfe = TIMER:New(Spawn_CSAR,RedCsar)
maulwuerfe:Start(30)
