-------------------------------------------------------------------------
-- PlayerTask 030 - Caucasus - Test Mission with precision (laser-guided) bombing
-------------------------------------------------------------------------
-- Documentation
-- 
-- PLAYERTASK: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.PlayerTask.html
-- 
-------------------------------------------------------------------------
-- Join the game master slot initially, and then a plane slot after a few
-- seconds, to allow event capturing to start. Tasking is made available
-- over the F10 Menu. 
-- 
-- Join one of the precision bombing tasks. The A10
-- will fly towards and circle over the target and start to lase it on
-- code 1688. Use a GBU to neutralize the target.
-- 
-- Listen to AM 130 or 255 on SRS for messages.
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

-- Set up using SRS
local hereSRSPath = "C:\\Program Files\\DCS-SimpleRadio-Standalone" -- location of the SRS installation folder, not the double \
local hereSRSPort = 5002 -- SRS server listening to port 5002

-- Set controller to use radio 130 and 255 AM, female voice, GB english, use "Microsoft Hazel" as voice pack (must be installed on your machine), volume 70%.
taskmanager:SetSRS({130,255},{radio.modulation.AM,radio.modulation.AM},hereSRSPath,"female","en-GB",hereSRSPort,"Microsoft Hazel Desktop",0.7)

-- Controller will announce itself after 60 seconds, on these two broadcast frequencies, when a new player joins
taskmanager:SetSRSBroadcast({127.5,305},{radio.modulation.AM,radio.modulation.AM})

-- Set a blacklist for tasks, skip SEAD tasks in this case
taskmanager:SetTaskBlackList({AUFTRAG.Type.SEAD})

-- Add a lasing unit, that will lase with code 1688. In our case that is a F10 Warthog.
-- Create a FLIGHTGROUP object from the template and activate it
local FlightGroup = FLIGHTGROUP:New("LasingUnit")
FlightGroup:Activate()
-- Enable laser guided bombing
taskmanager:EnablePrecisionBombing(FlightGroup,1688)

-- Manually add a COORDINATE as a target - in this case this will generate bombing tasks
taskmanager:AddTarget(GROUP:FindByName("Scout Coordinate"):GetCoordinate())

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

