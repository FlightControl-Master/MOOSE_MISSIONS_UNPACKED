
_SETTINGS:SetPlayerMenuOff()

local AmmoDumpEast = STATIC:FindByName("EastAmmoDump")
local AmmoDumpEastCOORD = AmmoDumpEast:GetCoordinate()
local AmmoDumpEastHeight = AmmoDumpEastCOORD:GetLandHeight()

local AmmoDumpWest = STATIC:FindByName("WestAmmoDump")
local AmmoDumpWestCOORD = AmmoDumpWest:GetCoordinate()
local AmmoDumpWestHeight = AmmoDumpWestCOORD:GetLandHeight()

local AmmoDumpSouth = STATIC:FindByName("SouthAmmoDump")
local AmmoDumpSouthCOORD = AmmoDumpSouth:GetCoordinate()
local AmmoDumpSouthHeight = AmmoDumpSouthCOORD:GetLandHeight()

local AmmoDumpNorth = STATIC:FindByName("NorthAmmoDump")
local AmmoDumpNorthCOORD = AmmoDumpNorth:GetCoordinate()
local AmmoDumpNorthHeight = AmmoDumpNorthCOORD:GetLandHeight()

--local AllZones=SET_ZONE:New():FilterOnce()--]]
local Target_1 = ZONE:New("Bridge32")
local T1COORD = Target_1:GetCoordinate()
local T1Height = T1COORD:GetLandHeight()


local Target_2 = ZONE:New("Bridge33")
local T2COORD = Target_2:GetCoordinate()
local T2Height = T2COORD:GetLandHeight()

local Target_3 = ZONE:New("HardenedHanger33")
local T3COORD = Target_3:GetCoordinate()
local T3Height = T3COORD:GetLandHeight()

local Target_4 = ZONE:New("HardenedHanger34")
local T4COORD = Target_4:GetCoordinate()
local T4Height = T4COORD:GetLandHeight()

local function TARGET1(T1LLDMS)
local T1LLDMS = T1COORD:ToStringLLDMS()
local coordN1 = string.sub(T1LLDMS,9,10)
local coordN2 = string.sub(T1LLDMS,13,20)
local coordE1 = string.sub(T1LLDMS,26,27)
local coordE2 = string.sub(T1LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(T1Height)
local T1Heightft = UTILS.Round(Heightft)
MESSAGE:New("Bridge 32".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T1Heightft.." ft"), 50):ToAll()
return T1LLDMS
end

local function TARGET2(T2LLDMS)
local T2LLDMS = T2COORD:ToStringLLDMS()
local coordN1 = string.sub(T2LLDMS,9,10)
local coordN2 = string.sub(T2LLDMS,13,20)
local coordE1 = string.sub(T2LLDMS,26,27)
local coordE2 = string.sub(T2LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(T2Height)
local T2Heightft = UTILS.Round(Heightft)
MESSAGE:New("Bridge 33".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T2Heightft.." ft"), 50):ToAll()
return T2LLDMS
end

local function TARGET3(T3LLDMS)
local T3LLDMS = T3COORD:ToStringLLDMS()
local coordN1 = string.sub(T3LLDMS,9,10)
local coordN2 = string.sub(T3LLDMS,13,20)
local coordE1 = string.sub(T3LLDMS,26,27)
local coordE2 = string.sub(T3LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(T3Height)
local T3Heightft = UTILS.Round(Heightft)
MESSAGE:New("HardenedHanger 33".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T3Heightft.." ft"), 50):ToAll()
return T3LLDMS
end

local function TARGET4(T4LLDMS)
local T4LLDMS = T4COORD:ToStringLLDMS()
local coordN1 = string.sub(T4LLDMS,9,10)
local coordN2 = string.sub(T4LLDMS,13,20)
local coordE1 = string.sub(T4LLDMS,26,27)
local coordE2 = string.sub(T4LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(T4Height)
local T4Heightft = UTILS.Round(Heightft)
MESSAGE:New("HardenedHanger 34".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T4Heightft.." ft"), 50):ToAll()
return T4LLDMS
end

