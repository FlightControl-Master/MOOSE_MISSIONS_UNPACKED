--- Detect and attack a set of enemy units using helicopters.
-- 
-- Author: FlightControl
-- Date Created: 23 Jan 2018

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "Recce" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

Detection:SetFriendliesRange( 20000 )
-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityMedium()

A2GDispatcher:SetDefenseRadius( 250000 )


A2GDispatcher:SetTacticalDisplay( true )

-- Setup the squadrons.

local CASPatrolZone = ZONE:New( "CASPatrolZone" )

-- Setup the squadron Sq25.
A2GDispatcher:SetSquadron( "Sq26", AIRBASE.Caucasus.Nalchik, { "Defender" }, 10 )

-- This will setup the squadron Sq34 for CAS from Beslan.
-- No additional altitude and speed parameters are given, so the defaults are assigned.
-- Default speed between 50% and 75% of the maximum speed of the units in the group.
-- Default altitude is between 1000 and 1500 meters.
A2GDispatcher:SetSquadronCas( "Sq26" )

-- Start from airbase hot.
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Sq26" )

-- For every 2 targets, there will be one plane spawned.
A2GDispatcher:SetSquadronOverhead( "Sq26", 0.20 )
