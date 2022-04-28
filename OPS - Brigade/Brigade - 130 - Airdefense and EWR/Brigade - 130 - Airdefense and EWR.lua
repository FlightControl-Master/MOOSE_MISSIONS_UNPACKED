---
-- BRIGADE: SAM+EWR
-- 
-- Beslan sets up a two SAM sites and one EWR.
-- The assets are teleported to the zones where they should operate.
-- 
-- A blue airwing launches missions to bomb the runway of Beslan.
-- They chances to be successful are rather slim but they will keep trying.
-- 
-- We also setup a red detection (INTEL) and add the spawned red groups.
-- Intel will print messages when new contacts are detected and lost.
---

-- Zones where SAMs should be located.
local zoneSAMalpha=ZONE:New("Beslan SAM Alpha"):DrawZone()
local zoneSAMbravo=ZONE:New("Beslan SAM Bravo"):DrawZone()
local zoneEWRalpha=ZONE:New("Beslan EWR Alpha"):DrawZone()

-- Spawn zone for brigade.
local zoneSpawnBeslan=ZONE:New("Warehouse Beslan Spawn Zone"):DrawZone()

-- Platoon of SA-10.
local platoonSA10=PLATOON:New("SA-10 Template", 1, "Platoon SA-10")
platoonSA10:AddMissionCapability({AUFTRAG.Type.AIRDEFENSE}, 50)

-- Platoon of SA-11.
local platoonSA11=PLATOON:New("SA-11 Template", 1, "Platoon SA-11")
platoonSA11:AddMissionCapability({AUFTRAG.Type.AIRDEFENSE}, 80)

-- Platoon of SA-11.
local platoonEWR=PLATOON:New("EWR 1L13 Template", 2, "Platoon EWR 1L13")
platoonEWR:AddMissionCapability({AUFTRAG.Type.EWR}, 80)  

-- Define the brigade.
local brigade=BRIGADE:New("Warehouse Beslan", "Brigade Beslan")

-- Set spawn zone.
brigade:SetSpawnZone(zoneSpawnBeslan)

-- Add platoons to the brigade.
brigade:AddPlatoon(platoonSA10)
brigade:AddPlatoon(platoonSA11)
brigade:AddPlatoon(platoonEWR)

-- Start brigade.
brigade:Start()

-- Red intel.
local redintel=INTEL:New(nil, coalition.side.RED)
redintel:Start()

--- Function called when a new contact is detected.
function redintel:OnAfterNewContact(From, Event, To, Contact)

  -- Contact details.
  local group=redintel:GetContactGroup(Contact)
  local name=redintel:GetContactName(Contact)
  local coord=redintel:GetContactCoordinate(Contact)
  local typename=redintel:GetContactTypeName(Contact)
  local threatlevel=redintel:GetContactThreatlevel(Contact)
  
  -- Infol message.
  local text=string.format("Detected new contact group %s: Type=%s, Threatlevel=%d, ", name, typename, threatlevel)
  MESSAGE:New(text, 600):ToAll()
  env.info(text)

end

--- Function called when a contact cannot be detected any more.
function redintel:OnAfterLostContact(From, Event, To, Contact)
  -- Infol message.
  local text=string.format("Lost contact group %s", redintel:GetContactName(Contact))
  MESSAGE:New(text, 600):ToAll()
  env.info(text)
end 

--- Function called each time an army group is send on a mission.
function brigade:OnAfterArmyOnMission(From, Event, To, ArmyGroup, Mission)
  local armygroup=ArmyGroup --Ops.ArmyGroup#ARMYGROUP
  local mission=Mission     --Ops.Auftrag#AUFTRAG
  
  -- Info message.
  local text=string.format("Armygroup %s on %s mission \"%s\"", armygroup:GetName(), mission:GetType(), mission:GetName())
  MESSAGE:New(text, 360):ToAll()
  env.info(text)
      
  -- Add group to intel detection set.
  redintel:AddAgent(ArmyGroup)
end

-- Create airdefense mission for SAM zone alpha.
local missionSAMalpha=AUFTRAG:NewAIRDEFENSE(zoneSAMalpha)
missionSAMalpha:SetTeleport()

-- Create airdefense mission for SAM zone bravo.
local missionSAMbravo=AUFTRAG:NewAIRDEFENSE(zoneSAMbravo)
missionSAMbravo:SetTeleport()

-- Create EWR mission for EWR zone alpha. Immobile assets are teleported.
local missionEWRalpha=AUFTRAG:NewEWR(zoneEWRalpha)

-- Assign mission to brigade.
brigade:AddMission(missionSAMalpha)
brigade:AddMission(missionSAMbravo)
brigade:AddMission(missionEWRalpha)

---
-- Airwing at Kutaisi
---

-- Create a squadron.
local squad1stF16=SQUADRON:New("F-16CM Template", 12, "1st F-16 Wing")
squad1stF16:SetGrouping(2)
squad1stF16:AddMissionCapability({AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 80)

-- Create airwing.
local airwingKutaisi=AIRWING:New("Warehouse Kutaisi", "Airwing Kutaisi")

-- Assets take of "in air" and are despawned near the airbase.
airwingKutaisi:SetTakeoffAir()
airwingKutaisi:SetDespawnAfterHolding()

-- Add squadron.
airwingKutaisi:AddSquadron(squad1stF16)

-- Add payloads for bombing missions. Amount is unlimited.
airwingKutaisi:NewPayload("F-16CM Payload AIM-120C*2, AIM-9X*2, AGM-65K*2, FUEL*2, TGP", -1 , {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 70)
airwingKutaisi:NewPayload("F-16CM Payload AIM-120*2, AIM-9X*2, MK-82AIR*4, FUEL*2, TGP", -1 , {AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 80)

-- Start airwing.
airwingKutaisi:Start()

-- Create mission to bomb runway at Beslan.
local missionBombBeslan=AUFTRAG:NewBOMBRUNWAY(AIRBASE.Caucasus.Beslan, 20000)
missionBombBeslan:SetRequiredAssets(1, 3)
missionBombBeslan:SetRepeatOnFailure(4)

-- Add mission to airwing.
airwingKutaisi:AddMission(missionBombBeslan)
