-------------------------------------------------------------------------
-- CTLD 120 - Statics - Test Mission
-------------------------------------------------------------------------
-- Documentation
-- 
-- CTLD: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.CTLD.html
-- 
-------------------------------------------------------------------------
-- Join a Helicopter. Use the F10 menu to request ammo crates.
-- Load and fly over 5 ammunition crates to the trucks waiting at the farm at waypoint 1. 
-- Once dropped, the trucks will drive to the artillery, so Kobuleti can be shelled!
-------------------------------------------------------------------------
-- Date: 23 June 2021
-------------------------------------------------------------------------

-- Set up CTLD
local myctld = CTLD:New(coalition.side.BLUE,{"Player"},"LtRg II")
myctld.allowcratepickupagain = false
myctld.dropcratesanywhere = false
myctld.forcehoverload = false
myctld.smokedistance = UTILS.NMToMeters(3)
myctld.verbose = 2
myctld:__Start(5)

-- define a pickup zone
myctld:AddCTLDZone("PickupZone",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)

-- define a drop zone
myctld:AddCTLDZone("DropZone",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Red,true,true)

-- define statics cargo
myctld:AddStaticsCargo("Ammunition",50,25) -- ammuntion weight 50kg ;) stock 25 pc

-- update unit capabilities for testing - allow 5 crates
myctld:UnitCapabilities("UH-1H", true, true, 5, 12, 15)
myctld:UnitCapabilities("SA342L", true, true, 5, 3, 12)
myctld:UnitCapabilities("Mi-24P", true, true, 5, 8, 18)
myctld:UnitCapabilities("Mi-8MT", true, true, 5, 12, 15)

-- count dropped ammo
local ammocounter = 0

-- check CratesDropped FSM event and action if enough ammo dropped
function myctld:OnAfterCratesDropped(From,Event,To,Group,Unit,Cargotable)
  local table = Cargotable
  for _,_cargo in pairs (table) do
    -- count objects
    local cargo = _cargo -- Ops.CTLD#CTLD_CARGO
    local name = cargo:GetName()
    if string.find(name,"Ammunition") then
      ammocounter = ammocounter + 1
      local obj = cargo:GetPositionable()
      if obj and obj:IsAlive() then -- "load" on truck
        obj:Destroy()
      end
    end
  end
  local m = MESSAGE:New(string.format("Overall %d ammo boxes loaded!",ammocounter),20,"Info"):ToAll()
  if math.floor(ammocounter / 5) >= 1 then -- dropped enough boxes?
    -- Get Going!
    local m = MESSAGE:New("Moving Trucks!",20,"Info"):ToAll()
    local trucks = GROUP:FindByName("Ammo Trucks") -- Wrapper.Group#GROUP
    local coord = ZONE:New("TruckTarget"):GetCoordinate()
    trucks:RouteGroundTo(coord,30,"Line abreast",5)
    -- Order Ari to fire
    local ari = GROUP:FindByName("Blue Artillery")
    local tgtzone = ZONE:New("TargetZone"):GetCoordinate()
    local vec2 = tgtzone:GetVec2()
    local task = ari:TaskFireAtPoint(vec2,325,500)
    ari:PushTask(task,300)
  end
end



