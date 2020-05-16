--- Test the communication system to other players.
-- A command center will facilitate the A2G defenses communication to the players, who reporting to the same command center.
-- The task system needs to be used to have this reporting facilitated.
-- Name: AID-A2G-190 - Communication
-- Author: FlightControl
-- Date Created: 11 Jan 2019

-- Define a command center that will communicate with the players.
CC_Red = COMMANDCENTER:New( GROUP:FindByName( "HQ" ), "Command" )

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New() -- Defene a set of group objects, caled DetectionSetGroup.

DetectionSetGroup:FilterPrefixes( { "CCCP Recce" } ) -- The DetectionSetGroup will search for groups that start with the name "CCCP Recce".

-- This command will start the dynamic filtering, so when groups spawn in or are destroyed, 
-- which have a group name starting with "CCCP Recce", then these will be automatically added or removed from the set.
DetectionSetGroup:FilterStart() 

-- This command defines the reconnaissance network.
-- It will group any detected ground enemy targets within a radius of 1km.
-- It uses the DetectionSetGroup, which defines the set of reconnaissance groups to detect for enemy ground targets.
Detection_Red = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

-- Setup the A2A dispatcher, and initialize it.
AI_A2G_Dispatcher_Red = AI_A2G_DISPATCHER:New( Detection_Red )




-- Add defense coordinates.
AI_A2G_Dispatcher_Red:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

AI_A2G_Dispatcher_Red:SetDefenseReactivityHigh()

AI_A2G_Dispatcher_Red:SetDefenseRadius( 100000 )

-- This is the test, not more than 4 defenses in total should engage!
AI_A2G_Dispatcher_Red:SetDefaultEngageLimit( 6 )

AI_A2G_Dispatcher_Red:SetTacticalDisplay( true )

local PatrolZone = ZONE:New( "PatrolZone" )

-- Setup the squadrons.

-- SEAD
AI_A2G_Dispatcher_Red:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP AI SU-25T SEAD #001", "CCCP AI SU-25T SEAD #002", "CCCP AI SU-25T SEAD #003" }, 10 )
AI_A2G_Dispatcher_Red:SetSquadronSead( "Maykop SEAD", 600, 800 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffFromParkingHot( "Maykop SEAD" )
AI_A2G_Dispatcher_Red:SetSquadronOverhead( "Maykop SEAD", 0.2 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffInterval( "Maykop SEAD", 60 )

-- CAS
AI_A2G_Dispatcher_Red:SetSquadron( "Maykop CAS", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP AI SU-25T CAS" }, 10 )
AI_A2G_Dispatcher_Red:SetSquadronCas( "Maykop CAS", 600, 800 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffFromParkingHot( "Maykop CAS" )
AI_A2G_Dispatcher_Red:SetSquadronOverhead( "Maykop CAS", 0.25 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffInterval( "Maykop CAS", 60 )

-- BAI
AI_A2G_Dispatcher_Red:SetSquadron( "Maykop BAI", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP AI SU-25T BAI" }, 10 )
AI_A2G_Dispatcher_Red:SetSquadronBai( "Maykop BAI", 600, 800 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffFromParkingHot( "Maykop BAI" )
AI_A2G_Dispatcher_Red:SetSquadronOverhead( "Maykop BAI", 0.25 )
AI_A2G_Dispatcher_Red:SetSquadronTakeoffInterval( "Maykop BAI", 60 )




-- Now we setup the TASK A2G dispatcher, that will use the same detection system, as the AI A2G dispatcher!
Mission_Red = MISSION:New( CC_Red, "Comms Demo", "Example", "This mission demonstrates the communications between the AI A2G dispatcher and the TASK A2G dispatcher to the involved players.", coalition.side.RED )
Players_Red = SET_GROUP:New():FilterPrefixes( "CCCP Player" ):FilterStart()
Task_A2G_Dispatcher_Red = TASK_A2G_DISPATCHER:New( Mission_Red, Players_Red, Detection_Red )
Task_A2G_Dispatcher_Red:Start()

-- Here we set the command center, which will faciliate the communication to the Players_Red, using the same Detection_Red.
AI_A2G_Dispatcher_Red:SetCommandCenter( CC_Red )

