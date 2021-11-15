---
-- AIRPLANE: Realistic Weight-Realistic Problems
-- 
-- When cargo is loaded into an aircraft, the weight of the carrier
-- is increased via the trigger.action.setUnitInternalCargo() function.
-- 
-- This can lead to "problems" as it affects the flight characteristings.
-- 
-- To demonstrate this effect, we add 100 tons of cargo to a C-130 and
-- let it take off.
-- 
-- With the additional weight, the takeoff length increases significantly.
-- The runway at Kobuleti is too short and the aircraft will crash at the
-- end of the runway.
-- 
-- For comparison, a second C-130 without additional cargo takes off with
-- no problems.
---

-- C-130 without cargo.
local c130bravo=FLIGHTGROUP:New("C-130 Kobuleti Bravo")
c130bravo:Activate()
c130bravo:StartUncontrolled(1)

-- C-130 with 100,0000 kg (artificial) cargo loaded.
local c130charlie=FLIGHTGROUP:New("C-130 Kobuleti Charlie")  
c130charlie:Activate()
c130charlie:StartUncontrolled(1)

-- Add cargo weight.
c130charlie:AddWeightCargo("C-130 Kobuleti Charlie-1", 100*1000)