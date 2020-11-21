-- This code pulls the Coordinates for JDAM use, and using the Menu format loads them in game using message system.
-- Mission created by Saint185
-- 2020-11-21


_SETTINGS:SetPlayerMenuOff()


local AmmoDumpEast = STATIC:FindByName("EastAmmoDump")--Finds the static called EastAmmoDump from the Mission Editor
local AmmoDumpEastCOORD = AmmoDumpEast:GetCoordinate()--contains the LLDMS coordinates for JDAM
local AmmoDumpEastHeight = AmmoDumpEastCOORD:GetLandHeight()--gets the land height Bridge 32 from T1COORD

local AmmoDumpWest = STATIC:FindByName("WestAmmoDump")
local AmmoDumpWestCOORD = AmmoDumpWest:GetCoordinate()
local AmmoDumpWestHeight = AmmoDumpWestCOORD:GetLandHeight()

local AmmoDumpSouth = STATIC:FindByName("SouthAmmoDump")
local AmmoDumpSouthCOORD = AmmoDumpSouth:GetCoordinate()
local AmmoDumpSouthHeight = AmmoDumpSouthCOORD:GetLandHeight()

local AmmoDumpNorth = STATIC:FindByName("NorthAmmoDump")
local AmmoDumpNorthCOORD = AmmoDumpNorth:GetCoordinate()
local AmmoDumpNorthHeight = AmmoDumpNorthCOORD:GetLandHeight()


local Target_1 = ZONE:New("Bridge32")--Zone assigned to Bridge 32 in ME
local T1COORD = Target_1:GetCoordinate()--contains the LLDMS coordinates for JDAM
local T1Height = T1COORD:GetLandHeight()--gets the land height Bridge 32 from T1COORD


local Target_2 = ZONE:New("Bridge33")
local T2COORD = Target_2:GetCoordinate()
local T2Height = T2COORD:GetLandHeight()

local Target_3 = ZONE:New("HardenedHanger33")
local T3COORD = Target_3:GetCoordinate()
local T3Height = T3COORD:GetLandHeight()

local Target_4 = ZONE:New("HardenedHanger34")
local T4COORD = Target_4:GetCoordinate()
local T4Height = T4COORD:GetLandHeight()

-- Gets LLDMS coord from Target 1(Bridge32p) using T1COORD:ToStringLLDMS() then assigns sections of the string to coordXy
local function TARGET1(T1LLDMS)
local T1LLDMS = T1COORD:ToStringLLDMS()
local coordN1 = string.sub(T1LLDMS,9,10)--extracts a block of text from String T4LLDMS starting at location 9 ending at location 10
local coordN2 = string.sub(T1LLDMS,13,20)--extracts a block of text from String T4LLDMS starting at location 13 ending at location 20
local coordE1 = string.sub(T1LLDMS,26,27)--extracts a block of text from String T4LLDMS starting at location 26 ending at location 27
local coordE2 = string.sub(T1LLDMS,30,37)--extracts a block of text from String T4LLDMS starting at location 30 ending at location 37
local Heightft = UTILS.MetersToFeet(T1Height)--coverts height in meters to feet
local T1Heightft = UTILS.Round(Heightft)-- rounds the value to a whole number
MESSAGE:New("Bridge 32".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T1Heightft.." ft"), 50):ToAll()
return T1LLDMS--returns the argument for function TARGET1
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
local coordN1 = string.sub(T4LLDMS,9,10)--extracts text from String T4LLDMS at location 9 to 10
local coordN2 = string.sub(T4LLDMS,13,20)--extracts text from String T4LLDMS at location 13 to 20
local coordE1 = string.sub(T4LLDMS,26,27)--extracts text from String T4LLDMS at location 26 to 27
local coordE2 = string.sub(T4LLDMS,30,37)--extracts text from String T4LLDMS at location 30 to 37
local Heightft = UTILS.MetersToFeet(AmmoDumpNorthHeight)--coverts height in meters to feet
local T4Heightft = UTILS.Round(Heightft)-- rounds the value to a whole number
MESSAGE:New("NorthAmmoDump".."\n".. ("N"..coordN1.."'"..coordN2.."\n".."E"..coordE1.."'"..coordE2.."\n".."ALT "..T4Heightft.." ft"), 50):ToAll()
return T4LLDMS
end

--Coordinates Menu
Level1 = MENU_MISSION:New( "TARGETCOORDS" )--Top level Menu all targets are assigned to this master menu
Level2_1 = MENU_MISSION:New( "BRIDGE",Level1 )--Level 2 Contains Target groups
Level2_2 = MENU_MISSION:New( "AMMO DUMP",Level1 )
Level2_3 = MENU_MISSION:New( "HARDENED SHELTER",Level1 )
Menu1 = MENU_MISSION_COMMAND:New("Bridge 32",Level2_1, TARGET1)--Level 3 contains Target group coordinates
Menu2 = MENU_MISSION_COMMAND:New("Bridge 33", Level2_1, TARGET2)
Menu3 = MENU_MISSION_COMMAND:New("HardenedHanger 33", Level2_3, TARGET3)--text displayed HardenedHanger 33, select Menu position, function to call(local function TARGET3(T3LLDMS))
Menu4 = MENU_MISSION_COMMAND:New("HardenedHanger 34", Level2_3, TARGET4)
Menu5 = MENU_MISSION_COMMAND:New("AmmoDumpEast", Level2_2, TARGET5)
Menu6 = MENU_MISSION_COMMAND:New("AmmoDumpWest", Level2_2, TARGET6)
Menu7 = MENU_MISSION_COMMAND:New("AmmoDumpSouth", Level2_2, TARGET7)
Menu8 = MENU_MISSION_COMMAND:New("AmmoDumpNorth", Level2_2, TARGET8)
