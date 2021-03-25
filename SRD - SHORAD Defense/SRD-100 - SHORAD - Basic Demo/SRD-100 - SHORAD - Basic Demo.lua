-------------------------------------------------------------------------
-- SRD-100 - SHORAD - Basic Demo
-------------------------------------------------------------------------
-- Documentation
-- 
-- SHORAD: https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Functional.Shorad.html
-- 
-- Note: As of Feb/21, SHORAD is WIP. Needs a recent build of Moose.lua => 2.5.3
-- 
-------------------------------------------------------------------------
-- Observe a set of Red SAM sites being attacked by Blue SEAD and Helicopters.
-- Red SHORAD systems will be switched on for 10 minutes to defend against
-- HARMSs and AGMs.
-- Red SAMs will try to evade HARMs fired at them.
-------------------------------------------------------------------------
-- Date: 16 Feb 2021, Updated 25 Mar 2021
-------------------------------------------------------------------------

local SamSet = SET_GROUP:New():FilterPrefixes("Blue SAM"):FilterCoalitions("blue"):FilterStart()
-- usage: SHORAD:New(name, prefix, samset, radius, time, coalition)
myshorad = SHORAD:New("BlueShorad", "Blue SHORAD", SamSet, 22000, 600, "blue")
myshorad:SwitchDebug(true)

-- optional - make SAMs evasive (that is, if they can move)
mysead = SEAD:New("Blue SAM")