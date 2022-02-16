---
-- US Airwing at Andersen: BOMBING with ESCORT
-- 
-- This is a training mission involving a larger amount of bombers from Andersen Airbase.
-- Target are boming circles at Farallon de Medinilla (FdM).
-- 
-- Two missions with 5 bombers each are assigned. The missions is scheduled for 0805 and 0810 hours, respectively. 
-- 
-- First mission will target "FdM Bombing Circle-1". Each bomber group requires one escort flight (if no escort flights are available, the mission will not start).
-- Bombers will ingress from West to East at 25,000 ft and egress South at 15,000 ft.
-- 
-- Second mission will target "FdM Bombing Circle-2". Each bomber group requires zero to one escort flight (if escort flights are available they will be assigned, if not, bombers will go without escort).
-- Bombers will ingress from East to West at 30,000 ft and egress South at 18,000 ft.
-- 
-- Escorts are provided by the "1st US Fighter Squad". This squad has 20 groups but only 8 payloads for escort missions available. Therefore, the first mission will get their escort (as required).
-- However, for the second mission only three out of five bomber groups will have an escort flight.
-- 
-- Other features:
-- * Each squadron has their own parking spots assigned.
-- * Twenty bombers will be on Alert5 (spawned on the airbase) with loadouts for bombing runs.
-- * Each mission has a separate push time set, i.e. bombers will orbit at the incress position until the push time is reached.
---

-- Blue (US) side.
local US={}
US.Squad={} -- US squadrons.
US.Wing={}  -- US airwings.
US.Commander=nil --Ops.Commander#COMMANDER

 
-- Create a Hornet Squadron.
US.Squad.fsq01=SQUADRON:New("F/A-18C Template", 20, "1st US Fighter Squad") --Ops.Squadron#SQUADRON
US.Squad.fsq01:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ESCORT}, 100)
US.Squad.fsq01:AddMissionCapability({AUFTRAG.Type.ALERT5})
US.Squad.fsq01:SetModex(100)
US.Squad.fsq01:SetGrouping(1)
US.Squad.fsq01:SetParkingIDs({167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191})
US.Squad.fsq01:SetMissionRange(200)
US.Squad.fsq01:SetRadio(251, radio.modulation.AM)
-- US.Squad.fsq01:SetCallsign(CALLSIGN.Aircraft.Colt)

