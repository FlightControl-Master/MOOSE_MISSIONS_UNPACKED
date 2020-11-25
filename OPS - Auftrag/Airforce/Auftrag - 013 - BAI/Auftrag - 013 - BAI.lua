---
-- AUFTRAG: Battlefield Air Interdiction (BAI)
-- 
-- Viggen flight is assigned a mission to destroy a group of three BTRs at the old airfield new Kobuleti.
-- Mission is a success if 1/3 of the targets (i.e. one unit) is destroyed.
---

-- Target group.
local target=GROUP:FindByName("Red Target X")

-- Create a BAI mission. Engage altitude is 5000 ft.
local auftrag=AUFTRAG:NewBAI(target, 5000)
auftrag:SetMissionAltitude(2000) -- Mission waypoint alitude is 2000 ft.

--- Function returns true, if the target of a mission was damaged by more than X %. Default 50 %.
local function MissionDamage(Mission, DamageInPercent)
    local mission=Mission --Ops.Auftrag#AUFTRAG
    return mission:GetTargetDamage() > (DamageInPercent or 50)
end

-- Add a success condition that 30% life point damage of the group is sufficient for a successful mission.
auftrag:AddConditionSuccess(MissionDamage, auftrag, 30)

--- Function called, when mission was successful.
function auftrag:OnAfterSuccess(From, Event, To)
  MESSAGE:New(string.format("Mission %s accomplished!", auftrag:GetName()), 300):ToAll()
end

--- Function called when mission was a failure.
function auftrag:OnAfterFailed(From, Event, To)
  MESSAGE:New(string.format("Mission %s failed!", auftrag:GetName()), 300):ToAll()
end  


-- Assign mission to pilot.
local flightgroup=FLIGHTGROUP:New("Viggen BAI Group")
flightgroup:AddMission(auftrag)
