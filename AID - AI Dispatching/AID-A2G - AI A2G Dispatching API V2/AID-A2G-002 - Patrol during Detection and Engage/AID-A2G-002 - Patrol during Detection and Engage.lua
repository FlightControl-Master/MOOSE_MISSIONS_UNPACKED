--- Detect and attack a set of enemy units using helicopters.
-- Name: AID-A2G-001 - Detection and Attack Helicopters
-- Author: FlightControl
-- Date Created: 02 Nov 2018

-- Define a SET_GROUP object that builds a collection of groups that define the recce network.
-- Here we build the network with all the groups that have a name starting with CCCP Recce.
local DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "CCCP Recce" } )
DetectionSetGroup:FilterStart()

local Detection = DETECTION_AREAS:New( DetectionSetGroup, 1000 )

-- Setup the A2A dispatcher, and initialize it.
A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )

-- The Command Center (HQ) is the defense point and will also handle the communication to the coalition.
local HQ_Group = GROUP:FindByName( "HQ" )
local HQ_CC = COMMANDCENTER:New( HQ_Group, "HQ" )

-- Add defense coordinates.
A2GDispatcher:AddDefenseCoordinate( "HQ", HQ_Group:GetCoordinate() )
A2GDispatcher:SetDefenseReactivityHigh() -- High defense reactivity. So far proximity of a threat will trigger a defense action.
A2GDispatcher:SetDefenseRadius( 200000 ) -- Defense radius wide enough to also trigger defenses far away.

-- Communication to the players within the coalition. The HQ services the communication of the defense actions.
A2GDispatcher:SetCommandCenter( HQ_CC )

-- Show a tactical display.
A2GDispatcher:SetTacticalDisplay( true )


-- Setup the patrols.

-- The patrol zone.
local PatrolZone = ZONE:New( "PatrolZone" )


-- SEADing from Krasnodar.
A2GDispatcher:SetSquadron( "Krasnodar", AIRBASE.Caucasus.Krasnodar_Pashkovsky, { "CCCP SU-25TM" }, 10 )
A2GDispatcher:SetSquadronSeadPatrol2( "Krasnodar", PatrolZone, 500, 550, 2000, 2000, "BARO", 750, 800, 30, 30, "RADIO" ) -- New API
A2GDispatcher:SetSquadronSeadPatrolInterval( "Krasnodar", 2, 30, 60, 1 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Krasnodar" )
A2GDispatcher:SetSquadronOverhead( "Krasnodar", 0.2 )


-- Close Air Support from the CAS farp.
A2GDispatcher:SetSquadron( "Maykop CAS", "CAS", { "CCCP KA-50" }, 10 )
A2GDispatcher:SetSquadronCasPatrol2( "Maykop CAS", PatrolZone, 50, 80, 600, 700, "BARO", 200, 230, 30, 30, "RADIO" ) -- New API
A2GDispatcher:SetSquadronCasPatrolInterval( "Maykop CAS", 2, 30, 60, 1 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop CAS" )
A2GDispatcher:SetSquadronOverhead( "Maykop CAS", 0.25 )

-- Battlefield Air Interdiction from the BAI farp.
A2GDispatcher:SetSquadron( "Maykop BAI", "BAI", { "CCCP MIL-8MTV" }, 10 )
A2GDispatcher:SetSquadronBaiPatrol2( "Maykop BAI", PatrolZone, 50, 80, 600, 700, "BARO", 200, 230, 800, 900, "RADIO" ) -- New API
A2GDispatcher:SetSquadronBaiPatrolInterval( "Maykop BAI", 5, 30, 60, 1 )
A2GDispatcher:SetSquadronTakeoffFromParkingHot( "Maykop BAI" )
A2GDispatcher:SetSquadronOverhead( "Maykop BAI", 0.75 )

-- We set for each squadron a takeoff interval, as each helicopter will launch from a FARP.
-- This to prevent helicopters to clutter.
-- Each helicopter group is taking off the FARP in hot start.
A2GDispatcher:SetSquadronTakeoffInterval( "Krasnodar", 10 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop CAS", 60 )
A2GDispatcher:SetSquadronTakeoffInterval( "Maykop BAI", 60 )
