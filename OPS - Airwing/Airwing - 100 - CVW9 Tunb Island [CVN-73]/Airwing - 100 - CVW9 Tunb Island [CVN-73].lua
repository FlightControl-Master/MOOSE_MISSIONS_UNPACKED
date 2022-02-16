------------------------------------------------------------
--                   The Battle of Tunb
------------------------------------------------------------
--
-- US SitRep
-- =========
--
-- Carrier airwing CVW-9 is attacking Tunb island.
-- 
-- Our intel has identified several important targets on
-- Tunb island. But they are protected by air defenses.
-- 
-- Our plan is to
-- 
-- 1. Gain air superiority by destroying
-- 1.1 The S-75 search radar
-- 1.2 The runway of Tunb AFB
-- 1.3 The Grisha cruising near the island
-- 
-- 2. Once this is achieved we will attack the targets
-- 2.1 The remaining S-75 launchers
-- 2.2 Scud launchers
-- 2.3 Warehouse holding important red assets
-- 2.4 Infantry (because we can)
--
-- Other assets:
-- 
-- * Rescue Helo
-- * Recovery Tanker
-- * AWACS
-- 
-- Remarks:
--   
-- * Spawning on the carrier works surprisingly well but is
--   by far not perfect.
--   Therefore, it is important to delay mission starts in
--   order not to have too many aircraft spawn at once.
--   Also introduced an AIRBOSS to separate launches and
--   recoveries.
-- * We use the Super Carrier module because it leads to
--   fewer collisions on the deck, when aircraft are taxiing.
--
------------------------------------------------------------

------------------------------------------------------------
-- BLUE Side: The almighty US
------------------------------------------------------------

-- Blue (US) side.
local US={}
US.Squad={}   -- US squadrons.
US.Wing={}    -- US airwings.
US.Target={}  -- Targets for US forces.

---
-- US Carrier Airwing CVW-9 (CVN-74 USS Stennis)
-- 
-- CVW-9 Squadrons (October 2010):
-- 
-- * VFA-14  Tophatters  F/A-18E Super Hornet (Modex 100-199) --> F/A-18C Hornet
-- * VFA-41  Black Aces  F/A-18F Super Hornet (Modex 200-299) --> F/A-18C Hornet
-- * VFA-97  Warhawks    F/A-18F Super Hornet (Modex 300-399) --> F-14B Tomcat
-- * VFA 151 Vigilantes  F/A-18E Super Hornet (Modex 400-499) --> S-3B Tanker
-- * VAQ-133 Wizards     EA-18G  Growler      (Modex 500-599) --> Not modelled
-- * VAW-117 Wallbangers E-2C    Haweye       (Modex 600-609) --> E-2D  Hawkeye
-- * HSC-14  Chargers    MH-60S  Seahawk      (Modex 610-699) --> SH-60B Seahawk
-- * HSM-71  Raptors     MH-60R  Seahawk      (Modex 700-?)   --> SH-60B Seahawk
-- * VRC-30  Providers   C-2A    Greyhound    (Modex   ?-?)   --> Not modelled (Could be done with the Military Aircraft Mod)
---

---
-- CVW-9 Squadrons
---

-- VFA-14 Tophatters: Hornet*4*2, Callsign Dodge, Modex 100+, Skill Excellent, specialized on SEAD missions.
US.Squad.VFA14=SQUADRON:New("F-18 Group", 4, "VFA-14 (Tophatters)") --Ops.Squadron#SQUADRON
US.Squad.VFA14:SetGrouping(2)
US.Squad.VFA14:SetModex(100)
US.Squad.VFA14:SetCallsign(CALLSIGN.Aircraft.Dodge)
US.Squad.VFA14:SetRadio(251)
US.Squad.VFA14:SetLivery("VFA-34")
US.Squad.VFA14:SetSkill(AI.Skill.EXCELLENT)
US.Squad.VFA14:AddMissionCapability({AUFTRAG.Type.SEAD, AUFTRAG.Type.ANTISHIP}, 100)
US.Squad.VFA14:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 50)

