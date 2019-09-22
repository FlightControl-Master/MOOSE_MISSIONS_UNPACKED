--- Detect and attack a set of enemy units.
-- Name: AID-A2G-001 - Detection and Attack Helicopters
-- Author: FlightControl
-- Date Created: 02 Nov 2018

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
local DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "CCCP Recce" } )
DetectionSetGroup:FilterStart()

local Detection = DETECTION_AREAS:New( DetectionSetGroup, 5000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- The Command Center (HQ) is the defense point and will also handle the communication to the coalition.
local HQ_Group = GROUP:FindByName( "HQ" )
local HQ_CC = COMMANDCENTER:New( HQ_Group, "HQ" )

-- The HQ is the defense point, so this point will be defended.
A2GDispatcher:AddDefenseCoordinate( "HQ", HQ_Group:GetCoordinate() )
A2GDispatcher:SetDefenseReactivityHigh() -- High defense reactivity. So far proximity of a threat will trigger a defense action.
A2GDispatcher:SetDefenseRadius( 200000 ) -- Defense radius wide enough to also trigger defenses far away.

-- Communication to the players within the coalition. The HQ services the communication of the defense actions.
A2GDispatcher:SetCommandCenter( HQ_CC )

-- Show a tactical display.
A2GDispatcher:SetTacticalDisplay( true )


-- Setup the squadrons.

A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50" }, 10 )
A2GDispatcher:SetSquadronCas2( "Maykop CAS", 200, 250, 300, 500, "RADIO" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop CAS" )
A2GDispatcher:SetSquadronOverhead( "Maykop CAS", 0.25 )

A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP KA-50" }, 10 )
A2GDispatcher:SetSquadronBai2( "Maykop BAI", 200, 250, 300, 500, "RADIO" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop BAI" )
A2GDispatcher:SetSquadronOverhead( "Maykop BAI", 0.25 )

A2GDispatcher:SetSquadron( "Krasnodar", AIRBASE.Caucasus.Krasnodar_Pashkovsky, { "CCCP SU-25TM" }, 10 )
A2GDispatcher:SetSquadronSead2( "Krasnodar", 600, 800, 2000, 2000, "RADIO" )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Krasnodar" )
A2GDispatcher:SetSquadronOverhead( "Krasnodar", 0.2 )


-- We set for each squadron a takeoff interval, as each helicopter will launch from a FARP.
-- This to prevent helicopters to clutter.
-- Each helicopter group is taking off the FARP in hot start.
A2GDispatcher:SetSquadronTakeoffInterval( "Krasnodar", 10 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop CAS", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop BAI", 60 )
