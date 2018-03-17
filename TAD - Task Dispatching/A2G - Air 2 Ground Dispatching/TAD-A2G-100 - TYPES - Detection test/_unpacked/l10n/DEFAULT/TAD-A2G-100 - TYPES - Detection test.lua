 ---
-- Name: TAD-A2G-100 - TYPES - Detection Test
-- Author: FlightControl
-- Date Created: 15 Mar 2018
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for Air to Ground operations.
-- Reconnassance vehicles are placed at strategic locations, scanning for the enemy locations.
-- The detection method used is the DETECTION_TYPES method, which groups detected targets into Unit Types that were detected.
-- The AttackSet will engage upon the enemy, which is a Set of Groups seated by Players.
-- A2G Tasks are being dispatched to the Players as enemy locations are being detected by the Recce.
-- Observe that A2G Tasks are being dispatched to the player.


-- Declare the Command Center 
local HQ = GROUP
  :FindByName( "HQ", "Bravo HQ" )

local CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" ) -- Create the CommandCenter.
  
-- Declare the Mission for the Command Center.
local Mission = MISSION
  :New( CommandCenter, "Overlord", "High", "Attack Detect Mission Briefing", coalition.side.RED ) -- Create the Mission.

-- Define the RecceSet that will detect the enemy.
local RecceSet = SET_GROUP
  :New()  -- Create the RecceSet, which is the set of groups detecting the enemy locations.
  :FilterPrefixes( "Recce" ) -- All Recce groups start with the name "Recce".
  :FilterCoalitions("red") -- only the red coalition.
  :FilterStart() -- Start the dynamic building of the set.

-- Setup the detection. We use DETECTION_AREAS to detect and group the enemies.
local DetectionAreas = DETECTION_TYPES
  :New( RecceSet )  -- The RecceSet will detect the enemies, and group them into unit types that were detected.

-- Setup the AttackSet, which is a SET_GROUP.
-- The SET_GROUP is a dynamic collection of GROUP objects.  
local AttackSet = SET_GROUP
  :New()  -- Create the SET_GROUP object.
  :FilterCoalitions( "red" ) -- Only incorporate the RED coalitions.
  :FilterPrefixes( "Attack" ) -- Only incorporate groups that start with the name Attack.
  :FilterStart() -- Start the dynamic building of the set.
  
-- Now we have everything to setup the main A2G TaskDispatcher.
TaskDispatcher = TASK_A2G_DISPATCHER
  :New( Mission, AttackSet, DetectionAreas ) -- We assign the TaskDispatcher under Mission. The AttackSet will engage the enemy and will recieve the dispatched Tasks. The DetectionAreas will report any detected enemies to the TaskDispatcher.

-- We use the MISSILETRAINER for demonstration purposes.
MissileTrainer = MISSILETRAINER:New( 100, "Missiles will be destroyed for training when they reach your plane." )