local function TARGET5(T1LLDMS)
local T1LLDMS = AmmoDumpEastCOORD:ToStringLLDMS()
local coordN1 = string.sub(T1LLDMS,9,10)
local coordN2 = string.sub(T1LLDMS,13,20)
local coordE1 = string.sub(T1LLDMS,26,27)
local coordE2 = string.sub(T1LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(AmmoDumpEastHeight)
local T1Heightft = UTILS.Round(Heightft)
MESSAGE:New("EastAmmoDump".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T1Heightft.." ft"), 50):ToAll()
return T1LLDMS
end

local function TARGET6(T2LLDMS)
local T2LLDMS = AmmoDumpWestCOORD:ToStringLLDMS()
local coordN1 = string.sub(T2LLDMS,9,10)
local coordN2 = string.sub(T2LLDMS,13,20)
local coordE1 = string.sub(T2LLDMS,26,27)
local coordE2 = string.sub(T2LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(AmmoDumpWestHeight)
local T2Heightft = UTILS.Round(Heightft)
MESSAGE:New("WestAmmoDump".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T2Heightft.." ft"), 50):ToAll()
return T2LLDMS
end

local function TARGET7(T3LLDMS)
local T3LLDMS = AmmoDumpSouthCOORD:ToStringLLDMS()
local coordN1 = string.sub(T3LLDMS,9,10)
local coordN2 = string.sub(T3LLDMS,13,20)
local coordE1 = string.sub(T3LLDMS,26,27)
local coordE2 = string.sub(T3LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(AmmoDumpSouthHeight)
local T3Heightft = UTILS.Round(Heightft)
MESSAGE:New("SouthAmmoDump".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T3Heightft.." ft"), 50):ToAll()
return T3LLDMS
end

local function TARGET8(T4LLDMS)
local T4LLDMS = AmmoDumpNorthCOORD:ToStringLLDMS()
local coordN1 = string.sub(T4LLDMS,9,10)
local coordN2 = string.sub(T4LLDMS,13,20)
local coordE1 = string.sub(T4LLDMS,26,27)
local coordE2 = string.sub(T4LLDMS,30,37)
local Heightft = UTILS.MetersToFeet(AmmoDumpNorthHeight)
local T4Heightft = UTILS.Round(Heightft)
MESSAGE:New("NorthAmmoDump".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T4Heightft.." ft"), 50):ToAll()
return T4LLDMS
end

TopMenu1 = MENU_MISSION:New( "TARGETCOORDS" )

BridgeMenu = MENU_MISSION:New( "BRIDGE",TopMenu1 )
AmmoMenu = MENU_MISSION:New( "AMMO DUMP",TopMenu1 )
ShelterMenu = MENU_MISSION:New( "HARDENED SHELTER",TopMenu1 )
Menu1 = MENU_MISSION_COMMAND:New("Bridge 32",BridgeMenu, TARGET1)
Menu2 = MENU_MISSION_COMMAND:New("Bridge 33", BridgeMenu, TARGET2)
Menu3 = MENU_MISSION_COMMAND:New("HardenedHanger 33", ShelterMenu, TARGET3)
Menu4 = MENU_MISSION_COMMAND:New("HardenedHanger 34", ShelterMenu, TARGET4)
Menu5 = MENU_MISSION_COMMAND:New("AmmoDumpEast", AmmoMenu, TARGET5)
Menu6 = MENU_MISSION_COMMAND:New("AmmoDumpWest", AmmoMenu, TARGET6)
Menu7 = MENU_MISSION_COMMAND:New("AmmoDumpSouth", AmmoMenu, TARGET7)
Menu8 = MENU_MISSION_COMMAND:New("AmmoDumpNorth", AmmoMenu, TARGET8)
