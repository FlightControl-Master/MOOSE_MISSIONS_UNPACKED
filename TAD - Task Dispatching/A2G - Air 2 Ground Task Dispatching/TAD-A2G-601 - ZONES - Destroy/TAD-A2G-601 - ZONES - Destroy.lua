 ---
-- Name: TAD-A2G-001 - AREAS - Destroy Test
-- Author: FlightControl
-- Date Created: 15 Mar 2018
--
-- This mission demonstrates the dynamic task dispatching for Air to Ground operations.
-- Reconnassance vehicles are placed at strategic locations, scanning for the enemy locations.
-- The detection method used is the DETECTION_AREAS method, which groups detected targets into areas.
-- The AttackSet will engage upon the enemy, which is a Set of Groups seated by Players.
-- A2G Tasks are being dispatched to the Players as enemy locations are being detected by the Recce.
-- Observe that A2G Tasks are being dispatched to the player.
-- Get seated in the Attack Plane, there is also an AI with you, who will attack the ground targets.
-- Join the A2G Task that was dispatched to you.
-- Once the AI in your group destroys the target, you should see that the A2G task got success.


-- Declare the Command Center 
local HQ = GROUP
  :FindByName( "HQ", "Bravo HQ" )

local CommandCenter = COMMANDCENTER
  :New( HQ, "Lima" ) -- Create the CommandCenter.
  
-- Declare the Mission for the Command Center.
local Mission = MISSION
  :New( CommandCenter, "Overlord", "High", "Attack Detect Mission Briefing", coalition.side.RED ) -- Create the Mission.


-- Setup the detection. We use DETECTION_AREAS to detect and group the enemies.
local DetectionSetZones = SET_ZONE:New():FilterPrefixes( { "Detection Zone Blue" } ):FilterOnce()

local DetectionZones = DETECTION_ZONES:New( DetectionSetZones, coalition.side.BLUE )

-- Setup the AttackSet, which is a SET_GROUP.
-- The SET_GROUP is a dynamic collection of GROUP objects.  
local AttackSet = SET_GROUP
  :New()  -- Create the SET_GROUP object.
  :FilterCoalitions( "red" ) -- Only incorporate the RED coalitions.
  :FilterPrefixes( "Attack" ) -- Only incorporate groups that start with the name Attack.
  :FilterStart() -- Start the dynamic building of the set.
  
-- Now we have everything to setup the main A2G TaskDispatcher.
TaskDispatcher = TASK_A2G_DISPATCHER
  :New( Mission, AttackSet, DetectionZones ) -- We assign the TaskDispatcher under Mission. The AttackSet will engage the enemy and will recieve the dispatched Tasks. The DetectionAreas will report any detected enemies to the TaskDispatcher.

-- We use the MISSILETRAINER for demonstration purposes.
MissileTrainer = MISSILETRAINER:New( 100, "Missiles will be destroyed for training when they reach your plane." )
