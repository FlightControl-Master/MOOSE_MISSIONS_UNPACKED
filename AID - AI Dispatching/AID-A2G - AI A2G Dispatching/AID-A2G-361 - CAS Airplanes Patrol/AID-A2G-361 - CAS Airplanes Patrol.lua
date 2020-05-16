-- Date Created: 09 Mar 2019

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "Recce" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityMedium()

A2GDispatcher:SetDefenseRadius( 100000 )

A2GDispatcher:SetTacticalDisplay( true )

-- Setup the squadrons.

local CASPatrolZone = ZONE:New( "CASPatrolZone" )

-- Setup the squadron Sq34.
A2GDispatcher:SetSquadron( "Sq34", AIRBASE.Caucasus.Vaziani, { "Defender" }, 10 )

-- This will setup the squadron Sq34 for patrol and CAS from Vaziani.
A2GDispatcher:SetSquadronCasPatrol( "Sq34", CASPatrolZone, 1500, 2500, 600, 800, 800, 1200 )

-- Maximum 6 units for patrol, with a spawn interval between 30 and 60 seconds.
--A2GDispatcher:SetSquadronCasPatrolInterval( "Sq34", 2, 30, 60 )

-- Start from airbase hot.
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Sq34" )

-- For every 4 targets, there will be one plane spawned.
A2GDispatcher:SetSquadronOverhead( "Sq34", 0.25 )
