---
-- NAVAL: Amphibious Landing
-- 
-- LHA Tarawa has loaded amphibious APCs. These are transported to a surf zone and unloaded
-- into the water. From there they drive to the beach.
-- 
-- The APCs itself have infantry troops loaded. Once the APCs reach their waypoint at the beach,
-- they will unload the troops, which will then go on a patrol zone mission.
-- 
---

-- Zones.
local zoneTarawa=ZONE_GROUP:New("LHA-1 Tarawa", GROUP:FindByName("LHA-1 Tarawa"), 1000)
local zoneDeploy=ZONE:New("Zone Surf Bravo"):DrawZone()
local zoneBravo=ZONE:New("Zone Shore Bravo"):DrawZone()

-- USS Tarawa carrier.
local tarawa=NAVYGROUP:New("LHA-1 Tarawa")
tarawa:SetPatrolAdInfinitum(false)
tarawa:SetCarrierUnloaderBack(50, 40)
tarawa:Activate()

-- Tansport assignment. The cargo groups are added later when we spawn them.
local transport=OPSTRANSPORT:New(nil, zoneTarawa, zoneDeploy)

-- Assign transport to Tarawa.
tarawa:AddOpsTransport(transport)

-- Create a SPAWN object that will spawn late activated AAV-7, which are amphibious.
local spawnAPC=SPAWN:New("APC AAV-7 Alpha-1"):InitLateActivated(true)

-- Create a SPAWN object that will spawn late activated Infantry.
local spawnInf=SPAWN:New("Infantry M4 Template"):InitLateActivated(true)

-- Spawn 5 APCs, create ARMYGROUPs, add each as cargo and load directly into the Tarawa.
for i=1,5 do

  -- Create ARMYGROUP from spawned APC, add as cargo and load directly into the Tarawa.
  local apc=ARMYGROUP:New(spawnAPC:Spawn())
  transport:AddCargoGroups(apc)
  tarawa:Load(apc)
  
  -- Create ARMYGROUP from spawned APC and load directly into the APC.
  local infgroup=ARMYGROUP:New(spawnInf:Spawn())
  apc:Load(infgroup)
end

-- Mission to patrol zone bravo.
local mission=AUFTRAG:NewPATROLZONE(zoneBravo)

--- Function called when a cargo group is unloaded from a carrier.
function transport:OnAfterUnloaded(From, Event, To, OpsGroupCargo, OpsGroupCarrier)
  local apc=OpsGroupCargo --Ops.ArmyGroup#ARMYGROUP
  
  -- Add random waypoint in zone Bravo.
  local wp1=apc:AddWaypoint(zoneBravo:GetRandomCoordinate())
  
  -- Give cruise command.
  apc:__Cruise(5)
  
  --- Function called when the group passed a waypoint.
  function apc:OnAfterPassingWaypoint(From, Event, To, Waypoint)
    local waypoint=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
    
    if waypoint.uid==wp1.uid then
    
      -- Get all cargo groups.
      local cargos=apc:GetCargoOpsGroups()
      
      for _,_infantrygroup in pairs(cargos) do
        local infantrygroup=_infantrygroup --Ops.ArmyGroup#ARMYGROUP
        
        -- Unload infantry near the carrier
        local Coordinate=apc:GetCoordinate():Translate(math.random(50, 100), math.random(0,360))          
        apc:Unload(infantrygroup, Coordinate, true)
        
        -- Assign patrol mission to infantry group.
        infantrygroup:AddMission(mission)
      end
      
    end
  end
  
end