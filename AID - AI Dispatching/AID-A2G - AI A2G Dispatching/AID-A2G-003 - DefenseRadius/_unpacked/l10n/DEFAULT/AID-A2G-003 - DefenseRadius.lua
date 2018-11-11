--- Test the defense radius.
-- Defenses should pickup targets within the defense radius, but not outside of it!
-- Defenses should engage targets closer to the HQ with higher probability than targets at longer distance from the HQ.
-- The tests are with SEAD only.
-- Name: AID-A2G-003 - DefenseRadius
-- Author: FlightControl
-- Date Created: 11 Nov 2018

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "CCCP Recce" } )
DetectionSetGroup:FilterStart()

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
A2GDispatcher:SetSquadronSeadPatrol( "Maykop SEAD", PatrolZone, 1000, 2500, 400, 600, 1100, 1500 )
A2GDispatcher:SetSquadronSeadPatrolInterval( "Maykop SEAD", 4, 30, 60, 1 )
A2GDispatcher:SetSquadronTakeoffInAir( "Maykop SEAD" )
A2GDispatcher:SetSquadronOverhead( "Maykop SEAD", 0.25 )
