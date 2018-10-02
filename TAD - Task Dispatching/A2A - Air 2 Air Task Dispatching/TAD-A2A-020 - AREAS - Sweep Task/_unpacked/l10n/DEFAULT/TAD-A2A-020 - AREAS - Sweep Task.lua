---
-- Name: TAD-A2A-020 - AREAS - Sweep Task
-- Author: FlightControl
-- Date Created: 17 May 2017
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for Air to Air operations.
-- Intruders are flying towards the EWR units. 
-- The detection method used is the DETECTION_AREAS method, which groups detected targets per detected area.
-- 
-- # Test cases: 
-- 
-- Observe the EWR's detecting targets and grouping them. 
-- Check that the HQ provides menus to engage on a task set by the EWRs.
-- Once the intruder is detected, an INTERCEPT task is created.
-- Observe that it goes back into the mountains.
-- And the task should return to a SWEEP task.
-- 
local HQ = GROUP:FindByName( "HQ", "Bravo" )

local CommandCenter = COMMANDCENTER:New( HQ, "Bravo" )

local Scoring = SCORING:New( "A2A Dispatching Demo" )

local Mission = MISSION
  :New( CommandCenter, "A2A Sweep Mission", "Primary", 
        "SWEEP Task Test. " ..
        "Observe the EWR's detecting targets and grouping them. " ..
        "Check that the HQ provides menus to engage on a task set by the EWRs. " ..
        "Once the intruder is detected, an INTERCEPT task is created. " ..
        "Observe that it goes back into the mountains. " ..
        "And the task should return to a SWEEP task.",
        coalition.side.RED )
  :AddScoring( Scoring )

local EWRSet = SET_GROUP:New():FilterPrefixes( "EWR" ):FilterCoalitions("red"):FilterStart()

local EWRDetection = DETECTION_AREAS:New( EWRSet, 6000 )
EWRDetection:SetFriendliesRange( 10000 )
EWRDetection:SetRefreshTimeInterval(30)


local AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Attack" ):FilterStart()

TaskDispatcher = TASK_A2A_DISPATCHER:New( Mission, AttackGroups, EWRDetection )
TaskDispatcher:SetRefreshTimeInterval( 10 )
