--- Test the default engage limit.
-- Defenses should engage enemy units, but not more defenses than the defense limit!
-- Name: AID-A2G-110 - Default DefenseLimit
-- Author: FlightControl
-- Date Created: 15 Nov 2018

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
Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityHigh()

A2GDispatcher:SetDefenseRadius( 100000 )

A2GDispatcher:SetTacticalDisplay( true )

local PatrolZone = ZONE:New( "PatrolZone" )

-- Setup the squadrons.
A2GDispatcher:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP SU-25T SEAD" }, 10 )
A2GDispatcher:SetSquadronSead( "Maykop SEAD", 250, 350 )
--A2GDispatcher:SetSquadronSeadPatrol( "Maykop SEAD", PatrolZone, 1000, 2500, 400, 600, 1100, 1500 )
--A2GDispatcher:SetSquadronSeadPatrolInterval( "Maykop SEAD", 4, 30, 60, 1 )
A2GDispatcher:SetSquadronTakeoffFromParkingCold( "Maykop SEAD" )
A2GDispatcher:SetSquadronOverhead( "Maykop SEAD", 0.25 )
