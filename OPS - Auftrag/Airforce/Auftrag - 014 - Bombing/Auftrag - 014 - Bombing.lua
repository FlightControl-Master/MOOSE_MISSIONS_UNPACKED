---
-- AUFTRAG: Bombing
-- 
-- B-52 group (late activated in air) is ordered to bomb two targets. A static TV tower and a group of BTRs.
-- As the group has no home or destination base, it will wait (orbit) once the two missions are over.
---

-- The targets.
local Target1=STATIC:FindByName("Red TV Tower")
local Target2=GROUP:FindByName("Red Target X")

-- Create a flight group and activate it. It will wait until the mission starts.
local bomber=FLIGHTGROUP:New("B-52 Air Group")
bomber:SetFuelLowThreshold(30)      -- Default is 25%.
bomber:SetFuelCriticalThreshold(15) -- Default is 10%.
bomber:Activate()

-- First bombing mission at 25000 ft. This will be carried out after the other mission as it has a lower prio!
local mission1=AUFTRAG:NewBOMBING(Target1, 25000)
mission1:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
mission1:SetTime("8:05")
mission1:SetPriority(20)

-- Second bombing mission at 30000 ft.
local mission2=AUFTRAG:NewBOMBING(Target2, 30000)
-- Interestingly, setting expend to ALL does NOT work. Looks like as half of the bombs is already gone in mission1, the task cannot be executed any more.
mission2:SetWeaponExpend(AI.Task.WeaponExpend.HALF)
mission1:SetTime("8:05")
mission2:SetPriority(10)

-- Assign missions to bomber crew.
bomber:AddMission(mission1)
bomber:AddMission(mission2)

--- Function called when group is low on fuel.
function bomber:OnAfterFuelLow(From,Event,To)
  MESSAGE:New("We are low on fuel. Can we go home boss?"):ToAll()
end

function bomber:OnAfterFuelCritical(From,Event,To)
  MESSAGE:New("We are CRITICAL on fuel. We really need to land somewhere!"):ToAll()
end