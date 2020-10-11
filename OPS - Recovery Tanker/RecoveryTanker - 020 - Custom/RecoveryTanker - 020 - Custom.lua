---
-- RECOVERYTANKER: Custom
-- 
-- Simple Recovery tanker script using some customized settings.
-- 
-- Tanker will be spawned on the USS Stennis and go on station overhead at angels 6 with 274 knots TAS (~250 KIAS).
-- 
-- Radio frequencies, callsign are set below and overrule the settings of the late activated template group.
---

-- S-3B at USS Stennis spawning on deck.
local tankerStennis=RECOVERYTANKER:New("USS Stennis", "Texaco Group")

-- Custom settings for radio frequency, TACAN, callsign and modex.
tankerStennis:SetRadio(261)
tankerStennis:SetTACAN(37, "SHL")
tankerStennis:SetCallsign(CALLSIGN.Tanker.Arco, 3)
tankerStennis:SetModex(0)  -- "Triple nuts"

-- Start recovery tanker.
-- NOTE: If you spawn on deck, it seems prudent to delay the spawn a bit after the mission starts.
tankerStennis:__Start(1)
