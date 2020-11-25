---
-- AUFTRAG: Anti-ship
-- 
-- A Hornet and a Viggen group get the mission to destroy the Grisha.
---


-- The target ship.
local navygroup=NAVYGROUP:New("Red Grisha Group")
navygroup:SetDefaultROE(ENUMS.ROE.WeaponHold)
navygroup:Activate()


-- Ship need to be spawned into the game first.
function navygroup:OnAfterSpawned(From, Event, To)

  -- Create an ANTI-SHIP mission.
  local auftrag=AUFTRAG:NewANTISHIP(navygroup:GetGroup(), 1500)
  auftrag:SetMissionAltitude(3000)
  
  -- Assign mission to Hornet pilot.
  local hornet=FLIGHTGROUP:New("F/A-18 Anti-Ship Group")
  hornet:AddMission(auftrag)
  
  -- Assign mission to Viggen pilot.
  local viggen=FLIGHTGROUP:New("Viggen Anti-Ship Group")
  viggen:AddMission(auftrag)

end
    
