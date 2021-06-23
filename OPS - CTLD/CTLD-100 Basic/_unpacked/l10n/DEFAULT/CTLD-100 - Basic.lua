-------------------------------------------------------------------------
-- CTLD 100 - Caucasus - Test Mission
-------------------------------------------------------------------------
-- Documentation
-- 
-- CTLD: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Ops.CTLD.html
-- 
-- Note: As of today, Ops.CTLD.lua is WIP. You need a develop branch Moose.lua => 23 Jun 2021 for this to work.

-------------------------------------------------------------------------
-- Join a Helicopter. Use the F10 menu to request crates and/or troops. 
-- Fly over to the drop zone at the far end of the airport and unload.
-- Use the F10 menu to build vehicles out of crates.
-------------------------------------------------------------------------
-- Date: 23 June 2021
-------------------------------------------------------------------------


_SETTINGS:SetPlayerMenuOff()

local my_ctld = CTLD:New(coalition.side.BLUE,{"Helicargo"},"Lufttransportbrigade I")
my_ctld.forcehoverload = false
my_ctld:__Start(5)

-- generate generically loadable stuff
my_ctld:AddTroopsCargo("Anti-Tank Small",{"ATS"},CTLD_CARGO.Enum.TROOPS,3)
my_ctld:AddTroopsCargo("Anti-Air",{"AA","AA2"},CTLD_CARGO.Enum.TROOPS,4)
my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2)
my_ctld:AddCratesCargo("Forward Ops Base",{"FOB"},CTLD_CARGO.Enum.FOB,4)

-- generate zone types
my_ctld:AddCTLDZone("Loadzone",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true) -- Note: since there are no blue flares, this will be a white flare when requested.
my_ctld:AddCTLDZone("Dropzone",CTLD.CargoZoneType.DROP,SMOKECOLOR.Red,true,true)
my_ctld:AddCTLDZone("Movezone",CTLD.CargoZoneType.MOVE,SMOKECOLOR.Orange,false,false)
my_ctld:AddCTLDZone("Movezone2",CTLD.CargoZoneType.MOVE,SMOKECOLOR.White,false,true)

-- update unit capabilities for testing
my_ctld:UnitCapabilities("SA342L", true, true, 8, 8)