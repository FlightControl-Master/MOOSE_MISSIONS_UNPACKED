--- Mission crated by Marginal
--- Wiht Moase API, Aufraag CLASS
--- Preparped for github by Wingthor
--- 2020-12-15


-----------------------------------------------
--MOOSE SETTINGS, MARKERS and CLEANUP AIRBASE--
-----------------------------------------------

-- If you require a MOOSE settings menu, comment out the line below
--_SETTINGS:SetPlayerMenuOff()

-- If you do not want markers on the F10 Map, comment out the line below
AUFTRAG:SetEnableMarkers()  

    -- Cleanup a airbase runway after AI crashes or stops on the runway and wont taxi clear
    -- Lookup airbase name in moose.lua
    --CleanUpAirports = CLEANUP_AIRBASE:New( AIRBASE.Caucasus.Kutaisi )
    
    --Tracing
    --BASE:TraceOnOff( true )
    --BASE:TracelLevel( 3 )
    --BASE:TraceAll( true )
    

----------------
--SEAD Evasion--
----------------

-- Defends the Russian SA installations from SEAD attacks.
-- Add SAM groups to the list

SEAD_RU_SAM_Defenses = SEAD:New( {'SAM-SA-10' , 'SAM-SA-15A', 'EWR A' } )

------------------------------------------
--BOMBING - GROUP, UNIT or STATIC object--
------------------------------------------

--In ME:
--create a/c group(s)
--no waypoints reqd
--takeoff from parking cold or hot, runway, or in the air
--check weapons loadout / F15E or B1B GBU31 or 38 JDAM / GBU 31(V)3/B JDAM bunker busters
--for delayed ground starts from ramp cold: check uncontrolled / triggered actions - perform command: start
--for delayed air starts: check late activation

-- @param Core.Point#COORDINATE Target Target coordinate. Can also be specified as a GROUP, UNIT or STATIC object.
-- @param #number Altitude Engage altitude in feet. Default 25000 ft.

--4 x GBU31(V)3/B bunker busters
local Target1=STATIC:FindByName("Static Fuel Tank A")
local bomber1=FLIGHTGROUP:New("BOMBER A")
local missionBOMB1=AUFTRAG:NewBOMBING(Target1, 13000)
missionBOMB1:SetTime(60*10, 60*55)
missionBOMB1:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBOMB1:SetPriority(10)
bomber1:AddMission(missionBOMB1)

--4 x GBU31(V)3/B bunker busters
local Target1=STATIC:FindByName("Static Ammunition Depot B")
local bomber2=FLIGHTGROUP:New("BOMBER B")
local missionBOMB2=AUFTRAG:NewBOMBING(Target1, 13000)
missionBOMB2:SetTime(60*10, 60*55)
missionBOMB2:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBOMB2:SetPriority(10)
bomber2:AddMission(missionBOMB2)

-- 2 target strike example

--local Target1=STATIC:FindByName("Static Fuel Tank B")
--local Target2=STATIC:FindByName("Static Ammunition Depot B")
--  local bomber2=FLIGHTGROUP:New("BOMBER B")
--  local mission1=AUFTRAG:NewBOMBING(Target1, nil)
--  mission1:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
--  mission1:SetPriority(10)
--  local mission2=AUFTRAG:NewBOMBING(Target2, nil)
--  mission2:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
--  mission2:SetPriority(20)
--  bomber2:AddMission(mission1)
--  bomber2:AddMission(mission2)

------------------------------------------
--BOMBING - GROUP, UNIT or STATIC object--
------------------------------------------

--In ME:
--create a/c group(s)
--no waypoints reqd
--takeoff from parking cold or hot, runway, or in the air
--check weapons loadout / F15E or B1B GBU31 or 38 JDAM / GBU 31(V)3/B JDAM bunker busters
--for delayed ground starts from ramp cold: check uncontrolled / triggered actions - perform command: start
--for delayed air starts: check late activation

