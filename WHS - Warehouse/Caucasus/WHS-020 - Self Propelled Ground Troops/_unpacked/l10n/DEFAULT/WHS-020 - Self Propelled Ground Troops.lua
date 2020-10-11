----------------------------------
-- Self Propelled Ground Troops --
----------------------------------
-- 1. Ground troops - APCs and infantry - are transferred from Batumi to FARP Berlin.
-- 2. Warehouse Berlin is empty initially. But a request from Batumi is made for APCs. This cannot be processed and is held in the queue.
-- 3. Once the assets arrive at Berlin, the request can be processed and some APCs are send back to Batumi.

-- Create WAREHOUSE objects.
local warehouseBatumi=WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"), "Batumi")
local warehouseBerlin=WAREHOUSE:New(STATIC:FindByName("Warehouse Berlin"), "Berlin")

-- Set spawn zone for warehouse Batumi.
warehouseBatumi:SetSpawnZone(ZONE:New("Warehouse Batumi Spawn Zone"))

-- Start Warehouse at Batumi.
warehouseBatumi:Start()

-- Add 20 infantry groups and 10 APCs as assets to Batumi warehouse stock.
warehouseBatumi:AddAsset("Infantry Platoon Alpha", 20)
warehouseBatumi:AddAsset("TPz Fuchs", 10)

-- Start Warehouse Berlin. 
warehouseBerlin:Start()

-- Warehouse Berlin requests ten infantry groups and five APCs from warehouse Batumi
warehouseBatumi:AddRequest(warehouseBerlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 10)
warehouseBatumi:AddRequest(warehouseBerlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_APC, 5)

-- Request from Batumi for two APCs. Initially these are not in stock. When they become available, the request is executed.
warehouseBerlin:AddRequest(warehouseBatumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_APC, 2)  
