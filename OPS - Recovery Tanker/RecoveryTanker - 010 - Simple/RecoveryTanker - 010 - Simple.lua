---
-- RECOVERYTANKER: Simple
-- 
-- Simple Recovery tanker script using default settings.
-- 
-- Tanker will be spawned on the USS Stennis and go on station overhead at angels 6 with 274 knots TAS (~250 KIAS).
-- 
-- Radio frequencies, callsign are taken from the settings of the late activated template group in the mission editor.
---

-- S-3B at USS Stennis spawning on deck. First Parameter is the UNIT name of the Carrier, second the GROUP name of the tanker template.
local tankerStennis=RECOVERYTANKER:New("USS Stennis", "Texaco Group")

-- Start recovery tanker.
-- NOTE: If you spawn on deck, it seems prudent to delay the spawn a bit after the mission starts.
tankerStennis:__Start(1)
