---
-- AUFTRAG: Bomb Runway
-- 
-- B-52 4-ship group is tasks to bomb the runway at Gudauta. Once the mission is done, we send the flight back to Batumi.
-- 
-- As Batumi is a small airbase, it has only parking space for one B-52. The other three B-52s would be automatically despawned by DCS shortly after landing.
-- While this would be properly handled by the code, we set :SetDespawnAfterLanding() so that all units will be despawned when they land. This can also be useful to avoid DCS taxiing issues.
-- (Unfortunately, there is no way (via scripting) to tell whether an aircraft unit can takeoff or land at an airbase (in terms of its size).
--  The only way is to try to place it on the airbase in the mission editor. If the group snaps to another airbase, it cannot takeoff or land there.)
---

-- Target airbase.
local Target=AIRBASE:FindByName(AIRBASE.Caucasus.Gudauta)

-- Create flight group. The group will be despawned after landing to avoid potential taxi problems.
local bomber=FLIGHTGROUP:New("B-52 Air Group")
bomber:SetDespawnAfterLanding()

-- Drop half of all bombs on the runway at Gudauta.
local mission=AUFTRAG:NewBOMBRUNWAY(Target, 10000)
mission:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
mission:SetFormation(ENUMS.Formation.FixedWing.LineAbreast.Close)
mission:SetMissionAltitude(10000)

-- Assign mission to bomber crew.
bomber:AddMission(mission)

--- Function called when the mission is over.
function mission:OnAfterDone()
  -- Loop over all assigned groups. In this case only one.
  for _,opsgroup in pairs(mission:GetOpsGroups()) do
    local flightgroup=opsgroup --Ops.FlightGroup#FLIGHTGROUP
    flightgroup:RTB(AIRBASE:FindByName("Batumi"))
  end
end

--- Function called when the mission was successful.
function mission:OnAfterSuccess()
  MESSAGE:New("Runway destroyed!", 300):ToAll()
end

--- Function called if the mission failed.
function mission:OnAfterFailed()
  MESSAGE:New("Runway was NOT destroyed!", 300):ToAll()
end