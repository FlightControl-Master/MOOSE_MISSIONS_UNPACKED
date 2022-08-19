-------------------------------------------------------------------------
-- PlayerTask 020 - Caucasus - Test Mission with detection
-------------------------------------------------------------------------
-- Documentation
-- 
-- PLAYERTASK: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.PlayerTask.html
-- 
-------------------------------------------------------------------------
-- Join the game master slot initially, and then a plane slot after a few
-- seconds, to allow event capturing to start. Tasking is made available
-- over the F10 Menu
-------------------------------------------------------------------------
-- Date: August 2022
-------------------------------------------------------------------------

-- Settings
_SETTINGS:SetPlayerMenuOn()
_SETTINGS:SetImperial()
_SETTINGS:SetA2G_BR()

-- Set up A2G task controller for the blue side named "82nd Airborne"
local taskmanager = PLAYERTASKCONTROLLER:New("82nd Airborne",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)

-- Set up detection with grup names containing "Blue Recce", these will add targets to our controller. Here's it's a Reaper Drone
taskmanager:SetupIntel("Blue Recce")
-- Add a single Recce group name "Blue Humvee"
taskmanager:AddAgent(GROUP:FindByName("Blue Humvee"))

-- Set the menu to be calles Eagle Eye
taskmanager:SetMenuName("Eagle Eye")

-- Add accept- and reject-zones for detection
taskmanager:AddAcceptZone(ZONE:New("AcceptZone"))
taskmanager:AddRejectZone(ZONE:FindByName("RejectZone"))

-- auto-add map markers when tasks are added
function taskmanager:OnAfterTaskAdded(From,Event,To,Task)
  local task = Task -- Ops.PlayerTask#PLAYERTASK
  local coord = task.Target:GetCoordinate()
  local taskID = string.format("Task ID #%03d | Type: %s | Threat: %d",task.PlayerTaskNr,task.Type,task.Target:GetThreatLevelMax())
  local mark = MARKER:New(coord,taskID)
  mark:ReadWrite()
  mark:ToCoalition(taskmanager.Coalition)
end

-- Function to explode trucks in Kobuleti
function killtrucks()
  local coord = GROUP:FindByName("Kobuleti Trucks"):GetCoordinate()
  GROUP:FindByName("Kobuleti Trucks"):Destroy(true)
  coord:Explosion(10000)
  coord:BigSmokeAndFireLarge()
end

-- Timer for the trucks
local kaboom = TIMER:New(killtrucks)
kaboom:Start(300)



