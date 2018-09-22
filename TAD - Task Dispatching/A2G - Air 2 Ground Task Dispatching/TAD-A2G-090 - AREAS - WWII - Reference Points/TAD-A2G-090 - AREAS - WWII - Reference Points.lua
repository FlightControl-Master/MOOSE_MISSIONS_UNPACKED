-- Name: TAD-A2G-090 - AREAS - WWII - Reference Points
-- Author: FlightControl
-- Date Created: 17 Mar 2017
--
-- Test if the Command Center is working in WWII mode, and that it selects the closest Reference points for each target...
-- Join both tasks sequentially (abort when done), and see if the reference points are selected correctly, following the closest ref point logic.
-- 
-- 1. Join the Attack group of RED.
-- 2. Wait until the blue tank is detected.
-- 3. Three tasks will de defined, CAS and BAI tasks.
-- 4. Join each task using the radio menus.
-- 5. Observe that the correct WWII compatible reference points are shown.

local HQ = GROUP:FindByName( "HQ", "Bravo HQ" )

local CommandCenter = COMMANDCENTER:New( HQ, "Bravo" )
CommandCenter:SetModeWWII()
CommandCenter:SetReferenceZones( "Village" )

local Mission = MISSION
  :New( CommandCenter, 
        "Overlord", 
        "Primary", 
        "Join each task as a result of the detected targets reported. " .. 
        "Observe that the correct Targets are reported from the correct reference points! " ..
        "\n1. Target #001 -> Village#Dziguri" ..
        "\n2. Target #002 -> Village#Horshi" ..
        "\n3. Target #003 -> Village#Machkhvareti"
        , coalition.side.RED )

local RecceSet = SET_GROUP:New():FilterPrefixes( "Recce" ):FilterCoalitions( "red" ):FilterStart()
local DetectionAreas = DETECTION_AREAS:New( RecceSet, 500 )
local AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Attack" ):FilterStart()
TaskDispatcher = TASK_A2G_DISPATCHER:New( Mission, AttackGroups, DetectionAreas )
