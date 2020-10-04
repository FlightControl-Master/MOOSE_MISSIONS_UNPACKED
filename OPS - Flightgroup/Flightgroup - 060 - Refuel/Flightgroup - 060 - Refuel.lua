---
-- FLIHGTGROUP: Refuel
-- 
-- A KC-135 is set up as a tanker and a Viper group is ordered to refuel.
-- Both groups start in air and the Viper groups has only 60% fuel initially.
-- FSM events OnAfterRefuel() and OnAfterRefueled() are triggered, when the refueling task is started and ended.
-- 
-- Note that the AUFTRAG class offers more convenient methods to achieve the same thing. 
---

-- Define donor flight.
local tanker=FLIGHTGROUP:New("KC-135 Air Group")
tanker:SwitchRadio(255)
tanker:Activate()

-- Add enroute task TANKER.
tanker:AddTaskEnroute(CONTROLLABLE.EnRouteTaskTanker(nil))

-- Add task to orbit.
local taskOrbit=CONTROLLABLE.TaskOrbit(nil, ZONE:New("Zone Alpha"):GetCoordinate(), 8000, 250)
tanker:AddTask(taskOrbit)

-- Define acceptor flight.
local viper=FLIGHTGROUP:New("Viper Air Group")
viper:Activate()

--- Function called when group is ordered to refuel.
function viper:OnAfterRefuel()
  MESSAGE:New("Viper is tasked to refuel. Let's hope there is a tanker...", 120):ToAll()
end

--- Function called when refueling task is over.
function viper:OnAfterRefueled(From,Event,To)
  MESSAGE:New("Viper finished refueling", 120):ToAll()
end

-- Order Viper to refuel at the nearest tanker after 60 seconds.
viper:__Refuel(60)
