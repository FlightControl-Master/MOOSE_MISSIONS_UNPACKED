-------------------------------------------------------------------------
-- BOS-110 - Airboss launch tanker from ramp
-------------------------------------------------------------------------
-- Documentation
-- 
-- AIRBOSS: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.Airboss.html
-- 
-------------------------------------------------------------------------
-- Simple Recovery tanker script demonstrating the use of the RECOVERYTANKER.uncontrolledac method.
-- or RECOVERYTANKER:SetUseUncontrolledAircraft(). Both are shown below.
-- You will require an AI skill S-3B tanker group placed in the mission editor,
-- Set to "Takeoff from Ramp" and ensure "Uncontrolled" is ticked.
-- Ensure "Late activation" is not ticked.
--
-- 2 S-3B Tankers will be spawned on the USS Stennis as a visible objects (not late activation) but without crew.
-- After 30 seconds, the first S-3B will spawn crew, start up go on station overhead at angels 6 with 274 knots TAS (~250 KIAS).
-- After 1 minute, the second S-3B will spawn crew, start up and go on station overhead at angels 12 with 300 knots TAS (~249 KIAS)
-- Radio frequencies, callsign, Alt and Speed are set below and overrule the settings of the AI group.
-------------------------------------------------------------------------
-- Date: 29 Dec 2020
-- Author: Azza276
-------------------------------------------------------------------------

-- S-3B at USS Stennis spawning on deck, Start with Delay in Moose.
local tankerStennis=RECOVERYTANKER:New("USS Stennis", "Texaco Group")

-- Custom settings for radio frequency, TACAN and callsign.
tankerStennis:SetRadio(261)
tankerStennis:SetTACAN(37, "SHL")
tankerStennis:SetCallsign(CALLSIGN.Tanker.Shell, 3)

--RECOVERYTANKER.uncontrolledac if true, use an uncontrolled tanker group already present in the mission.
tankerStennis.uncontrolledac = true

-- Start recovery tanker.
-- NOTE: Delay to show Aircraft visible on deck then starts later (30 seconds after mission start).
tankerStennis:__Start(30)

-------------------------------------------------------------------------------------------------

-- S-3B at USS Stennis spawning on deck, Start with Delay in Mission Editor Trigger. Variable is a global.
tankerStennis2=RECOVERYTANKER:New( "USS Stennis", "Texaco Group-1")
tankerStennis2:SetRadio(271)
tankerStennis2:SetTACAN(38, "SHE")
tankerStennis2:SetCallsign(3, 2) --First parameter is Callsign name (1=Texaco, 2=Arco, 3=Shell)
tankerStennis2:SetAltitude(12000) --Sets Orbit Altitude
tankerStennis2:SetSpeed(300) --Sets speed to 300 knots TAS (~249 KIAS at 12000ft)

--RECOVERYTANKER:SetUseUncontrolledAircraft() to use an uncontrolled tanker group already present in the mission.
tankerStennis2:SetUseUncontrolledAircraft()

--- tankerStennis2:Start()
-- The above without "--" is loaded to the Mission editor trigger "Do Script" action after 60 seconds condition.
-- NOTE: Delay to show Aircraft visible on deck then starts later (60 seconds after mission start)..