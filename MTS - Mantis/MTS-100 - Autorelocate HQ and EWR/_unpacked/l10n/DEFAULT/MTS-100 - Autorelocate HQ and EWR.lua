-------------------------------------------------------------------------
-- MTS-100 - MANTIS - Autorelocate HQ and EWR
-------------------------------------------------------------------------
-- Documentation
-- 
-- MANTIS: https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Functional.Mantis.html
-- 
-- Note: As of Dec/20, MANTIS is WIP. Needs a recent build of Moose.lua > 16 Dec 20
--        for CONTROLLABLE:RelocateGroundRandomInRadius() to be available
--        https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/CONTROLLABLE.RelocateGroundRandomInRadius.html
-------------------------------------------------------------------------
-- Observe a set of SAM sites being attacked by F18 SEAD, A10 and Helicopters. 
-- HQ and EWR will randomly relocate between 30 and 60 mins
-- The SA 11 Radar will only relocate if not detected units are in range
-------------------------------------------------------------------------
-- Date: 17 Dec 2020
-------------------------------------------------------------------------

myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR","Red HQ","red",false)
myredmantis:SetAutoRelocate(true, true) -- make HQ and EWR relocatable, if they are actually mobile in DCS!
myredmantis:Debug(true)
myredmantis.verbose = true
myredmantis:Start()