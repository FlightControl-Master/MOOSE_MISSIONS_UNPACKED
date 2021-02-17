-------------------------------------------------------------------------
-- SRD-120 - SHORAD - Integrate with Detection
-------------------------------------------------------------------------
-- Documentation
-- 
-- SHORAD: https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Functional.Shorad.html
-- 
-- Note: As of Feb/21, SHORAD is WIP. Needs a recent build of Moose.lua => 2.5.3
-- 
-------------------------------------------------------------------------
-- Observe a set Red High-Value-Target (HVT) being attacked by Blue CAS.
-- Red SHORAD systems will be switched on for 10 minutes to defend against
-- HARMSs and AGMs.
-------------------------------------------------------------------------
-- Date: 17 Feb 2021
-------------------------------------------------------------------------

local SamSet = SET_GROUP:New():FilterPrefixes("Red HVT"):FilterCoalitions("red"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
myshorad = SHORAD:New("RedShorad", "Red SHORAD", SamSet, 22000, 600, "red")
myshorad:SwitchDebug(true)

local dectset = SET_GROUP:New():FilterPrefixes("Red EWR"):FilterCoalitions("red"):FilterStart()
local detection = DETECTION_AREAS:New(dectset,1000)
detection:SetRefreshTimeInterval(15)
detection:SetAcceptZones(ZONE:New("Red HVT Zone")) -- defense zone around our HVT
detection:Start()

-- wake up SHORAD when we detect an attacker
function detection:OnAfterDetected(From,Event,To,Units)
  for _,_unit in pairs (Units) do
    local text = string.format("Unit detected: %s",_unit:GetName())
    local m = MESSAGE:New(text,10,"Info"):ToAll()   
  end
  myshorad:WakeUpShorad("Red SHORAD", 25000, 600)
end