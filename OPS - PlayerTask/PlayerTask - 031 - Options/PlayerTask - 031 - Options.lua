-------------------------------------------------------------------------
-- PlayerTask 031 - Caucasus - Test Mission with SRS and Options
-------------------------------------------------------------------------
-- Documentation
-- 
-- PLAYERTASK: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.PlayerTask.html
-- 
-------------------------------------------------------------------------
-- Join the game master slot initially, and then a plane slot after a few
-- seconds, to allow event capturing to start. 
-- 
-- Tasking is made available over the F10 Menu. 
-- Listen to AM 130 or 255 on SRS for messages.
-- An additional info menu is available to review tasks before joining.
-- 
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

-- Set the menu to be called Eagle Eye
taskmanager:SetMenuName("Spectre")

-- Set the Info Task menu to be available
taskmanager:EnableTaskInfoMenu()

-- Menu options:
-- Don't show the nfo Task menu when a player has joined a task.
-- Limit menu entries to top-3 per category
-- Hold menu refresh at least 45 seconds, when player has no task
taskmanager:SetMenuOptions(false,3,45)

-- Allow option to request flash directions (on a per-player basis)
taskmanager:SetAllowFlashDirection(true)

-- Set option to use the full custom player callsign after the # on the group name.
-- If not available, call out the call sign and major flight number only.
taskmanager:SetCallSignOptions(true,true)

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

-- Function to explode trucks in Kobuleti
function killtrucks()
  local coord = GROUP:FindByName("Kobuleti Trucks"):GetCoordinate()
  GROUP:FindByName("Kobuleti Trucks"):Destroy(true)
  coord:Explosion(10000)
  coord:BigSmokeAndFireLarge()
end

-- Timer for the trucks
local kaboom = TIMER:New(killtrucks)
kaboom:Start(900)



