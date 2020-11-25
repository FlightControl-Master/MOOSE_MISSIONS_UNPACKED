---
-- AUFTRAG: Rescue Helo
---

-- Name of the carrier unit.
local CarrierName="USS Stennis"

local navygroup=NAVYGROUP:New("Stennis Group")
navygroup:Activate()

function navygroup:OnAfterSpawned()

  local function spawned(group)
    local flightgroup=FLIGHTGROUP:New(group)
    local mission=AUFTRAG:NewRESCUEHELO(UNIT:FindByName(CarrierName))
    flightgroup:AddMission(mission)
  end
  
  local spawn=SPAWN:New("SH-60 Group")
  spawn:OnSpawnGroup(spawned)
  spawn:SpawnAtAirbase(AIRBASE:FindByName(CarrierName))

end