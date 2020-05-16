-------------------------
-- AIRBOSS Test Script --
-------------------------

-- Set mission menu.
AIRBOSS.MenuF10Root=MENU_MISSION:New("Airboss").MenuPath

-- No MOOSE settings menu.
_SETTINGS:SetPlayerMenuOff()

-- S-3B Recovery Tanker spawning in air.
local tanker=RECOVERYTANKER:New("CVN-74", "- Texaco Tanker")
tanker:SetTakeoffAir()
tanker:SetRadio(256)
tanker:SetModex(511)
tanker:SetTACAN(1, "TKR")
tanker:Start()

-- E-2D AWACS spawning in air
local awacs=RECOVERYTANKER:New("CVN-74", "AWACS")
awacs:SetAWACS()
awacs:SetTakeoffAir()
awacs:SetRadio(264)
awacs:SetAltitude(20000)
awacs:SetCallsign(CALLSIGN.AWACS.Overloard)
awacs:SetRacetrackDistances(20, 8)
awacs:SetModex(611)
awacs:SetTACAN(2, "OLV")
awacs:Start()

-- Rescue Helo spawned in air with home base USS Perry. Has to be a global object!
rescuehelo=RESCUEHELO:New("CVN-74", "CV Helo")
rescuehelo:SetHomeBase(AIRBASE:FindByName("CG-67"))
rescuehelo:SetTakeoffAir()
rescuehelo:SetModex(42)
rescuehelo:Start()
  
-- Create AIRBOSS object.
local AirbossStennis=AIRBOSS:New("CVN-74")

-- Add recovery windows:
local window1=AirbossStennis:AddRecoveryWindow("18:30", "21:00", 1, nil, true, 20)

-- Radio freqs.
AirbossStennis:SetMarshalRadio(305)
AirbossStennis:SetLSORadio(265)

-- Radio relay units.
AirbossStennis:SetRadioRelayLSO(rescuehelo:GetUnitName())
AirbossStennis:SetRadioRelayMarshal(tanker:GetUnitName())

-- Set folder of airboss sound files within miz file.
AirbossStennis:SetSoundfilesFolder("Airboss Soundfiles/")

-- Single carrier menu optimization.
AirbossStennis:SetMenuSingleCarrier()

-- Enable skipper menu.
AirbossStennis:SetMenuRecovery(15, 30, true)
 
-- AI groups explicitly excluded from handling by the Airboss
AirbossStennis:SetHandleAIOFF()
 
-- Remove landed AI planes from flight deck.
AirbossStennis:SetDespawnOnEngineShutdown()

-- Load all saved player grades from your "Saved Games\DCS" folder (if lfs was desanitized).
AirbossStennis:Load()

-- Automatically save player results to your "Saved Games\DCS" folder each time a player get a final grade from the LSO.
AirbossStennis:SetAutoSave()

-- Enable trap sheet.
AirbossStennis:SetTrapSheet()

-- Set recovery tanker
AirbossStennis:SetRecoveryTanker(tanker)

-- Set AWACS.
AirbossStennis:SetAWACS(awacs)

-- Start airboss class.
AirbossStennis:Start()
