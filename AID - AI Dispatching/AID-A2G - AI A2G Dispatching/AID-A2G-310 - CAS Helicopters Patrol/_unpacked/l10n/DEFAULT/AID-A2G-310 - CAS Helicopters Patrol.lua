--- Detect and attack a set of enemy units using helicopters.
-- Name: AID-A2G-001 - Detection and Attack Helicopters
-- Author: FlightControl
-- Date Created: 02 Nov 2018

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
A2GDispatcher:SetSquadron( "Sq34", "FARP CAS", { "Defender" }, 10 )
A2GDispatcher:SetSquadronCasPatrol( "Sq34", CASPatrolZone, 200, 500, 70, 100, 250, 300 )
A2GDispatcher:SetSquadronCasPatrolInterval( "Sq34", 2, 30, 60 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Sq34" )
A2GDispatcher:SetSquadronOverhead( "Sq34", 0.25 )