-- VFA-41 Black Aces: Hornet*4*2, Callsign Chevy, Modex 200+, Skill Good, A2G specialists.
US.Squad.VFA41=SQUADRON:New("F-18 Group", 4, "VFA-41 (Black Aces)") --Ops.Squadron#SQUADRON
US.Squad.VFA41:SetGrouping(2)
US.Squad.VFA41:SetModex(200)
US.Squad.VFA41:SetCallsign(CALLSIGN.Aircraft.Chevy)
US.Squad.VFA14:SetRadio(252)
US.Squad.VFA41:SetLivery("VFA-83")
US.Squad.VFA41:SetSkill(AI.Skill.GOOD)
US.Squad.VFA41:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 100)
US.Squad.VFA41:AddMissionCapability({AUFTRAG.Type.SEAD, AUFTRAG.Type.ANTISHIP}, 50)

-- VFA-97 Warhawks: Tomcat*8*2, Callsign Ford, Modex 300+, Skill High, specialized on CAP and INTERCEPT missions.
US.Squad.VFA97=SQUADRON:New("F-14 Group", 8, "VFA-97 (Warhawks)") --Ops.Squadron#SQUADRON
US.Squad.VFA97:SetGrouping(2)
US.Squad.VFA97:SetModex(300)
US.Squad.VFA97:SetCallsign(CALLSIGN.Aircraft.Ford)
US.Squad.VFA97:SetLivery("VF-102 Diamondbacks")
US.Squad.VFA97:SetSkill(AI.Skill.HIGH)
US.Squad.VFA97:SetFuelLowRefuel(true)
US.Squad.VFA97:SetFuelLowThreshold(30)
US.Squad.VFA97:SetTurnoverTime(30, 5)
US.Squad.VFA97:AddMissionCapability({AUFTRAG.Type.GCICAP, AUFTRAG.Type.INTERCEPT}, 100)  

-- VFA-151 Vigilantes: S-3B Tanker*4, Callsign Texaco, Modex 400+, Skill Excellent, specialized on TANKER missions.
US.Squad.VFA151=SQUADRON:New("S-3B Tanker Group", 4, "VFA-151 (Vigilantes)") --Ops.Squadron#SQUADRON
US.Squad.VFA151:SetModex(400)
US.Squad.VFA151:SetCallsign(CALLSIGN.Tanker.Texaco)
US.Squad.VFA151:AddTacanChannel(64, 66)  -- Squad uses TACAN channels 64, 65, 66
US.Squad.VFA151:SetSkill(AI.Skill.EXCELLENT)
US.Squad.VFA151:AddMissionCapability({AUFTRAG.Type.TANKER}, 100)  

-- VAW-117 Wallbangers: Hawkeye*4, Callsign Wizard, Modex 600+, Skill Average, AWACS
US.Squad.VAW117=SQUADRON:New("E-2D Group", 4, "VAW-117 (Wallbangers)") --Ops.Squadron#SQUADRON
US.Squad.VAW117:SetModex(600)
US.Squad.VAW117:SetCallsign(CALLSIGN.AWACS.Wizard)
US.Squad.VAW117:SetLivery("VAW-125 Tigertails")
US.Squad.VAW117:SetSkill(AI.Skill.AVERAGE)
US.Squad.VAW117:AddMissionCapability({AUFTRAG.Type.AWACS})

-- HSC-14 Chargers: Seahawk*4, Callsign Pontiac, Modex 610+, Skill Good, specialized on Anti-ship missions.
US.Squad.HSC14=SQUADRON:New("SH-60B Group", 9, "HSC-14 (Chargers)") --Ops.Squadron#SQUADRON
US.Squad.HSC14:SetModex(610)
US.Squad.HSC14:SetCallsign(CALLSIGN.Aircraft.Pontiac)
US.Squad.HSC14:SetLivery("Hellenic Navy")
US.Squad.HSC14:SetSkill(AI.Skill.GOOD)
US.Squad.HSC14:AddMissionCapability(AUFTRAG.Type.ANTISHIP, 100)   -- Specialized on Anti-Ship
US.Squad.HSC14:AddMissionCapability(AUFTRAG.Type.RESCUEHELO, 20)  -- Can also do Rescue ops if required.

-- HSM-71 Raptors: Seahawk*4, Callsign Spingfield, Modex 700+, Skill Average, specialized on Rescue missions.
US.Squad.HSM71=SQUADRON:New("SH-60B Group", 2, "HSM-71 (Raptors)") --Ops.Squadron#SQUADRON
US.Squad.HSM71:SetModex(700)
US.Squad.HSM71:SetCallsign(CALLSIGN.Aircraft.Springfield)
US.Squad.HSM71:SetSkill(AI.Skill.AVERAGE)
US.Squad.HSM71:AddMissionCapability({AUFTRAG.Type.RESCUEHELO}, 100)


