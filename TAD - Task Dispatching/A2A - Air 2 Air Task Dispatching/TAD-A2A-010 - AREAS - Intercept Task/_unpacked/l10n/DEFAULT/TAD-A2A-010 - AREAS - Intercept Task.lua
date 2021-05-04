---
-- Name: TAD-A2A-010 - AREAS - Intercept Task
-- Author: FlightControl
-- Date Created: 13 Mar 2017
--
-- This mission demonstrates the dynamic task dispatching for Air to Air operations.
-- Intruders are flying towards the EWR units. 
-- The detection method used is the DETECTION_AREAS method, which groups detected targets per detected area.
-- 
-- Observe the planes flying towards the EWR.
-- Upon detection, an INTERCEPT task should be created.
-- Join the task and destroy the intruders.
-- Check if the task is successful after destroying the target.
-- 
-- 
local HQ = GROUP:FindByName( "HQ", "Bravo" )

local CommandCenter = COMMANDCENTER:New( HQ, "Bravo" )

local Scoring = SCORING:New( "A2A Dispatching Demo" )

local Mission = MISSION
  :New( CommandCenter, "A2A Intercept Mission", "Primary", "INTERCEPT Task Test. Observe the planes flying towards the EWR. Upon detection, an INTERCEPT task should be created. Join the task and destroy the intruders.Check if the task is successful after destroying the target.", coalition.side.RED )
  :AddScoring( Scoring )

local EWRSet = SET_GROUP:New():FilterPrefixes( "EWR" ):FilterCoalitions("red"):FilterStart()

local EWRDetection = DETECTION_AREAS:New( EWRSet, 6000 )
EWRDetection:SetFriendliesRange( 10000 )
EWRDetection:SetRefreshTimeInterval( 10 )


local AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Attack" ):FilterStart()

TaskDispatcher = TASK_A2A_DISPATCHER:New( Mission, AttackGroups, EWRDetection )
TaskDispatcher:SetRefreshTimeInterval( 10 )
