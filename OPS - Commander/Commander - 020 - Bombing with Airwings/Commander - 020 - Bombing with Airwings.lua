---
-- COMMANDER: Bombing with Airwings
-- 
-- The Commander is in charge of three airwings located at Batumi, Kobuleti and Senaki. Each airwing has one squadron of F/A-18C fighters.
-- 
-- A mission to bomb red targets is assigned to the commander. This mission requires more assets than each individual airwing can supply.
-- The commander will recruite the number of required assest from all of his airwings.
---

-- Blue (US) side.
local US={}
US.Squad={} -- US squadrons.
US.Wing={}  -- US airwings.
US.Commander=nil  --Ops.Commander#COMMANDER

-- F/A-18C squadron.
US.Squad.FS01=SQUADRON:New("F/A-18C Template", 2, "1st Fighter Squad") --Ops.Squadron#SQUADRON
US.Squad.FS01:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY})
US.Squad.FS01:SetModex(100)
US.Squad.FS01:SetCallsign(CALLSIGN.Aircraft.Chevy)
US.Squad.FS01:SetSkill(AI.Skill.GOOD)

-- F/A-18C squadron.
US.Squad.FS02=SQUADRON:New("F/A-18C Template", 2, "2nd Fighter Squad") --Ops.Squadron#SQUADRON
US.Squad.FS02:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY})
US.Squad.FS02:SetModex(200)
US.Squad.FS02:SetCallsign(CALLSIGN.Aircraft.Colt)
US.Squad.FS02:SetSkill(AI.Skill.GOOD)

-- F/A-18C squadron.
US.Squad.FS03=SQUADRON:New("F/A-18C Template", 2, "3rd Fighter Squad") --Ops.Squadron#SQUADRON
US.Squad.FS03:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY})
US.Squad.FS03:SetModex(300)
US.Squad.FS03:SetCallsign(CALLSIGN.Aircraft.Springfield)
US.Squad.FS03:SetSkill(AI.Skill.GOOD)


---
-- AIRWING Batumi
---

-- Create a new airwing.
US.Wing.Batumi=AIRWING:New("Warehouse Batumi", "1st Fighter Wing Batumi") --Ops.AirWing#AIRWING
  
-- Payload F/A-18C  
US.Wing.Batumi:NewPayload("F/A-18C Payload AIM-9M*2, MK-83*4, FUEL*2", 2, {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 70)
    
-- Add squadrons to airwing.
US.Wing.Batumi:AddSquadron(US.Squad.FS01)

---
-- AIRWING Kobuleti
---

-- Create a new airwing.
US.Wing.Kobuleti=AIRWING:New("Warehouse Kobuleti", "2nd Fighter Wing Kobuleti") --Ops.AirWing#AIRWING
  
-- Payload F/A-18C  
US.Wing.Kobuleti:NewPayload("F/A-18C Payload AIM-9M*2, MK-83*4, FUEL*2", 2, {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 70)
    
-- Add squadrons to airwing.
US.Wing.Kobuleti:AddSquadron(US.Squad.FS02)

---
-- AIRWING Senaki
---

-- Create a new airwing.
US.Wing.Senaki=AIRWING:New("Warehouse Senaki", "3nd Fighter Wing Senaki") --Ops.AirWing#AIRWING
  
-- Payload F/A-18C  
US.Wing.Senaki:NewPayload("F/A-18C Payload AIM-9M*2, MK-83*4, FUEL*2", 1, {AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 70)
    
-- Add squadrons to airwing.
US.Wing.Senaki:AddSquadron(US.Squad.FS03)


---
-- COMMANDER
---

-- Commander.
US.Commander=COMMANDER:New(coalition.side.BLUE)

-- Add airwings to commander
US.Commander:AddAirwing(US.Wing.Batumi)
US.Commander:AddAirwing(US.Wing.Kobuleti)
US.Commander:AddAirwing(US.Wing.Senaki)

-- Start commander. This also auto starts added airwings if they are not started yet.
US.Commander:__Start(1)


--- Function called each time the commanders sends an OPS group on a mission.
function US.Commander:OnAfterOpsOnMission(From, Event, To, OpsGroup, Mission)
  local opsgroup=OpsGroup --Ops.OpsGroup#OPSGROUP
  local mission=Mission   --Ops.Auftrag#AUFTRAG

  -- Info message.
  local text=string.format("Group %s is on %s mission %s", opsgroup:GetName(), mission:GetType(), mission:GetName())
    MESSAGE:New(text, 360):ToAll()
    env.info(text)  
  end
  
 
  ---
-- MISSION
---

-- Target X: A group at the abondoned airfield near Kobuleti.
local TargetX=TARGET:New(GROUP:FindByName("Red Target X-1"))

-- Mission to bomb Target X.
-- We will recruit up to six asset groups (at least two) and repeat five times if mission was not successful. 
local MissionBombX=AUFTRAG:NewBOMBING(TargetX, 8000)
MissionBombX:SetRequiredAssets(2, 6)
MissionBombX:SetRepeatOnFailure(5)


-- Add mission to Commander.
US.Commander:AddMission(MissionBombX)