---  
-- CVW-9 Airwing
---

-- Create an airwing.
US.Wing.CVW9=AIRWING:New("USS Stennis", "CVW-9") --Ops.AirWing#AIRWING

-- Set patrol points for CAP, AWACS and tanker missions.
US.Wing.CVW9:AddPatrolPointCAP(ZONE:FindByName("Zone US CAP Alpha"):GetCoordinate(), 20000, 300, 270, 15)
US.Wing.CVW9:AddPatrolPointAWACS(ZONE:FindByName("Zone US AWACS Alpha"):GetCoordinate(), 30000, 350, 90, 25)  
US.Wing.CVW9:AddPatrolPointTANKER(ZONE:FindByName("Zone US Tanker Alpha"):GetCoordinate(), 20000, 350, 270, 25)

US.Wing.CVW9:SetNumberCAP(1)
US.Wing.CVW9:SetNumberAWACS(1)
US.Wing.CVW9:SetNumberTankerProbe(1)
US.Wing.CVW9:SetNumberRescuehelo(1)


-- Add squadrons to airwing.
for _,squad in pairs(US.Squad) do
  US.Wing.CVW9:AddSquadron(squad)
end

---
-- CVW-9 Payloads
---

-- F-18 payloads.
local pF18_Harpoon=US.Wing.CVW9:NewPayload("F-18 Payload AGM-84D Harpoon", 5, {AUFTRAG.Type.ANTISHIP}, 100)

local pF18_Harm=US.Wing.CVW9:NewPayload("F-18 Payload AGM-88C HARM", 8, {AUFTRAG.Type.SEAD}, 100)

-- Mavs for BAI but also anti-ship and SEAD.
local pF18_Mav=US.Wing.CVW9:NewPayload("F-18 Payload AGM-65E", 5, {AUFTRAG.Type.BAI}, 80)
US.Wing.CVW9:AddPayloadCapability(pF18_Mav, {AUFTRAG.Type.ANTISHIP, AUFTRAG.Type.SEAD}, 20)  -- Mavs can do ANTISHIP and SEAD as well but are less performant than Harpoon or HARMs.

-- MK-83 dumb bombs for AG missions.
local pF18_MK83=US.Wing.CVW9:NewPayload("F-18 Payload MK-83", 30, {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 50)

-- F-14 payloads for CAP and INTERCEPT. Phoenix are first, sparrows are second choice.
US.Wing.CVW9:NewPayload("F-14 Payload AIM-54C", 2, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP}, 80)
US.Wing.CVW9:NewPayload("F-14 Payload AIM-7M", 20, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP})

-- SH-60 payloads.
US.Wing.CVW9:NewPayload("SH-60B Group", 50, {AUFTRAG.Type.ORBIT, AUFTRAG.Type.RESCUEHELO})
US.Wing.CVW9:NewPayload("SH-60B Payload AGM-119 Penguin", 20, AUFTRAG.Type.ANTISHIP, 100)

---
-- Start CVW-9
---

-- Start airwing.
US.Wing.CVW9:Start()

---
  -- How to win the Battle of Tunb: Targets for the BLUE Side
  ---
 
-- Primary targets
US.Target.S75=GROUP:FindByName("S-75 Group")  --Wrapper.Group#GROUP
US.Target.TunbAFB=AIRBASE:FindByName(AIRBASE.PersianGulf.Tunb_Island_AFB)  --Wrapper.Airbase#AIRBASE
US.Target.Grisha=GROUP:FindByName("Grisha Group")  --Wrapper.Group#GROUP

-- Secondary targets
US.Target.Scud=GROUP:FindByName("Red Scud Alpha Group")  --Wrapper.Group#GROUP  
US.Target.Warehouse=STATIC:FindByName("Warehouse Tunb Island AFB") --Wrapper.Static#STATIC
US.Target.Infantry=GROUP:FindByName("Red Infantry Platoon Alpha Group") --Wrapper.Group#GROUP


---
-- Airboss
-- 
-- Note: we need this or we still get crashes of taxiing AI on deck.
---

