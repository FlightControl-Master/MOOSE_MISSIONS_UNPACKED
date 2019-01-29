--- Detect and attack a set of enemy units using helicopters.
-- 
-- Author: FlightControl
-- Date Created: 23 Jan 2018

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "Recce" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 20000 )

Detection:SetFriendliesRange( 20000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityHigh()

A2GDispatcher:SetDefenseRadius( 200000 )
A2GDispatcher:SetEngageRadius( 200000 )


A2GDispatcher:SetTacticalDisplay( true )

-- Setup the squadrons.

-- Setup the squadron Sq34.
A2GDispatcher:SetSquadron( "Sq34", AIRBASE.Caucasus.Vaziani, { "Defender Sq34" }, 10 )

-- This will setup the squadron Sq34 for SEAD from Vaziani.
-- Attack speed between 1000 and 1500 km/h.
-- Attack altitude between 4000 and 6000 meters.
A2GDispatcher:SetSquadronSead( "Sq34", 600, 800, 4500, 6000 )


-- Start from airbase hot.
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Sq34" )

-- For every 2 targets, there will be one plane spawned, so we give a 0.5 value.
A2GDispatcher:SetSquadronOverhead( "Sq34", 0.5 )


-- Setup the squadron Sq25.
A2GDispatcher:SetSquadron( "Sq25", AIRBASE.Caucasus.Soganlug, { "Defender Sq25" }, 10 )

-- This will setup the squadron Sq34 for CAS from Vaziani.
-- No additional altitude and speed parameters are given, so the defaults are assigned.
-- Default speed between 50% and 75% of the maximum speed of the units in the group.
-- Default altitude is between 1000 and 1500 meters.
A2GDispatcher:SetSquadronCas( "Sq25" )


-- Start from airbase hot.
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Sq25" )

-- For every 2 targets, there will be one plane spawned, so we give a 0.5 value.
A2GDispatcher:SetSquadronOverhead( "Sq25", 0.25 )
