------------------
-- Self Request --
------------------
-- 1. Two groups of infantry are spawned in the Batumi spawn zone.
-- 2. After ~10 seconds they are put back into the warehouse stock.
-- 3. After some time they are spawned again.
-- 4. And so on and so forth... 

-- Create a WAREHOUSE object.
local warehouseBatumi=WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"),   "Batumi")

-- Start warehouse Batumi.
warehouseBatumi:Start()

-- Add one infantry asset.
warehouseBatumi:AddAsset(GROUP:FindByName("Infantry Platoon Alpha"), 4)

-- Add self request for one infantry at Batumi.
warehouseBatumi:AddRequest(warehouseBatumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 2)
    
--- Self request event. Triggered once the assets are spawned in the spawn zone or at the airbase.
function warehouseBatumi:OnAfterSelfRequest(From, Event, To, groupset, request)
  local groupset=groupset --Core.Set#SET_GROUP
  
  -- Loop over all groups spawned from that request.
  for _,group in pairs(groupset:GetSet()) do
    local group=group --Wrapper.Group#GROUP
    
    -- Gree smoke on spawned group.
    --group:SmokeGreen()
    
    -- Put asset back to stock after 10 seconds.      
    warehouseBatumi:__AddAsset(10, group)
  end
  
  -- Add new self request after 20 seconds.
  warehouseBatumi:__AddRequest(20, warehouseBatumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 2)
  
end