-- @param Core.Point#COORDINATE Target Target coordinate. Can also be specified as a GROUP, UNIT or STATIC object.
-- @param #number Altitude Engage altitude in feet. Default 25000 ft.

--4 x GBU31(V)3/B bunker busters
local Target1=STATIC:FindByName("Static Fuel Tank A")
local bomber1=FLIGHTGROUP:New("BOMBER A")
local missionBOMB1=AUFTRAG:NewBOMBING(Target1, 13000)
missionBOMB1:SetTime(60*10, 60*55)
missionBOMB1:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBOMB1:SetPriority(10)
bomber1:AddMission(missionBOMB1)

--4 x GBU31(V)3/B bunker busters
local Target1=STATIC:FindByName("Static Ammunition Depot B")
local bomber2=FLIGHTGROUP:New("BOMBER B")
local missionBOMB2=AUFTRAG:NewBOMBING(Target1, 13000)
missionBOMB2:SetTime(60*10, 60*55)
missionBOMB2:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
missionBOMB2:SetPriority(10)
bomber2:AddMission(missionBOMB2)

-- 2 target strike example

--local Target1=STATIC:FindByName("Static Fuel Tank B")
--local Target2=STATIC:FindByName("Static Ammunition Depot B")
--  local bomber2=FLIGHTGROUP:New("BOMBER B")
--  local mission1=AUFTRAG:NewBOMBING(Target1, nil)
--  mission1:SetWeaponExpend(AI.Task.WeaponExpend.ALL)
--  mission1:SetPriority(10)
--  local mission2=AUFTRAG:NewBOMBING(Target2, nil)
--  mission2:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
--  mission2:SetPriority(20)
--  bomber2:AddMission(mission1)
--  bomber2:AddMission(mission2)



----------------------------------
--STRIKE - BOMBING on Coordinate--
----------------------------------

--In ME:
--create a/c group(s) good for F15E
--no waypoints reqd
--takeoff from parking cold or hot, runway, or in the air
--check weapons loadout / GBU31 or 38 JDAM bridges 
--						/ GBU 31(V)3/B JDAM bunker busters command centers and fortified ammo dumps 
--						/ Mk82s for airport fuel and ammo dumps
--						/ CBUs dont work well, wind drifts them off target
--for delayed ground starts from ramp cold: check uncontrolled / triggered actions - perform command: start
--for delayed air starts: check late activation

-- @param Core.Point#COORDINATE Target The target coordinate. Can also be given as a GROUP, UNIT or STATIC object.
-- AUFTRAG:NewSTRIKE(Target, 16000) -- 16000 is engage altitude, higher altitude works well
-- @param #number Altitude Engage altitude in feet. Default 2000 ft. 

-- default altitude 2000 ft
local Target=ZONE:New("Zone Strike A"):GetCoordinate()
local missionSTRIKE1=AUFTRAG:NewSTRIKE(Target, 6000)
local strike1=FLIGHTGROUP:New("STRIKE A")
missionSTRIKE1:SetTime(60*10, 60*55)
strike1:AddMission(missionSTRIKE1)
 
local Target=ZONE:New("Zone Strike B"):GetCoordinate()
local missionSTRIKE2=AUFTRAG:NewSTRIKE(Target, 6000)
local strike2=FLIGHTGROUP:New("STRIKE B")
missionSTRIKE2:SetTime(60*10, 60*55)
strike2:AddMission(missionSTRIKE2)

local Target=ZONE:New("Zone Strike C"):GetCoordinate()
local missionSTRIKE3=AUFTRAG:NewSTRIKE(Target, nil)
local strike3=FLIGHTGROUP:New("STRIKE C")
missionSTRIKE3:SetTime(60*10, 60*55)
strike3:AddMission(missionSTRIKE3)

local Target=ZONE:New("Zone Strike D"):GetCoordinate()
local missionSTRIKE4=AUFTRAG:NewSTRIKE(Target, nil)
local strike4=FLIGHTGROUP:New("STRIKE D")
missionSTRIKE4:SetTime(60*10, 60*55)
strike4:AddMission(missionSTRIKE4)

