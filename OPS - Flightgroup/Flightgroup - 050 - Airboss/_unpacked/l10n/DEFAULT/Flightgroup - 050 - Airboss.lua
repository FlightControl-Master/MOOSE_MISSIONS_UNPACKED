---
-- FLIGHTGROUP: Airboss
-- 
-- A Hornet 4-ship group takes of from Batumi with destination USS Stennis.
-- It will be put into the Marshal stack until the recovery window opens at 8:20.
-- 
-- NOTE that in the DEVELOPMENT version, the AIRBOSS handles FLIGHTGROUPS which are inbound to the carrier.
-- The AIRBOSS function :SetExcludeAI() is deprecated.
-- 
---

-- Create a very basic AIRBOSS. We open a recovery window at 8:30 for 30 min.
local airboss=AIRBOSS:New("USS Stennis")
airboss:AddRecoveryWindow("8:20", 30*60)
airboss:Start()

-- Create a FLIGHTGROUP object.
local flightgroup=FLIGHTGROUP:New("F/A-18 Batumi")
flightgroup:Activate()

-- Set destination to USS Stennis.
flightgroup:SetDestinationbase(AIRBASE:FindByName("USS Stennis"))
