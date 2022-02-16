---------------------------------------------------------------------------------------------------------------------------------------
-- AIRWING: Fighter Wing
-- 
-- Kutaisi is the home of the 35th Fighter Wing. For simplicity, the wing consists of only one squadron.
-- That is the 13th Fighter Squadron ("Panthers") who are flying F-16C Vipers.
-- 
-- An airwing needs a physical structure (e.g. a static warehouse or an aircraft carrier).
-- If that is destroyed, the airwing and its resources are lost as well.
-- 
-- The central ingredient of airwings are squadrons. Each squadron consists of a single type of airframes.
-- A squadron has certain "capabilities", i.e. mission types it can execute. These need to be set by the mission designer.
-- Each capability can be given a "performance". That is how good this squadron is at this mission.
-- 
-- Another important factor for an operational airwing are payloads (weapons). Without payloads most missions can not be executed.
-- Therefore payloads also have to be added to the airwing. They are reduced when an asset group of the wing is lauchned on a mission
-- and returned when the asset safely returns to the wing. 
-- 
-- An airwing will always choose the best available squadron for a given mission. The actual choice depends on the performance of the
-- available squadrons and the performance of the available payloads.
-- 
-- Here, we give the airwing two missions:
-- 
-- * A CAP mission is assigned to engage all enemy air targets in CAP zone Alpha.
-- * A BAI mission is assigned to attack a group of unarmed trucks at the abandoned airfield near Kobuleti. 
-- 
---------------------------------------------------------------------------------------------------------------------------------------

---
-- Define Squadron(s)
---

-- Squadron of five F-16s two ships (10 airframes in total).
local FS13=SQUADRON:New("F-16 Template", 5, "13th Fighter Squadron") --Ops.Squadron#SQUADRON
FS13:SetGrouping(2)                      -- Two-ships. Good to have a wingmen.
FS13:SetModex(100)                       -- Onboard numbers are 100, 101, ...
FS13:SetCallsign(CALLSIGN.Aircraft.Ford) -- Call sign is Ford.
FS13:SetRadio(260)                       -- Squadon communicates on 260 MHz AM.
FS13:SetSkill(AI.Skill.EXCELLENT)        -- These guy are really good.
FS13:AddMissionCapability({AUFTRAG.Type.ORBIT, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT}, 90) --Highly specialized in A2A.
FS13:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 80)                   --Also very good at A2G.

---  
-- Define Airwing
---

-- Create an airwing.
local FW35=AIRWING:New("Warehouse Kutaisi", "35th Fighter Wing") --Ops.AirWing#AIRWING

-- Add squadron(s) to airwing.
FW35:AddSquadron(FS13)

---
-- Airwing Payloads
---

-- Add 10 payloads of AIM-120s used for Intercep, CAP and escort missions. Performance is set to 80, i.e. considered a good loadout for these mission types.
FW35:NewPayload("F-16 Payload AIM-120B*6, Fuel*2", 10, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.ESCORT}, 80)

-- Add 15 payloads of MK-82AIRs used for BAI, bombing, and runway bombing missions. Performance is set to 50, i.e. considered to be mediocre. If there we better loadouts, these would be preferred.
FW35:NewPayload("F-16 Payload AIM-120*2, AIM-9X*2, MK-82AIR*4, FUEL*2, TGP", 15, {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 50)

---
-- Start Airwing
---

-- Start airwing.
FW35:Start()

---
-- FSM Events
---

--- Function called each time a flight of the airwing goes on a mission.
function FW35:OnAfterFlightOnMission(From, Event, To, FlightGroup, Mission)
  local flightgroup=FlightGroup --Ops.FlightGroup#FLIGHTGROUP
  local mission=Mission         --Ops.Auftrag#AUFTRAG
  
  -- Info message.
  local text=string.format("Flight group %s on %s mission %s", flightgroup:GetName(), mission:GetType(), mission:GetName())
  env.info(text)
  MESSAGE:New(text, 300):ToAll()
end


---
-- Define Targets
---

-- Practice target consising of 5 fire trucks located at the old airfield near Kobuleti forming an X.
local target=TARGET:New(GROUP:FindByName("Red Target X-1"))

---
-- Define Missions
---

-- CAP zone.
local zoneCAP=ZONE:New("CAP Alpha"):DrawZone()

-- CAP mission at zone CAP Alpha. Altitude 12,000 ft, speed 350 KIAS, heading 090 degrees for 20 NM. Auto engage all enemy air targets.
local mCAP=AUFTRAG:NewCAP(zoneCAP, 12000, 350, nil, 090, 20, {"Air"})

-- BAI mission for target group at the Kobuleti X. The mission is repeated up to three times if it fails.
local mBAI=AUFTRAG:NewBAI(target):SetRepeatOnFailure(3)


-- Assign mission to airwing.
FW35:AddMission(mCAP)
FW35:AddMission(mBAI)


---
-- Misc
---

--- Display mission status on screen.
local function MissionStatus()

  local text="Missions:"
  for _,_mission in pairs(FW35.missionqueue) do
    local m=_mission --Ops.Auftrag#AUFTRAG
    text=text..string.format("\n- %s %s %s*%d/%d [%d %%]  (%s*%d/%d)", 
    m:GetName(), m:GetState():upper(), m:GetTargetName(), m:CountMissionTargets(), m:GetTargetInitialNumber(), m:GetTargetDamage(), m:GetType(), m:CountOpsGroups(), m:GetNumberOfRequiredAssets())
  end
  
  -- Payloads
  text=text.."\n\nAvailable Payloads:"  
  for _,aname in pairs(AUFTRAG.Type) do
    local n=FW35:CountPayloadsInStock({aname})
    if n>0 then
      text=text..string.format("\n%s %d", aname, n)
    end
  end
    
  -- Info message to all.
  MESSAGE:New(text, 25):ToAll()
end

-- Display primary and secondary mission status every 60 seconds.
TIMER:New(MissionStatus):Start(5, 30)