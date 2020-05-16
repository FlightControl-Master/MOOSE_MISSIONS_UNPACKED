-----------------------
-- Test 17: Resupply --
-----------------------
-- Warehouse at FARP Berlin is located at the front line and sends infantry groups to the battle zone.
-- Whenever a group dies, a new group is send from the warehouse to the battle zone.
-- Additionally, for each dead group, Berlin requests resupply from Batumi.

-- Display mission time every 30 seconds.
SCHEDULER:New(nil, UTILS.DisplayMissionTime, {5}, 30, 30)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Define Warehouses.
local warehouse={}

-- Blue warehouses
warehouse.Senaki   = WAREHOUSE:New(STATIC:FindByName("Warehouse Senaki"),   "Senaki")   --Functional.Warehouse#WAREHOUSE
warehouse.Batumi   = WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"),   "Batumi")   --Functional.Warehouse#WAREHOUSE
warehouse.Kobuleti = WAREHOUSE:New(STATIC:FindByName("Warehouse Kobuleti"), "Kobuleti") --Functional.Warehouse#WAREHOUSE
warehouse.Kutaisi  = WAREHOUSE:New(STATIC:FindByName("Warehouse Kutaisi"),  "Kutaisi")  --Functional.Warehouse#WAREHOUSE
warehouse.Berlin   = WAREHOUSE:New(STATIC:FindByName("Warehouse Berlin"),   "Berlin")   --Functional.Warehouse#WAREHOUSE
warehouse.London   = WAREHOUSE:New(STATIC:FindByName("Warehouse London"),   "London")   --Functional.Warehouse#WAREHOUSE
warehouse.Stennis  = WAREHOUSE:New(STATIC:FindByName("Warehouse Stennis"),  "Stennis")  --Functional.Warehouse#WAREHOUSE
warehouse.Pampa    = WAREHOUSE:New(STATIC:FindByName("Warehouse Pampa"),    "Pampa")    --Functional.Warehouse#WAREHOUSE
warehouse.Pearth   = WAREHOUSE:New(STATIC:FindByName("Warehouse Pearth"),   "Pearth")   --Functional.Warehouse#WAREHOUSE
-- Red warehouse
warehouse.Sukhumi  = WAREHOUSE:New(STATIC:FindByName("Warehouse Sukhumi"),  "Sukhumi")  --Functional.Warehouse#WAREHOUSE
warehouse.Gudauta  = WAREHOUSE:New(STATIC:FindByName("Warehouse Gudauta"),  "Gudauta")  --Functional.Warehouse#WAREHOUSE
warehouse.Sochi    = WAREHOUSE:New(STATIC:FindByName("Warehouse Sochi"),    "Sochi")    --Functional.Warehouse#WAREHOUSE

-- Fine tune warehouses if necessary.
warehouse.Batumi:SetSpawnZone(ZONE:New("Warehouse Batumi Spawn Zone"))
warehouse.Senaki:SetSpawnZone(ZONE:New("Warehouse Senaki Spawn Zone"))
warehouse.Kobuleti:SetSpawnZone(ZONE_POLYGON:New("Warehouse Kobuleti Spawn Zone", GROUP:FindByName("Warehouse Kobuleti Spawn Zone")))


-- Creat explosion at an object.
local function Explosion(object, power)
  power=power or 1000
  if object and object:IsAlive() then
    object:GetCoordinate():Explosion(power)
  end
end  

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Start warehouses.
warehouse.Batumi:Start()
warehouse.Berlin:Start()

-- Front line warehouse.
warehouse.Berlin:AddAsset("Infantry Platoon Alpha", 6)

-- Resupply warehouse.
warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 50)

-- Battle zone near FARP Berlin. This is where the action is!
local BattleZone=ZONE:New("Virtual Battle Zone")

-- Send infantry groups to the battle zone. Two groups every ~60 seconds.
for i=1,2 do
  local time=(i-1)*60+10
  warehouse.Berlin:__AddRequest(time, warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 2, nil, nil, nil, "To Battle Zone")
end

-- Take care of the spawned units.
function warehouse.Berlin:OnAfterSelfRequest(From,Event,To,groupset,request)
  local groupset=groupset --Core.Set#SET_GROUP
  local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
  
  -- Get assignment of this request.
  local assignment=warehouse.Berlin:GetAssignment(request)
  
  if assignment=="To Battle Zone" then
    
    for _,group in pairs(groupset:GetSet()) do
      local group=group --Wrapper.Group#GROUP
      
      -- Route group to Battle zone.
      local ToCoord=BattleZone:GetRandomCoordinate()
      group:RouteGroundOnRoad(ToCoord, group:GetSpeedMax()*0.8)
      
      -- After 3-5 minutes we create an explosion to destroy the group.
      SCHEDULER:New(nil, Explosion, {group, 50}, math.random(180, 300))
    end
        
  end
  
end

-- An asset has died ==> request resupply for it.
function warehouse.Berlin:OnAfterAssetDead(From, Event, To, asset, request)
  local asset=asset       --Functional.Warehouse#WAREHOUSE.Assetitem
  local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
  
  -- Get assignment.
  local assignment=warehouse.Berlin:GetAssignment(request)

  -- Request resupply for dead asset from Batumi.
  warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, asset.attribute, 1, nil, nil, nil, "Resupply")
  
  -- Send asset to Battle zone either now or when they arrive.
  warehouse.Berlin:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, asset.attribute, 1, nil, nil, nil, assignment)
end
