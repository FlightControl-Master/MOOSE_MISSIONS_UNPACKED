---
-- NAVAL: A Spy named Pikey
-- 
-- A submarine is used to transport a spy, callsign Pikey, to a strategically important bridge.
-- Pikey's assigment is to place 100 kg TNT at the bridge to destroy it.
-- 
-- Pikey will be picked up by the sub and dropped off near the bridge.
-- 
-- As Pikey is a nice guy, we won't leave him behind (which was the initial plan). The sub will
-- wait until he returns and bring him back to safe ground.
---

-- Zones.
local zonePickup=ZONE:New("Zone Surf Bravo"):DrawZone()
local zoneDeploy=ZONE:New("Zone Surf Spy"):DrawZone()
local zoneEmbark=ZONE:New("Zone Shore Bravo"):DrawZone()
local zoneDisembark=ZONE:New("Zone Shore Spy"):DrawZone()
local zoneBridge=ZONE:New("Ludendorff Bridge"):DrawZone()

-- Carrier group.
local uboot=NAVYGROUP:New("U-93")
uboot:SetPatrolAdInfinitum(false)
uboot:SetDefaultAltitude(-30)
uboot:Activate()

-- Infantry cargo group.
local pikey=ARMYGROUP:New("Spy")

-- Transport assignment to bring Pikey to the deploy zone near the bridge.
local transport1=OPSTRANSPORT:New(pikey, zonePickup, zoneDeploy)

-- Set embark zone. This is the zone where the spy needs to be for loading.
transport1:SetEmbarkZone(zoneEmbark)

-- Set disembark zone. This is the zone, where Pikey will by spawned.
transport1:SetDisembarkZone(zoneDisembark)

-- Transport assignment to bring Pikey back. Pickup/deploy and embark/disembark zones are switched wrt to the first transport.
local transport2=OPSTRANSPORT:New(nil, zoneDeploy, zonePickup)
transport2:SetEmbarkZone(zoneDisembark)
transport2:SetDisembarkZone(zoneEmbark)

-- Assign transports to carrier.
uboot:AddOpsTransport(transport1)
uboot:AddOpsTransport(transport2)

--- Function called when transport was delivered.
function uboot:OnAfterDelivered(From, Event, To, Transport)
  local transport=Transport --Ops.OpsTransport#OPSTRANSPORT
  env.info("Transport delivered UID="..tostring(transport.uid))
  if transport.uid==transport1.uid then
    -- U-boot will stop once Pikey was delivered to the deploy zone. We need to delay the call a bit for this to work as internal functions would make the sub go back.
    uboot:__FullStop(1)
  end
end

--- Function called when the spy is disembarked from the carrier.
function pikey:OnAfterDisembarked()

  if pikey:IsInZone(zoneDisembark) then
    -- Debug info.
    env.info("Pikey disembarked near the bridge!")

    -- Coordinate of the bridge.
    local CoordBridge=zoneBridge:GetCoordinate()
    local CoordDisembark=zoneDisembark:GetCoordinate()
    
    -- Add waypoints.
    local wpBridge=pikey:AddWaypoint(CoordBridge,    UTILS.KmphToKnots(pikey.speedMax), nil,          ENUMS.Formation.Vehicle.OnRoad, false)
    local wpEmbark=pikey:AddWaypoint(CoordDisembark, UTILS.KmphToKnots(pikey.speedMax), wpBridge.uid, ENUMS.Formation.Vehicle.OnRoad, false)
    
    -- Give the cruise command in 10 seconds.
    pikey:__Cruise(10)
    
    --- Function called when the Spy passes a waypoint.
    function pikey:OnAfterPassingWaypoint(From, Event, To, Waypoint)
      local wp=Waypoint --Ops.OpsGroup#OPSGROUP.Waypoint
      
      if wp.uid==wpBridge.uid then
        -- Pikey has reached the bridge and place TNT.
        CoordBridge:SetAltitude(20, true):Explosion(1000, 360)
      elseif wp.uid==wpEmbark.uid then
        -- Once Pikey finished his mission, he is added as cargo.
        transport2:AddCargoGroups(pikey)
      end
      
    end
    
  end    
end