-- Set up an airboss to handle the recovery.
local airboss=AIRBOSS:New("USS Stennis")
airboss:Start()

--- Flight enters marshal.
function airboss:OnAfterMarshal(From, Event, To, flight)

  local Rstart, Rstop=airboss:GetNextRecoveryTime(true)
  
  -- No future window or window is opened more than 20 min later.
  if Rstart<0 or Rstart-timer.getAbsTime()>20*60 then
    airboss:AddRecoveryWindow(5*60, 25*60, 1, nil, true, 20, false)
  end

end

---
-- Define missions for CVW-9
-- 
-- Note: in order to deconflict the carrier deck, we start missions with at certain times or under certain conditions.
---

--- Function returns true, is a unit of a give name is dead.
local function UnitDead(name)
  local unit=UNIT:FindByName(name)
  if not unit then
    return true
  else
    return not unit:IsAlive()
  end
end

--- Function returns true, if the target of a mission was damaged by more than X %. Default 50 %.
local function MissionDamage(Mission, DamageInPercent)
  local mission=Mission --Ops.Auftrag#AUFTRAG
  return mission:GetTargetDamage() > (DamageInPercent or 50)
end

--- Function returns true, when the carrier is not recovering so aircraft can be launched.
local function CarrierNotRecovering()  
  return airboss:IsIdle()
end

-- Missions
local mission={}

---
-- Primary Missions
---

-- SEAD mission on the S-75 site. Mission is a success, if the search radar is destroyed.
mission.S75_1=AUFTRAG:NewSEAD(US.Target.S75)  --Ops.Auftrag#AUFTRAG
mission.S75_1:SetPriority(1, nil, 1)
mission.S75_1:SetRepeatOnFailure(999)
mission.S75_1:SetRequiredAssets(1)
mission.S75_1:AssignSquadrons({US.Squad.VFA14})         -- We explicitly assign VFA-14 to do the job!
mission.S75_1:SetTime(5*60)                             -- We wait to let the rescue helo and AWACS take off.
mission.S75_1:SetMissionEgressCoord(ZONE:FindByName("Zone US CAP Alpha"):GetCoordinate(), 5000)
mission.S75_1:AddConditionSuccess(UnitDead, "S75 #001")  -- "S75 #001" is the name of the search radar unit.

-- Anti-ship strike to destroy the Grisha after S-75 search radar is dead.
mission.Grisha1=AUFTRAG:NewANTISHIP(US.Target.Grisha, 8000)  --Ops.Auftrag#AUFTRAG
mission.Grisha1:SetPriority(1, nil, 1)
mission.Grisha1:SetMissionAltitude(8000)
mission.Grisha1:SetRepeatOnFailure(3)
mission.Grisha1:SetRequiredAssets(4)
mission.Grisha1:AssignSquadrons({US.Squad.VFA14, US.Squad.VFA41})   -- We explicitly assign VFA-14 and VFA-41 to do the job!
mission.Grisha1:AddConditionStart(UnitDead, "S75 #001")
mission.Grisha1:AddConditionStart(CarrierNotRecovering)  

-- DEAD mission to finish off the S-75. Mission is started, once the search radar was destroyed.
mission.S75_2=AUFTRAG:NewBAI(US.Target.S75, 10000)  --Ops.Auftrag#AUFTRAG
mission.S75_2:SetPriority(1, nil, 1)
mission.S75_2:SetMissionAltitude(10000)
mission.S75_2:SetRepeatOnFailure(3)
mission.S75_2:SetRequiredAssets(2)
mission.S75_2:AddConditionStart(UnitDead, "Grisha")
mission.S75_2:AddConditionStart(CarrierNotRecovering)

-- BOMB RUNWAY mission to destroy the runway at Tunb AFB once the S-75 is 50% damaged but not before 10 min after mission start.
mission.TunbAFB=AUFTRAG:NewBOMBRUNWAY(US.Target.TunbAFB)  --Ops.Auftrag#AUFTRAG
mission.TunbAFB:SetPriority(2, nil, 1)
mission.TunbAFB:SetRepeatOnFailure(6)
mission.TunbAFB:SetRequiredAssets(2)
mission.TunbAFB:AddConditionStart(UnitDead, "Grisha")
mission.TunbAFB:AddConditionStart(CarrierNotRecovering)

