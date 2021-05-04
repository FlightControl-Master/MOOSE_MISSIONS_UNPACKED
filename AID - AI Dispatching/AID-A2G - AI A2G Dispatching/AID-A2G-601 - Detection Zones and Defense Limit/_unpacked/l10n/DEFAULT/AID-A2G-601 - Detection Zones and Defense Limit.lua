--- Detect and attack a set of enemy units using helicopters.
-- Name: AID-A2G-001 - Detection and Attack Helicopters
-- Author: FlightControl
-- Date Created: 02 Nov 2018



local DetectionZones = SET_ZONE:New():FilterPrefixes( { "Detection Zone " } ):FilterOnce()

Detection = DETECTION_ZONES:New( DetectionZones, coalition.side.BLUE )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", GROUP:FindByName( "HQ" ):GetCoordinate() )

A2GDispatcher:SetDefenseReactivityHigh()

A2GDispatcher:SetDefenseRadius( 200000 )

A2GDispatcher:SetDefenseLimit( 1 )

A2GDispatcher:SetTacticalDisplay( true )

-- Setup the squadrons.

A2GDispatcher:SetSquadron( "Maykop SEAD", AIRBASE.Caucasus.Maykop_Khanskaya, { "CCCP SU-25T" }, 10 )
A2GDispatcher:SetSquadronSead( "Maykop SEAD", 120, 250 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop SEAD" )
A2GDispatcher:SetSquadronOverhead( "Maykop SEAD", 0.2 )

A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50" }, 10 )
A2GDispatcher:SetSquadronCas( "Maykop CAS", 120, 250 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop CAS" )
A2GDispatcher:SetSquadronOverhead( "Maykop CAS", 0.25 )

A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50" }, 10 )
A2GDispatcher:SetSquadronBai( "Maykop BAI", 120, 250 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop BAI" )
A2GDispatcher:SetSquadronOverhead( "Maykop BAI", 0.25 )

-- We set for each squadron a takeoff interval, as each helicopter will launch from a FARP.
-- This to prevent helicopters to clutter.
-- Each helicopter group is taking off the FARP in hot start.
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop SEAD", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop CAS", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop BAI", 60 )
