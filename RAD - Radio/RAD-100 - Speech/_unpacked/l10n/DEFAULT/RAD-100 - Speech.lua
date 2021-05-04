-- This test mission demonstrates the BEACON class.
-- The goal is to activate 2 types of beacons : 1 TACAN beacon attach to an aircraft, and 1 generic radio beacon attach to a ground UNIT

-- The player aircraft needs to be ASM and TACAN compatible. Please replace the M2000C by an aircraft you own and can receive TACAN signals

-- Activates the trace to see what BEACON does in the log
--BASE:TraceClass("BEACON")
BASE:TraceLevel(3)

-- Create our UNITs on which we'll attach a BEACON
local Aircraft = UNIT:FindByName("Unit1")
local LandUnit = UNIT:FindByName("Unit2")

RadioSpeech = RADIOSPEECH:New( 124 )
RadioSpeech:SetSenderUnitName( "Unit2" )

RadioSpeech:Start(2)

RadioSpeech:ScheduleRepeat( 5, 30, 0, nil, RadioSpeech.Speak, "springfield11, patrolling" )