
---
-- AUFTRAG: SEAD
-- 
-- JF-17 2-ship group is tasks to destroy the search radar of an SA-2 site.
---

-- The target unit.
local Target=UNIT:FindByName("Red SA-2 #010")

-- Create a flightgroup.
local jf17=FLIGHTGROUP:New("JF-17 SEAD Group")

-- SEAD mission.
local auftrag=AUFTRAG:NewSEAD(Target, 5000)
jf17:AddMission(auftrag)
