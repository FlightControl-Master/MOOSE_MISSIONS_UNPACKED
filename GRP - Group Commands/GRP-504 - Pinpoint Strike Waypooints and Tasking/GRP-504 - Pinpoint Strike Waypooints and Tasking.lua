--- 
-- Name: GRP-550 - Shows how to make an AI bomb ground targets, both static and scenery.
-- Author: Wingthor
-- Date Created: 22 Aug 2020
--
-- Mission illustrates how to make an air GROUP make a bomb run by script.
-- One template group is placed on map by DCS's Mission Editor.
-- Template is set to TASK "Ground Attack", and given proper ordnance in Mission Editor
-- One function handles both attack by give targets coordinates as arguments
-- This also shows how to do a delayed function call using BASE:ScheduleOnce function
-- Mission also feature a helper function which will return a random waypoint between Airbase and Target.
--
-- Join the Game Master to observe the reaction of the ground units.
-- 
-- Blue is attacking.


BASE:TraceOnOff(true)
BASE:TraceAll(true)

--- Help functions ---------------------------------------
--- This function will make a random waypoint between to coordiantes.
--- @param Core.Point#COORDINATE
--- @param Core.Point#COORDINATE
function MakeMiddleWaypoint (TargetCoordinate, InitCoordinate)
    BASE:F({TargetCoordinate,InitCoordinate})
    --- If we can not solve this function throw noting back so we dont' break anything.
    if TargetCoordinate == nil or InitCoordinate == nil then return nil end
    --- @type TargetCoordinate Core.Point#COORDINATE
    --- @type InitCoordinate Core.Point#COORDINATE
    local _TargetCoordinate = TargetCoordinate
    local _InitCoordinate = InitCoordinate
    local Distance = TargetCoordinate:Get3DDistance(InitCoordinate)
    if Distance < 30000 then 
        return nil -- To close for us
    elseif Distance > 70000 then
        Distance = 70000
    else 
        Distance = math.random(30000,70000)
    end -- This is max distance from target we want our Waypoint
    local Direction  = _TargetCoordinate:GetAngleDegrees(_TargetCoordinate:GetDirectionVec3(_InitCoordinate))
    if Direction > 0 and Direction <=90 then -- North East
        return _TargetCoordinate:Translate(Distance, math.random(1,90))
        
    elseif Direction > 90 and Direction <= 180 then -- South East
        return _TargetCoordinate:Translate(Distance, math.random(91,180))
    elseif Direction > 180 and Direction <= 270 then -- South West then
        return _TargetCoordinate:Translate(Distance,math.random(181,270))
    elseif Direction > 270 and Direction <= 360 then -- South West then then
        return _TargetCoordinate:Translate(Distance,math.random(271,360))
    else
        BASE:E("--- Something wrong in function MakeMiddleWaypoint ---")
        return nil
    end

end
    

--- @param #string
--- @param --Core.Point#COORDINATE
--- @param #string AIRBASE
--- @param #string 
function PinpointStrike(Group,Target,Base,TargetDescription)
    BASE:F({Group,Target,Base})
    -- In case all args is not passed.
    if Group == nil or Target == nil or Base == nil then return nil end
    -- Make a default description
    if TargetDescription == nil then 
        TargetDescription = "Bomb Target" 
    end
    -- Make a Random heading from the target which will server as an IP
    local heading = math.random(90,180) 
    -- Get targets vevtors
    local targetVec = Target:GetVec2()
    -- Make a Spawn counter
    if SpawnCounter == nil then 
        SpawnCounter = 0
    else
        SpawnCounter = SpawnCounter + 1
    end
    -- Spawn the bomber and return a GROUP object
    
    local SpawnBomber = SPAWN:NewWithAlias( Group, "Bomber" .. "_" .. tostring(SpawnCounter) )
    :OnSpawnGroup(function (Moosegroup) 
        local message = MESSAGE:New("Launching the Pinpointstrike",40,"Order:",true):ToBlue()
        end,{})
    ---@type GROUP
    local bomber = SpawnBomber:SpawnAtAirbase(AIRBASE:FindByName( Base ), SPAWN.Takeoff.Cold)
    local task = bomber:TaskBombing(targetVec,false,"All",nil,heading,10000) -- WeaponType find this...
    local homebasecoords = AIRBASE:FindByName(Base):GetCoordinate() --Core.Point#COORDINATE

    --- Make a waypoint table
    local waypoints = {}
    
    --- Get coordinate for Home Base
    local homecoords = AIRBASE:FindByName(Base):GetCoordinate():SetAltitude(8000):Translate(10 * 10000,300)
    --- Make an ingrespoint for the bomber
    local IngressPoint = MakeMiddleWaypoint( Target, homebasecoords) --Core.Point#COORDINATE
    if IngressPoint == nil then -- Its important to handle the edge cases so we don't break anything. Better throw somwthing to log.
        BASE:E("--- Error in PinpointStrike target is too close to base ---" )
        return nil
    end

    -- Set the coordinate altitude
    IngressPoint:SetAltitude(8000)
    -- Add coordiantes to table and make Waypoints
    waypoints[1] = homebasecoords:WaypointAirTakeOffParking()
    waypoints[2] = IngressPoint:WaypointAirTurningPoint(nil,950,{task},TargetDescription)
    waypoints[3] = homecoords:WaypointAirTurningPoint()
    waypoints[4] = homebasecoords:WaypointAirLanding()
    -- Push the waypoint table the bomber
    bomber:Route(waypoints)
  
  end

  -- local targetCoords = ZONE:New("Blue Bridge"):GetCoordinate() --Core.Point#COORDINATE
  local CommandCenterCoords = STATIC:FindByName("SAM ControlCenter",false):GetCoordinate()
  
  -- I have added a small zone over a scenery object in order to grab the coordiantes.
  local SceneryTargetCoordiate = ZONE:New("SceneryTarget"):GetCoordinate()
  BASE:ScheduleOnce(5,PinpointStrike,"Bloue Owl 1-1",CommandCenterCoords,AIRBASE.Caucasus.Sukhumi_Babushara,"Bomb Command Center")
  BASE:ScheduleOnce(10,PinpointStrike,"Bloue Owl 1-1",SceneryTargetCoordiate,AIRBASE.Caucasus.Sukhumi_Babushara,"Bomb Commanders House")


  