-- Create a B-52 Squadron.
US.Squad.bsq01=SQUADRON:New("B-52H Template", 10, "1st US Bomber Squad") --Ops.Squadron#SQUADRON
US.Squad.bsq01:AddMissionCapability({AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 80)
US.Squad.bsq01:AddMissionCapability({AUFTRAG.Type.ALERT5})
US.Squad.bsq01:SetModex(200)
US.Squad.bsq01:SetGrouping(1)
US.Squad.bsq01:SetParkingIDs({111, 112, 113, 114, 115, 116, 117, 118, 195, 196})
US.Squad.bsq01:SetMissionRange(200)
US.Squad.bsq01:SetRadio(252, radio.modulation.AM)
--US.Squad.bsq01:SetCallsign(CALLSIGN.Aircraft.Dodge)

-- Create a B-1B Squadron.
US.Squad.bsq02=SQUADRON:New("B-1B Template", 10, "2nd US Bomber Squad") --Ops.Squadron#SQUADRON
US.Squad.bsq02:AddMissionCapability({AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 80)
US.Squad.bsq02:AddMissionCapability({AUFTRAG.Type.ALERT5})
US.Squad.bsq02:SetModex(200)
US.Squad.bsq02:SetParkingIDs({80, 81, 82, 83, 84, 85, 86, 87, 88, 89})
US.Squad.bsq02:SetGrouping(1)
US.Squad.bsq02:SetMissionRange(200)
US.Squad.bsq02:SetRadio(253, radio.modulation.AM)
--US.Squad.bsq02:SetCallsign(CALLSIGN.Aircraft.Chevy)    

-- Create a new airwing.
US.Wing.Andersen=AIRWING:New("Warehouse Andersen", "US AW Andersen") --Ops.AirWing#AIRWING

-- Add squadrons to airwing.
for _,squad in pairs(US.Squad) do
  US.Wing.Andersen:AddSquadron(squad)
end

---
-- Payloads
---

-- F/A-18 Payloads
US.Wing.Andersen:NewPayload("F/A-18C Payload AIM-9M*6, AIM-7M*2, FUEL*2", 8, {AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ESCORT}, 80)

-- B-52 Payloads.
US.Wing.Andersen:NewPayload("B-52H Payload Mk 82*51", 10, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 80)
US.Wing.Andersen:NewPayload("B-52H Payload Mk-84*18", 10, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 70)
US.Wing.Andersen:NewPayload("B-52H Payload Mk20*18",   2, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 60)  

-- B-1 Payloads.
US.Wing.Andersen:NewPayload("B-1B Payload GBU-31*24", 10, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 80)
US.Wing.Andersen:NewPayload("B-1B Payload GBU-38*48", 10, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 70)
US.Wing.Andersen:NewPayload("B-1B Payload Mk-82*84",  10, {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBRUNWAY}, 60)

-- Start airwing.
US.Wing.Andersen:Start()  


---
-- Missions
---  

-- Zones for ingress, target and egress.
local ZoneWest=ZONE:New("Ingress West"):DrawZone()
local ZoneEast=ZONE:New("Ingress East"):DrawZone()
local ZoneSouth=ZONE:New("Egress South"):DrawZone()
local ZoneFdM1=ZONE:New("FdM Bombing Circle-1"):DrawZone()
local ZoneFdM2=ZONE:New("FdM Bombing Circle-2"):DrawZone()

-- Alert 5 mission for bombing. This will place 20 groups with payload capable of BOMBING missions on the airbase in uncontrolled state.
local alert5=AUFTRAG:NewALERT5(AUFTRAG.Type.BOMBING)
alert5:SetRequiredAssets(20)
US.Wing.Andersen:AddMission(alert5)


-- Bombing mission with 5 groups. Each one requires one escort asset. Ingress West, egress South of the target.
-- Mission starts 0805 hours. Push time is 0900 hours. We explicitly assign this to the 1st Bomber Squad. 
local bombing1=AUFTRAG:NewBOMBING(ZoneFdM1, 20000)
bombing1:SetPriority(10)
bombing1:SetRequiredAssets(5)
bombing1:SetMissionWaypointCoord(ZoneWest:GetCoordinate())
bombing1:SetMissionAltitude(25000)
bombing1:SetMissionEgressCoord(ZoneSouth:GetCoordinate(), 15000)
bombing1:SetTime("8:05")
bombing1:SetPushTime("9:00")
bombing1:AssignSquadrons({US.Squad.bsq01})
bombing1:SetRequiredEscorts(1, 1)

-- Bombing mission with 5 asset groups. Each one requires one escort asset. Ingress East, egress South of the target.
-- Mission starts at 0815 hours. Push time is 0920 hours. We explicitly assign this to the 2nd Bomber Squad.
local bombing2=AUFTRAG:NewBOMBING(ZoneFdM2, 25000)
bombing2:SetPriority(50)
bombing2:SetRequiredAssets(5)
bombing2:SetMissionWaypointCoord(ZoneEast:GetCoordinate())
bombing2:SetMissionAltitude(30000)
bombing2:SetMissionEgressCoord(ZoneSouth:GetCoordinate(), 18000)  
bombing2:SetRequiredEscorts(0, 1)
bombing2:AssignSquadrons({US.Squad.bsq02})
bombing2:SetTime("8:15")
bombing2:SetPushTime("09:20")


-- Assign mission to Airwing at Andersen.
US.Wing.Andersen:AddMission(bombing1)
US.Wing.Andersen:AddMission(bombing2)

--- Function called each time a flight group is send on a mission.
function US.Wing.Andersen:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission)
  local flightgroup=FlightGroup --Ops.FlightGroup#FLIGHTGROUP
  local mission=Mission --Ops.Auftrag#AUFTRAG
  
  --- Function called when the flight group gets low on fuel (default < 25% fuel remaining). 
  function flightgroup:OnAfterFuelLow(From, Event, To)
    local text=string.format("Running low on fuel %.2f. Returning to base!", flightgroup:GetFuelMin())
    env.info(string.format("FF %s: %s", flightgroup:GetName(), text))
    MESSAGE:New(text, 120, flightgroup:GetName()):ToAll()
  end
end
