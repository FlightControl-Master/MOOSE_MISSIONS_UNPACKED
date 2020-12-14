-- 
-- #MANTIS
-- Moose derived  Modular, Automatic and Network capable Targeting and Interception System.
-- Controls a network of SAM sites. Use detection to switch on the AA site closest to the enemy.
-- Leverage evasiveness from @{Functional.Sead#SEAD}.
-- Leverage attack range setup added by DCS in 11/20.
-- @usage
-- Set up your SAM sites in the mission editor. Name the groups with common prefix like "Red SAM".
-- Set up your EWR system in the mission editor. Name the groups with common prefix like "Red EWR". Can be e.g. AWACS or a combination of AWACS and Search Radars like e.g. EWR 1L13 etc.
-- [optional] Set up your HQ. Can be any group, e.g. a command vehicle.
-- 
-- Start up your MANTIS
-- 
myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR",nil,"red",false)

myredmantis:Start()