---
-- Secondary Missions
---

-- BOMBING mission to destroy a warehouse. This could hold an enemy airwing.
mission.Warehouse=AUFTRAG:NewBOMBING(US.Target.Warehouse, 15000) --Ops.Auftrag#AUFTRAG
mission.Warehouse:SetPriority(50, nil, 2)
mission.Warehouse:SetRepeatOnFailure(3)
mission.Warehouse:AddConditionStart(CarrierNotRecovering)

-- BAI to destroy Scud lauchers.
mission.Scud=AUFTRAG:NewBAI(US.Target.Scud) --Ops.Auftrag#AUFTRAG
mission.Scud:SetPriority(20, nil, 2)
mission.Scud:SetRepeatOnFailure(3)
mission.Scud:SetMissionAltitude(5000)
mission.Scud:SetRequiredAssets(2)
mission.Scud:AddConditionStart(CarrierNotRecovering)

-- BAI to destroy some infantry group.
mission.Infantry=AUFTRAG:NewBAI(US.Target.Infantry) --Ops.Auftrag#AUFTRAG
mission.Infantry:SetPriority(50, nil, 2)
mission.Infantry:SetRequiredAssets(2)
mission.Infantry:SetRepeatOnFailure(3)
mission.Infantry:SetMissionAltitude(6000)
mission.Infantry:AddConditionStart(CarrierNotRecovering)

-- Assign missions to airwing CVW-9.
for _,auftrag in pairs(mission) do
  US.Wing.CVW9:AddMission(auftrag)
end


--- Display mission status on screen.
local function MissionStatus()

  local Ndead=0
  local Nkill=0

  local text="Primary Missions:"
  for _,_mission in pairs(mission) do
    local m=_mission --Ops.Auftrag#AUFTRAG
    if m:GetImportance()<=1 then
      text=text..string.format("\n- %s %s %s*%d/%d [%d %%]  (%s*%d/%d)", 
      m:GetName(), m:GetState():upper(), m:GetTargetName(), m:CountMissionTargets(), m:GetTargetInitialNumber(), m:GetTargetDamage(), m:GetType(), m:CountOpsGroups(), m:GetNumberOfRequiredAssets())
    end
    Ndead=Ndead+m:GetCasualties()
    Nkill=Nkill+m:GetKills()
  end
  text=text.."\n\nSecondary Missions:"
  for _,_mission in pairs(mission) do
    local m=_mission --Ops.Auftrag#AUFTRAG
    if m:GetImportance()>=2 then
      text=text..string.format("\n- %s %s %s*%d/%d [%d %%]  (%s*%d/%d)", 
      m:GetName(), m:GetState():upper(), m:GetTargetName(), m:CountMissionTargets(), m:GetTargetInitialNumber(), m:GetTargetDamage(), m:GetType(), m:CountOpsGroups(), m:GetNumberOfRequiredAssets())
    end
    Ndead=Ndead+m:GetCasualties()
    Nkill=Nkill+m:GetKills()        
  end
  
  local Nassets=US.Wing.CVW9:CountAssets()
  
  -- Casualties & kills.
  text=text..string.format("\n\nAssets: %d | Kills: %d  |  Casualties: %d", Nassets, Nkill, Ndead)
  
  -- CVN-74 info.
  local Rstart, Rstop=airboss:GetNextRecoveryTime()
  text=text..string.format("\n\n CVN-74 %s: Marshal %d, Pattern %d, Recovery %s-%s", airboss:GetState(), #airboss.Qmarshal, #airboss.Qpattern, Rstart, Rstop)
  
  -- Display mission status on screen.
  MESSAGE:New(text, 60, nil, true):ToAll()

  -- Check if battle is won? Assume we won... but all missions need to be a SUCCESS.
  local battlewon=true  
  for _,_mission in pairs(mission) do
    local m=_mission --Ops.Auftrag#AUFTRAG
    if not m:IsSuccess() then
      battlewon=false -- Nope, not yet.
    end
  end

  if battlewon then        
    US.Wing.CVW9:_Fireworks()
    MESSAGE:New("Hurray! Tunb island is ours.", 60):ToAll()
  end
      
end

-- Display primary and secondary mission status every 60 seconds.
TIMER:New(MissionStatus):Start(5, 60)

