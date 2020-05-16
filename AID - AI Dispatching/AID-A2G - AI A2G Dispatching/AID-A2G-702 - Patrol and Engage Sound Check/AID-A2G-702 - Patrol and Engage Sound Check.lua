--- Sound check using patrol and engage for helicopters.
-- Author: FlightControl
-- Date Created: 14 Sep 2019

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "US Recce" } )
DetectionSetGroup:FilterStart()

CCGroup = GROUP:FindByName( "HQ" )
CC = COMMANDCENTER:New( CCGroup, "HQ" )

Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

A2GDispatcher:SetCommandCenter( CC )
A2GDispatcher:SetTacticalMenu( "Dispatchers", "A2G Tactical Situation" )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityHigh()

A2GDispatcher:SetDefenseRadius( 100000 )

A2GDispatcher:SetTacticalDisplay( false )

local PatrolZone = ZONE:New( "PatrolZone" )

-- Setup the squadrons.
A2GDispatcher:SetSquadron( "Maykop SEAD", "SEAD", { "US KA-50" }, 10 )
A2GDispatcher:SetSquadronSeadPatrol( "Maykop SEAD", PatrolZone, 300, 500, 50, 80, 250, 300 )
A2GDispatcher:SetSquadronPatrolInterval( "Maykop SEAD", 2, 30, 60, 1, "SEAD" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop SEAD" )
A2GDispatcher:SetSquadronOverhead( "Maykop SEAD", 0.25 )
A2GDispatcher:SetSquadronRadioFrequency( "Maykop SEAD", 124 ) 

A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "US KA-50" }, 10 )
A2GDispatcher:SetSquadronCasPatrol( "Maykop CAS", PatrolZone, 600, 700, 50, 80, 250, 300 )
A2GDispatcher:SetSquadronPatrolInterval( "Maykop CAS", 2, 30, 60, 1, "CAS" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop CAS" )
A2GDispatcher:SetSquadronOverhead( "Maykop CAS", 0.25 )
A2GDispatcher:SetSquadronRadioFrequency( "Maykop CAS", 126 ) 

A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "US KA-50" }, 10 )
A2GDispatcher:SetSquadronBaiPatrol( "Maykop BAI", PatrolZone, 800, 900, 50, 80, 250, 300 )
A2GDispatcher:SetSquadronPatrolInterval( "Maykop BAI", 2, 30, 60, 1, "BAI" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop BAI" )
A2GDispatcher:SetSquadronOverhead( "Maykop BAI", 0.25 )
A2GDispatcher:SetSquadronRadioFrequency( "Maykop BAI", 128 ) 

-- We set for each squadron a takeoff interval, as each helicopter will launch from a FARP.
-- This to prevent helicopters to clutter.
-- Each helicopter group is taking off the FARP in hot start.
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop SEAD", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop CAS", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop BAI", 60 )