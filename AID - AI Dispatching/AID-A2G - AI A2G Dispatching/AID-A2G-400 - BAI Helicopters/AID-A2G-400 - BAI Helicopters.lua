--- Detect and attack a set of enemy units using helicopters.
-- Author: FlightControl
-- Date Created: 27 Jan 2019

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

A2GDispatcher:SetDefenseReactivityMedium()

A2GDispatcher:SetDefenseRadius( 100000 )

A2GDispatcher:SetTacticalDisplay( true )

-- Setup the squadrons.

A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50 BAI" }, 10 )
A2GDispatcher:SetSquadronBai( "Maykop BAI", 120, 250, 1000, 1500 )
A2GDispatcher:SetSquadronTakeoffFromParkingCold( "Maykop BAI" )
A2GDispatcher:SetSquadronOverhead( "Maykop BAI", 0.25 )

-- Wait for each helicopter to spawn about 4 minutes from cold start.
-- So the FARP has 4 spots, that means every 60 seconds one helo.
-- Otherwise the FARP will clutter.
-- This will result in helicopters not guided properly by the dispatcher.
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop BAI", 60 )
