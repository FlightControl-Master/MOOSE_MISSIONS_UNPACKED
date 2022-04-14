---
-- COMMANDER: Infantry Transport via Helos
-- 
-- Two brigades at Batumi and Kobuleti provide ground assets for a PATROL ZONE mission.
-- 
-- The Airwing at Senaki provides helicopter assets to transport assets to the patrol zone.
-- The helicopters will fly to the brigades and pickup the infantry.
---  

---
-- BRIGADE Batumi
---  

-- Create a platoon of infantry groups.
local platoonBatumiInf=PLATOON:New("Infantry M4 Template", 2, "Infantry Platoon Batumi")
platoonBatumiInf:AddMissionCapability({AUFTRAG.Type.PATROLZONE}, 40)

-- Create a Brigade
local brigadeBatumi=BRIGADE:New("Warehouse Batumi", "Brigade Batumi")

-- Set spawn zone.
brigadeBatumi:SetSpawnZone(ZONE:New("Warehouse Batumi Spawn Zone"))

-- Add platoons.
brigadeBatumi:AddPlatoon(platoonBatumiInf)

---
-- BRIGADE Kobuleti
---  

local platoonKobuletiInf=PLATOON:New("Infantry M4 Template", 2, "Infantry Platoon Kobuleti")
platoonKobuletiInf:AddMissionCapability({AUFTRAG.Type.PATROLZONE}, 40)

-- Create a Brigade
local brigadeKobuleti=BRIGADE:New("Warehouse Kobuleti", "Brigade Kobuleti")

-- Set spawn zone.
brigadeKobuleti:SetSpawnZone(ZONE:New("Warehouse Kobuleti Spawn Zone"))

-- Add platoons.
brigadeKobuleti:AddPlatoon(platoonKobuletiInf)

---
-- AIRWING Senaki
---

-- UH-1H squadron.
local squadSenakiUH1H=SQUADRON:New("UH-1H Template", 5, "UH-1H Squadron Senaki") --Ops.Squadron#SQUADRON
squadSenakiUH1H:AddMissionCapability({AUFTRAG.Type.OPSTRANSPORT})

-- Create a new airwing.
local airwingSenaki=AIRWING:New("Warehouse Senaki", "3nd Transport Wing Senaki") --Ops.AirWing#AIRWING
  
-- Payloads.
airwingSenaki:NewPayload("UH-1H Template", -1, {AUFTRAG.Type.OPSTRANSPORT}, 70)
    
-- Add squadrons to airwing.
airwingSenaki:AddSquadron(squadSenakiUH1H)

---
  -- COMMANDER
  ---  
 
-- Create a commander.
local commander=COMMANDER:New(coalition.side.BLUE)

-- Add legions to commander.
commander:AddLegion(airwingSenaki)
commander:AddLegion(brigadeBatumi)
commander:AddLegion(brigadeKobuleti)

-- Start commander. This also auto-starts all assigned legions.
commander:Start()

--- Function called each time and OPS group is send on a mission.
function commander:onafterOpsOnMission(From, Event, To, OpsGroup, Mission)
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

-- Patrol zone.
local zoneAlpha=ZONE:New("Patrol Alpha"):DrawZone()

-- Mission to patrol the zone.
-- At least four infantry asset groups required.
-- These need to be transported by at least one and up to 5 cargo carrier asset groups.
local missionPatrol=AUFTRAG:NewPATROLZONE(zoneAlpha)
missionPatrol:SetRequiredAssets(4)
missionPatrol:SetRequiredTransport(zoneAlpha, 1, 5)


-- Assign mission to commander.
commander:AddMission(missionPatrol)