local Target=ZONE:New("Zone Strike E"):GetCoordinate()
local missionSTRIKE5=AUFTRAG:NewSTRIKE(Target, 500)
local strike5=FLIGHTGROUP:New("STRIKE E")
missionSTRIKE5:SetTime(60*10, 60*55)
strike5:AddMission(missionSTRIKE5)

local Target=ZONE:New("Zone Strike F"):GetCoordinate()
local missionSTRIKE6=AUFTRAG:NewSTRIKE(Target, 500)
local strike6=FLIGHTGROUP:New("STRIKE F")
missionSTRIKE6:SetTime(60*10, 60*55)
strike6:AddMission(missionSTRIKE6)


--create zones in ME

-- Common zones
local Zone={}
Zone.Alpha   = ZONE:New("Zone Alpha")   --Core.Zone#ZONE --1st SEAD zone
Zone.Bravo   = ZONE:New("Zone Bravo")   --Core.Zone#ZONE --2nd SEAD zone
--Zone.Charlie = ZONE:New("Zone Charlie") --Core.Zone#ZONE --not used
--Zone.Delta   = ZONE:New("Zone Delta")   --Core.Zone#ZONE --not used
-- Set of all zones defined in the ME
local AllZones=SET_ZONE:New():FilterOnce()


---------------
--CAS as SEAD--
---------------

--In ME:
--create SEAD a/c groups
--no waypoints reqd but sometimes useful offsetting from departing airport, make it a short leg
--takeoff from parking cold or hot, runway, or in the air
--check weapons loadout
--for delayed ground starts from ramp cold: check uncontrolled / triggered actions - perform command: start
--for delayed air starts: check late activation
--advanced waypoint actions--
--start enroute task--SEAD
--(Optional)Set option reaction to threat=horizontal AAA fire evade
--Reapers do better with an airstart and altitude of 8000 feet

-- AUFTRAG:NewCAS(ZoneCAS, Altitude, Speed, Coordinate, Heading, Leg, TargetTypes)
-- @param Core.Zone#ZONE_RADIUS ZoneCAS Circular CAS zone. Detected targets in this zone will be engaged.
-- @param #number Altitude Altitude at which to orbit. Default is 10,000 ft.
-- @param #number Speed Orbit speed in knots. Default 350 KIAS.
-- @param Core.Point#COORDINATE Coordinate Where to orbit. Default is the center of the CAS zone.
-- @param #number Heading Heading of race-track pattern in degrees. If not specified, a simple circular orbit is performed.
-- @param #number Leg Length of race-track in NM. If not specified, a simple circular orbit is performed.
-- @param #table TargetTypes (Optional) Table of target types. Default {"Helicopters", "Ground Units", "Light armed ships"}.

--make sure your allow for travel time to target area

--50/50 HARMs AGM 88C IR MAVs AGM65Fs
local cas1=FLIGHTGROUP:New("SEAD A")
local missionSEAD1=AUFTRAG:NewCAS(Zone.Alpha, 15000, nil, nil, nil, nil, nil)
missionSEAD1:SetTime(60, 60*40)
cas1:AddMission(missionSEAD1)

--50/50 HARMs AGM 88C IR MAVs AGM65Fs
local cas2=FLIGHTGROUP:New("SEAD B")
local missionSEAD2=AUFTRAG:NewCAS(Zone.Alpha, 15000, nil, nil, nil, nil, nil)
missionSEAD2:SetTime(60*2, 60*41)
cas2:AddMission(missionSEAD2)

--50/50 HARMs AGM 88C IR MAVs AGM65Fs
local cas3=FLIGHTGROUP:New("SEAD C")
local missionSEAD3=AUFTRAG:NewCAS(Zone.Bravo, 15000, nil, nil, nil, nil, nil)
missionSEAD3:SetTime(60*3, 60*42)
cas3:AddMission(missionSEAD3)