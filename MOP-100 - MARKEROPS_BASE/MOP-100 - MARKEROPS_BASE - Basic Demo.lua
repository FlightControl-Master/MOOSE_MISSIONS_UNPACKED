-------------------------------------------------------------------------
-- MOP-100 - MARKEROPS_BASE - Basic Demo
-------------------------------------------------------------------------
-- Documentation
-- 
-- MARKEROPS_BASE: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Core.MarkerOps_Base.html
-- 
-------------------------------------------------------------------------
-- On the F10, call a tanker to start from the carrier. It will fly to
-- an initial zone. Set a marker on the F10 map with keyword "TankerDemo".
-- The Tanker will fly there. Set a marker on the F10 map with keywords 
-- "TankerDemo RTB". The tanke will RTB to the carrier.
-------------------------------------------------------------------------
-- Date: May 2021
-------------------------------------------------------------------------

-- globals
mytanker = nil
tankergroup = nil
TankerAuftrag = nil

function menucalltanker()

  if not mytanker then
    -- new MARKEROPS_BASE object
    mytanker = MARKEROPS_BASE:New("TankerDemo",{"RTB"}) -- Core.MarkerOps_Base#MARKEROPS_BASE
    -- start FlightGroup
    tankergroup = FLIGHTGROUP:New("Tanker")
    tankergroup:SetHomebase(AIRBASE:FindByName("Truman"))
    tankergroup:SetDefaultRadio(245,"AM",false)
    tankergroup:SetDespawnAfterLanding()
    tankergroup:SwitchTACAN(45, "TKR", 1, "X")
    tankergroup:SetDefaultCallsign(CALLSIGN.Tanker.Texaco,1)
    -- Mission
    local InitialHold = ZONE:New("Initial Hold"):GetCoordinate()
    TankerAuftrag = AUFTRAG:NewTANKER(InitialHold,18000,UTILS.KnotsToAltKIAS(220,18000),90,20,0)
    TankerAuftrag:SetMissionRange(500)
    tankergroup:AddMission(TankerAuftrag)
  else
    local status = tankergroup:GetState()
    local m = MESSAGE:New(string.format("Tanker %s ops in status: %s", mytanker.Tag, status),10,"Info",true):ToAll()
  end
  
  -- Handler function
  local function Handler(Keywords,Coord)
  
    local MustRTB = false
    for _,_word in pairs (Keywords) do
      if string.lower(_word) == "rtb" then
        MustRTB = true
      end
    end
    
    -- cancel current Auftrag
    TankerAuftrag:Cancel()
    
    -- check if we need to RTB
    if MustRTB then
      tankergroup:RTB(AIRBASE:FindByName("Truman"))
    else
      -- no, fly to coordinate of marker
      local auftrag = AUFTRAG:NewTANKER(Coord,18000,UTILS.KnotsToAltKIAS(220,18000),90,20,0)
      auftrag:SetMissionRange(500)
      tankergroup:AddMission(auftrag)
      TankerAuftrag = auftrag
    end
  end
  
  -- Event functions
  function mytanker:OnAfterMarkAdded(From,Event,To,Text,Keywords,Coord)
    local m = MESSAGE:New(string.format("Tanker %s Mark Added.", self.Tag),10,"Info",true):ToAll()
    Handler(Keywords,Coord)
  end
  
  function mytanker:OnAfterMarkChanged(From,Event,To,Text,Keywords,Coord)
    local m = MESSAGE:New(string.format("Tanker %s Mark Changed.", self.Tag),10,"Info",true):ToAll()
    Handler(Keywords,Coord)
  end
  
  function mytanker:OnAfterMarkDeleted(From,Event,To)
    local m = MESSAGE:New(string.format("Tanker %s Mark Deleted.", self.Tag),10,"Info",true):ToAll()
  end
end

MenuTop = MENU_COALITION:New( coalition.side.BLUE,"Call Tanker")
MenuTanker = MENU_COALITION_COMMAND:New(coalition.side.BLUE,"Start Tanker",MenuTop,menucalltanker)
