------------------------------------
-- Self Propelled Airborne Assets --
------------------------------------
-- 1. Kutaisi requests two Yak-52 with high (10) priority from Senaki.
-- 2. Kobuleti requests half Yak-52 with low (70) priority and gets the remaining half of the rest.
-- 3. FARP London requests 1/3 of all available Hueys from Senaki. 

-- Create WAREHOUSE objects.
local warehouseSenaki   = WAREHOUSE:New(STATIC:FindByName("Warehouse Senaki"),   "Senaki")
local warehouseKutaisi  = WAREHOUSE:New(STATIC:FindByName("Warehouse Kutaisi"),  "Kutaisi")
local warehouseKobuleti = WAREHOUSE:New(STATIC:FindByName("Warehouse Kobuleti"), "Kobuleti")
local warehouseLondon   = WAREHOUSE:New(STATIC:FindByName("Warehouse London"),   "London")

-- Start warehouses
warehouseSenaki:Start()
warehouseKutaisi:Start()
warehouseKobuleti:Start()
warehouseLondon:Start()

-- Add assets to Senaki warehouse
warehouseSenaki:AddAsset("Yak-52", 10)
warehouseSenaki:AddAsset("Huey", 6)

-- Kusaisi requests 3 Yak-52 form Senaki while Kobuleti wants all the rest.
warehouseSenaki:AddRequest(warehouseKutaisi,  WAREHOUSE.Descriptor.GROUPNAME, "Yak-52", 1, nil, nil, 10)
warehouseSenaki:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.GROUPNAME, "Yak-52", WAREHOUSE.Quantity.HALF, nil, nil, 70)

-- FARP London wants 1/3 of the six available Hueys.
warehouseSenaki:AddRequest(warehouseLondon,  WAREHOUSE.Descriptor.GROUPNAME, "Huey", WAREHOUSE.Quantity.THIRD)
