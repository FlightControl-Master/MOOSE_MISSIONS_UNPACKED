  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  --    __ __        ___                 _        __                 __     _____ ______ _____                                            
  --   / //_/       /   |   _____ _____ (_)_____ / /_ ____ _ ____   / /_   / ___//_  __// ___/                                            
  --  / ,<  ______ / /| |  / ___// ___// // ___// __// __ `// __ \ / __/   \__ \  / /   \__ \                                             
  -- / /| |/_____// ___ | (__  )(__  )/ /(__  )/ /_ / /_/ // / / // /_    ___/ / / /   ___/ /                                             
  --/_/_|_|_  _  /_/  |_|/____//____//_//____/_\__/_\__,_//_/ /_/ \__/   /____/ /_/   /____/       __     _____              _         __ 
  --  / ___/ (_)____ ___   ____   / /___     /_  __/_____ ____ _ ____   _____ ____   ____   _____ / /_   / ___/ _____ _____ (_)____   / /_
  --  \__ \ / // __ `__ \ / __ \ / // _ \     / /  / ___// __ `// __ \ / ___// __ \ / __ \ / ___// __/   \__ \ / ___// ___// // __ \ / __/
  -- ___/ // // / / / / // /_/ // //  __/    / /  / /   / /_/ // / / /(__  )/ /_/ // /_/ // /   / /_    ___/ // /__ / /   / // /_/ // /_  
  --/____//_//_/ /_/ /_// .___//_/ \___/    /_/  /_/    \__,_//_/ /_//____// .___/ \____//_/    \__/   /____/ \___//_/   /_// .___/ \__/  
  --                   /_/                                                /_/                                              /_/            
  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  --
  -------------------------------------------------------------------------------
  ---------------------------------  DEV NOTES  ---------------------------------
  -------------------------------------------------------------------------------
  -- FIXES 
  -- TODO manage ground carriers somehow (menu refresh and cargo validation)
  -- 
  -- 
  -- 
  -- FUTURE FEATURES
  -- TODO board troops that aren't currently alive in mission - necessary to make possible to board troops on a ship
  -- TODO Spawn cargos during mission - scheduled spawn?
  -- TODO Validate cargo before boarding (also)
  -- TODO 
  -- 

  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  --   __  __                     __  ___                             __
  --  / / / /_____ ___   _____   /  |/  /____ _ ____   __  __ ____ _ / /
  -- / / / // ___// _ \ / ___/  / /|_/ // __ `// __ \ / / / // __ `// / 
  --/ /_/ /(__  )/  __// /     / /  / // /_/ // / / // /_/ // /_/ // /  
  --\____//____/ \___//_/     /_/  /_/ \__,_//_/ /_/ \__,_/ \__,_//_/            
  --                                                                                                       
  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------
  ----------------------------- WHAT K-ASS-STS IS? ------------------------------ 
  -------------------------------------------------------------------------------
  -- K-Assistant-Simple Transport Script aims to Assist the Mission Designers in the implementation of a Simple, Flexible and Realistic cargo management system based on MOOOSE Framework.
  -- 
  -- Simple - because it can be easily integrated into your missions, moreover it is also simple to use in game as the menus and functions available for the players are few and easy to use. 
  -- 
  -- Flessible - because it tries to give way to mission designers to build their missions without limiting too much imagination by regulating every action. 
  --             Potentially with this script you can also load on your helicopter static objects not defined as "cargos" in DCS, for example a building or a cow... 
  --             It is up to the mission designer to decide what should be done and what should not be done.
  -- 
  -- Realistic - although the script leaves the mission designers free to use their imagination, at the same time it binds them to a realistic approach as, 
  --             thanks to the API released in 2020 by Eagle Dynamics, for each object loaded into your helicopter it will be simulated the addition of the mass relative to the cargo itself.
  --             Pilots will now need to deal with cargo mass!
  -- 
  -------------------------------------------------------------------------------
  ------------------------------ SCRIPT SETTINGS --------------------------------
  -------------------------------------------------------------------------------
  -- The script can be configured to better meet the needs of the Mission Designer.
  -- The configurations must be made by modifying the parameters contained in the sts_Settings table that you can find immediately after this section of instructions.
  -- See sts_Settings table for more informations.
  --
  -------------------------------------------------------------------------------
  ------------------------- TAGS and LOADABLE OBJECTS ---------------------------
  -------------------------------------------------------------------------------
  -- TAGS : are needed to identify elemensts within the script, must be in groups, statics and zones defined in ME (Mission Editor)
  -- Eg. 
  -- sts_Settings.CarrierTAG = "TRS" identify carriers groups that will transport cargos, all groups whose name contains "TRS" will be considered carriers.
  -- sts_Settings.CargoGroupsTAG = "GRP" identify groups that can be boarded to carriers so, all groups whose name contains "GRP" will be considered CARGO_GROUPs.
  -- sts_Settings.CargoCrateTAG = "CRT" identify static objects that can be loaded to carriers as CRATES, all static objects whose name contains "CRT" will be considered CARGO_CRATEs.
  --
  -- TAGs can identify CARGO_GROUPS, CARGO_CRATES, CARRIERS and ZONES (for more details regarding Zones please see ZONES section).
  -- 
  -- LOADABLE OBJECTS : 
  -- CARGO_GROUPS - By putting the TAG that identifies the loadable Groups ("GRP" by default) in the name of the group defined by Mission Editor, this will then be boardable in game.
  --                You simply have to land your helicopter near the group and use the radio menus under F10 - Other to board them.
  --                Group mass will be calculated and added to carrier mass.
  --                 
  -- CARGO_CRATES - By putting the TAG that identifies the loadable static as Crates ("CRT" by default) in the name of the group defined by Mission Editor, this will then be loadable in game.
  --                You simply have to land your helicopter near the crate and use the radio menus under F10 - Other to load it.
  --                
  --                BE AWARE : not all static objects have a defined mass!
  --                For static objects belonging to the "Cargos" category, the mass set in the Mission Editor will be considered.
  --                Static objects belonging to other categories (such as our beloved cows) do not have a mass that can be set in the Mission Editor, 
  --                for these objects a mass equal to the value defined in sts_Settings.DefaultStaticCargoMass (default is 666 kilograms) will always be considered.
  -- 
  -- CARGO VALIDATION if sts_Settings.ValidateCargo is true the cargo will be validated after being loaded.
  --                  If the loaded weight exceeds the maximum load capacity of the carrier the cargo will be unloaded immediately.
  -- 
  -------------------------------------------------------------------------------
  ----------------------------------- ZONES ------------------------------------- 
  -------------------------------------------------------------------------------
  -- The script involves the use of Zones (trigger zones defined in mission editor) to allow players to access some useful functions.
  -- Also in this case, to identify the various types of zone, the script uses TAGs.
  -- 
  -- WAY POINT ZONES (WPZones) - WPZones are zones that can be defined by Mission Editor by inserting the TAG sts_settings.WPZoneTAG ("WPZ" by default) in the zone name.
  --                             When a CARGO_GROUP is unboarded inside a WPZone, after about 40 seconds it will head towards the center of the zone. 
  --                             (Ideal for an assault)
  --                             
  -- PATROL ZONES (PTZones) - PTZones are zones that can be defined by Mission Editor by inserting the TAG sts_settings.PTZoneTAG ("PTZ" by default) in the zone name.
  --                          When a CARGO_GROUP is unboarded inside a PTZones, after about 40 seconds it will start patrolling endlessly and randomly the zone.
  --                          (Ideal for defending an area)
  --                          
  --                          
  --                          
  -- PATROL ZONES INSIDE WAY POINT ZONES - If a PT Zone is inside WP Zone after troops are unboarded inside they will head to the center of WP Zone.
  --                                       Once they'll reach the center of WP Zone they will search for PT Zones, if they find one or more, they will start patrolling.  
  --                          
  --                          
  --                          
  -- SMOKE ZONES (SMKZones) - SMKZones are zones that can be defined by Mission Editor by inserting the TAG sts_settings.SMKZoneTAG ("SMK" by default) in the zone name.
  --                          When a Smoke Zone is defined the center of it will be smoked endlessly after mission start.                       
  -- 
  -------------------------------------------------------------------------------
  ---------------------------- IN GAME ZONE CREATION ----------------------------
  -------------------------------------------------------------------------------
  -- In order to allow greater dynamism in the mission, the Zones described above can also be created directly in the game by using F10 Map Markers.
  -- 
  -- WAY POINT ZONES (WPZones) - Add a Marker in F10 Map, edit the marker text by inserting the following pattern: "#ZoneTAG ... (RadiusInMeters) ..."
  --                             Click outside the text field to apply, the zone will be created.
  -- 
  -- PATROL ZONES (PTZones) - Add a Marker in F10 Map, edit the marker text by inserting the following pattern: "#ZoneTAG ... (RadiusInMeters) ..."
  --                          Click outside the text field to apply, the zone will be created.
  --                          
  -- SMOKE ZONES (SMKZones) - Add a Marker in F10 Map, edit the marker text by inserting the following pattern: "#ZoneTAG ..."
  --                          Click outside the text field to apply, the zone will be created.
  --                          
  -- Some examples:
  -- WPZone Mark Text : #WPZ Sochi (3000)  -- will create a 3000 meter diameter WPZone at the marker position. 
  -- PTZone Mark Text : #PTZ Defend-1 (1740)  -- will create a 1750 meter diameter PTZone at the marker position. 
  -- SMKZone Mark Text : #SMK LZ-1  -- will create a smoke that will last for 5 minutes at the marker position. 
  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- Mission Created By Kappa 
  -- Using Moose by the DCS Moose Community
  -- Prepared for github by Wingthor
  -- Date 2020-12-15

  -- ************************************************************************
  -- *****************************  SETTINGS  *******************************
  -- ************************************************************************
  
sts_Settings = {
  ------------------------------------------------------------ GENERAL SETTINGS AND DEBUG ------------------------------------------------------------
  Debug = false, -- Enable debug messages during mission
  DebugTrace = false, -- Enable debug tracing on dcs.log
  RefreshTime = 20, -- Set refresh time in seconds
  ------------------------------------------------------------------ CARGO SETTINGS ------------------------------------------------------------------
  LoadRadius = 150, -- The radius till Cargo can be loaded into the carrier
  NearRadius = 25, -- The radius in meters when the cargo will board the Carrier (25m have better performance for routing of booardable groups)
  RespawnOnDestroyed = true, -- if true, destroyed cargos will be respawned at the initial position.
  ValidateCargo = true, -- If true, will validate cargo before boarding if too heavy it will be unloaded 
  OverloadPercentage = 37, -- Defines the helicopter cargo overload limit (30% default setting - allow to load about 1000Kg in Huey and 2800Kg in Mi-8)
  DefaultStaticCargoMass = 666, -- Defines the default cargo mass for static objects that are massless (all statics exept thoose in "Cargo" category, yes, cows also...)
  ----------------------------------------------------- CARRIERS AND LOADABLE SETTNGS AND TAGS -------------------------------------------------------
  CargoGroupsTAG = "GRP", -- Define TAG needed to identify CARGO_GROUPs - it must be in the group name defined in ME 
  CargoCrateTAG = "CRT", -- Define TAG needed to identify CARGO_CRATEs - it must be in the group name defined in ME
  CarrierTAG = "TRS", -- Define TAG needed to identify Carrier Groups - it must be in the group name defined in ME 
  ------------------------------------------------------------- ZONES SETTNGS AND TAGS ----------------------------------------------------------------
  WPZoneTAG = "WPZ", -- Define TAG needed to identify WP Zones - it must be in the zone name defined in ME or in F10 Mark on Map (#WPZ)
  PTZoneTAG = "PTZ", -- Define TAG needed to identify PT Zones - it must be in the zone name defined in ME or in F10 Mark on Map (#PTZ)
  SMKZoneTAG = "SMK", -- Define TAG needed to identify SMK Zones - it must be in the zone name defined in ME or in F10 Mark on Map (#SMK)
  ZonesMarkOnMap = true, -- If true, WP zones will be marked on F10 map
}

-- disable MOOSE settings menu
_SETTINGS:SetPlayerMenuOff()

-- LOG TRACING
if sts_Settings.DebugTrace then BASE:TraceAll(true) end -- debug

  -- ************************************************************************
  -- *******************  DATA COLLECTION AND UTILITY   *********************
  -- ************************************************************************

--Carrier set - this groups will transport things
TransportSets = {
  BLUE = SET_GROUP:New():FilterCoalitions("blue"):FilterActive():FilterPrefixes("TRS"):FilterStart(),
  RED = SET_GROUP:New():FilterCoalitions("red"):FilterActive():FilterPrefixes("TRS"):FilterStart(),
  NEUTRAL = SET_GROUP:New():FilterCoalitions("neutral"):FilterActive():FilterPrefixes("TRS"):FilterStart()
}

--SetS of zones used by the script 
ZoneSets = {
  TGTZONES = SET_ZONE:New():FilterPrefixes(sts_Settings.WPZoneTAG):FilterPrefixes(sts_Settings.PTZoneTAG):FilterStart(), --This zones will be the route target for cargo groups that are unloaded in this zones
  SMKZONES = SET_ZONE:New():FilterPrefixes(sts_Settings.SMKZoneTAG):FilterOnce()
}

--Set of transportable groups and statics
TransportableSets = {
  BLUE = {
    Groups = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterCategoryGround():FilterPrefixes(sts_Settings.CargoGroupsTAG):FilterOnce() ,
    Crates = SET_STATIC:New():FilterCoalitions("blue"):FilterPrefixes(sts_Settings.CargoCrateTAG):FilterOnce()
  },
  RED = {
    Groups = SET_GROUP:New():FilterCoalitions("red"):FilterActive(true):FilterCategoryGround():FilterPrefixes(sts_Settings.CargoGroupsTAG):FilterOnce() ,
    Crates = SET_STATIC:New():FilterCoalitions("red"):FilterPrefixes(sts_Settings.CargoCrateTAG):FilterOnce()
  },
  NEUTRAL = {
    Groups = SET_GROUP:New():FilterCoalitions("neutral"):FilterActive(true):FilterCategoryGround():FilterPrefixes(sts_Settings.CargoGroupsTAG):FilterOnce() ,
    Crates = SET_STATIC:New():FilterCoalitions("neutral"):FilterPrefixes(sts_Settings.CargoCrateTAG):FilterOnce()
  }
}

--Table where CARGO_GROUPS created will be stored
CargoGroups = {
  BLUE = {},
  RED = {},
  NEUTRAL = {}
}

--Table where CARGO_CRATES created will be stored
CargoCrates = {
  BLUE = {},
  RED = {},
  NEUTRAL = {}
}

-- Table where to store menus data avalaible via F10 - Other radio items
Menu = {}

-- Table where to store mass data for carriers - carrier mass will be added/removed when cargo is loaded/unloaded
UnitMass = {}

-- Table where to store Zones created via mark points in F10 map
MarkTGTZonesMarks = {}


function spairs(t, order)
  -- collect the keys
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end
  -- if order function given, sort by it by passing the table and keys a, b,
  -- otherwise just sort the keys 
  if order then
    table.sort(keys, function(a,b) return order(t, a, b) end)
  else
    table.sort(keys)
  end
  -- return the iterator function
  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

-- Returns a cargo and carrier's mass info message
function CarrierMassInfo(carrierGroup)
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  local carrierUnitCargoBayMaxWeight = UnitMass[carrierUnitName].maxMass 
  local maxLoadableMass = math.ceil(((carrierUnitCargoBayMaxWeight /100) * sts_Settings.OverloadPercentage) + carrierUnitCargoBayMaxWeight)
  local actualLoadableMass = math.ceil(((carrierUnitCargoBayMaxWeight /100) * sts_Settings.OverloadPercentage) + (carrierUnitCargoBayMaxWeight - UnitMass[carrierUnitName].cargoMass)) 
  local loadedMass = UnitMass[carrierUnitName].cargoMass
  carrierGroup:MessageToGroup("\n".."Mass loaded in cargo bay: "..loadedMass.." Kg".."\n".."Remaining loadable mass: "..actualLoadableMass.." Kg".."\n".."Maximum loadable mass"..maxLoadableMass.." Kg", 15, carrierGroup, "- CARRIER MASS INFO")
end

-- Returns a message for each cargo in cargo bay
function CarrierCargoInfo(carrierGroup)
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  local cargoList = carrierUnit:GetCargo()
  carrierGroup:MessageToGroup("\n", 16, carrierGroup, "- CARGO MANIFEST")
  for k, cargo in pairs(cargoList) do
    local cargoName = cargo:GetName()
    carrierGroup:MessageToGroup("Cargo Mass : ".. UnitMass[carrierUnitName][cargoName].." Kg", 15, carrierGroup, cargoName)
  end
end

  -- ************************************************************************
  -- ***************************  ZONES HANDLERS  ****************************
  -- ************************************************************************ 

-- Uses MarkPoints to show WP zones in F10 Map
-- runs only if Settings.ZonesMarkOnMap is true
function MarkZonesOnMap(zoneList)
  if sts_Settings.ZonesMarkOnMap then
    for k, zone in pairs(zoneList) do
      zone:MarkZone(20)
    end
  end
end
-- Smokes zones defined in ME - reapeat every 5 minutes
function SmokeZones(zoneList)
  for k, zone in pairs(zoneList) do
    local zonePoint = zone:GetCoordinate()
    local smokeZoneScheduler = SCHEDULER:New( nil, 
      function()
        zonePoint:SmokeBlue()
      end, {}, 5, 310
    )
  end
end

-- Creates zones when a tagged mark is added on F10 Map
function AddZoneFromMark(markCoordinate, markText, markID)
  if string.match(markText, "#"..sts_Settings.WPZoneTAG) or string.match(markText, "#"..sts_Settings.PTZoneTAG)  or string.match(markText, "#"..sts_Settings.SMKZoneTAG)then
    local markIDstring = tostring(markID)
    local markCoordinateV2 = markCoordinate:GetVec2()
    local zoneRadius = 500
    if string.match(markText, "%((%d+)%)") then
      zoneRadius = tonumber(string.match(markText, "%((%d+)%)")) -- set zone radius if defined in markText
    end
    if string.match(markText, "#"..sts_Settings.WPZoneTAG) then -- create WPZone
      MarkTGTZonesMarks[markIDstring] = ZONE_RADIUS:New(sts_Settings.WPZoneTAG.."_mk_"..markIDstring , markCoordinateV2, zoneRadius)
      MarkTGTZonesMarks[markIDstring]:MarkZone(20)
      ZoneSets.TGTZONES:AddZone(MarkTGTZonesMarks[markIDstring])
      if sts_Settings.Debug then MESSAGE:New( markText.." - WP Zone Created", 3):ToAll() end --debug
    elseif string.match(markText, "#"..sts_Settings.PTZoneTAG) then -- create PTZone
      MarkTGTZonesMarks[markIDstring] = ZONE_RADIUS:New(sts_Settings.PTZoneTAG.."_mk_"..markIDstring , markCoordinateV2, zoneRadius)
      MarkTGTZonesMarks[markIDstring]:MarkZone(20)
      ZoneSets.TGTZONES:AddZone(MarkTGTZonesMarks[markIDstring])
      if sts_Settings.Debug then MESSAGE:New( markText.." - PT Zone Created", 3):ToAll() end --debug
    elseif string.match(markText, "#"..sts_Settings.SMKZoneTAG) then -- create SMKZone
      markCoordinate:SmokeBlue()
      if sts_Settings.Debug then MESSAGE:New( markText.." - Smoke Zone Created", 3):ToAll() end --debug
    end
  end
end

-- Removes zones created via mark on F10 Map
function RemoveZoneFromMark(markText, markID)
  if string.match(markText, "#WPZ") or string.match(markText, "#PTZ") then
    local markIDstring = tostring(markID)
    if string.match(markText, "#WPZ") then
      ZoneSets.TGTZONES:RemoveZonesByName(sts_Settings.WPZoneTAG.."_mk_"..markIDstring)
    elseif string.match(markText, "#PTZ") then
      ZoneSets.TGTZONES:RemoveZonesByName(sts_Settings.PTZoneTAG.."_mk_"..markIDstring)
    end
    MarkTGTZonesMarks[markID] = nil
    MESSAGE:New( markText.." Zone Removed", 3):ToAll()
  end
end

  -- ************************************************************************
  -- ***************************  MASS HANDLERS  ****************************
  -- ************************************************************************  

-- calculates cargo mass
-- params : cargo object
-- carrierUnitName (optional, needed only if cargo is loaded) 
function CalculateCargoMass(cargo, carrierUnitName)
  local cargoType = cargo:GetClassName()
  local cargoName = cargo:GetName()
  local cargoMass

  if cargo:IsLoaded() and carrierUnitName then -- if cargo is loaded gets the cargo mass from carrier's mass table
    cargoMass = UnitMass[carrierUnitName][cargoName]
  elseif cargoType == "CARGO_GROUP" and not cargo:IsLoaded() then -- if GROUP cargo isn't loaded calculates cargo mass
    local cargo_GroupObject = cargo:GetObject()
    local cargoAliveUnits = cargo_GroupObject:CountAliveUnits()
    local cargoInitUnitsCount = cargo:GetCount()
    local cargoWeight = cargo:GetWeight()
    cargoMass = (cargoWeight/cargoInitUnitsCount)*cargoAliveUnits
  elseif cargoType == "CARGO_CRATE"  and not cargo:IsLoaded() then -- if CRATE cargo isn't loaded calculates cargo mass
    local pStatic = StaticObject.getByName( cargoName ) -- DCS API finds static object by name
    local iWeight = pStatic:getCargoWeight() -- DCS API gets static mass defined in ME
    if iWeight > 0 then
      cargoMass = iWeight
    else
      cargoMass = sts_Settings.DefaultStaticCargoMass -- if Static object has no mass set, applies default value
    end
  end
  return cargoMass
end

-- Add mass to a carrier
function AddMass(carrierGroup, cargo, cargoAliveUnits)
  local cargoClass = cargo:GetClassName()
  local cargoName = cargo:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  local cargoMass = 0
  if cargoClass == "CARGO_GROUP" then
    local cargoInitUnitsCount = cargo:GetCount()
    local cargoWeight = cargo:GetWeight()
    cargoMass = (cargoWeight/cargoInitUnitsCount)*cargoAliveUnits -- calculates mass based un cargo alive units
  elseif cargoClass == "CARGO_CRATE" then
    local pStatic = StaticObject.getByName( cargoName ) -- DCS API finds static object by name
    local iWeight = pStatic:getCargoWeight() -- DCS API gets static mass defined in ME
    if iWeight > 0 then
      cargoMass = iWeight
    else
      cargoMass = sts_Settings.DefaultStaticCargoMass  -- if Static object has no mass set, applies default value
    end
  end
  UnitMass[carrierUnitName][cargoName] = cargoMass -- record mass for specific cargo
  UnitMass[carrierUnitName].cargoMass =  UnitMass[carrierUnitName].cargoMass + cargoMass -- record calculated total cargo mass in carrier cargo bay
  trigger.action.setUnitInternalCargo( carrierUnitName , UnitMass[carrierUnitName].cargoMass) -- DCS API that defines the cargo mass 
  carrierGroup:MessageToGroup("\n".."Mass loaded: "..cargoMass.." Kg ".."\n".."Total Mass in cargo bay: "..UnitMass[carrierUnitName].cargoMass.." Kg", 10, carrierGroup, "- CARGO-INFO")
end

-- Remove mass from a carrier
function RemoveMass(carrierGroup, cargo)
  local cargoName = cargo:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  UnitMass[carrierUnitName].cargoMass = UnitMass[carrierUnitName].cargoMass - UnitMass[carrierUnitName][cargoName]
  trigger.action.setUnitInternalCargo( carrierUnitName , UnitMass[carrierUnitName].cargoMass) -- DCS API that defines the cargo mass 
  carrierGroup:MessageToGroup("\n".."Mass Unloaded: "..UnitMass[carrierUnitName][cargoName].." Kg ".."\n".."Total Mass in cargo bay: "..UnitMass[carrierUnitName].cargoMass.." Kg", 10, carrierGroup, "- CARGO-INFO")
end

  -- ************************************************************************
  -- ***************************  CARGO HANDLERS  ***************************
  -- ************************************************************************

--Generate CARGO_GROUPS and store them in CargoGroups table
function CargoGroupGenerator(group)
  local groupName = group:GetName()
  if string.match(groupName, sts_Settings.CargoGroupsTAG) then 
    local COALITION = string.upper(group:GetCoalitionName())
    if not CargoGroups[COALITION][groupName] then
      CargoGroups[COALITION][groupName] = CARGO_GROUP:New(group, "GROUP", groupName, sts_Settings.LoadRadius, sts_Settings.NearRadius)
    end
    if sts_Settings.RespawnOnDestroyed then CargoGroups[COALITION][groupName]:RespawnOnDestroyed(true) end
  end
end

-- Generate CARGO_CRATES and store them in CargoCrates table
function CargoCrateGenerator(static, COALITION)
  local staticName = static:GetName()
  CargoCrates[COALITION][staticName] = CARGO_CRATE:New(static, "CRATE", staticName, 50, 50)
  if sts_Settings.RespawnOnDestroyed then CargoCrates[COALITION][staticName]:RespawnOnDestroyed(true) end
end

-- Routes cargo through WP and PT Zones
function CargoRouter( cargoGroup )
  local wpZone = nil
  local ptZones = nil
  local zones = ZoneSets.TGTZONES:GetSet() --gets zones table from zone set
  local cargo = cargoGroup

  for k, zone in pairs(zones) do -- loop zones
    if cargo:IsInZone(zone) then
      local zoneName = zone:GetName()
      if string.match(zoneName, sts_Settings.WPZoneTAG) then
        wpZone = zone
      elseif string.match(zoneName, sts_Settings.PTZoneTAG) then
        if not ptZones then ptZones = {} end
        ptZones[#ptZones+1] = zone
      end
    end
  end
  if cargo:IsAlive() and not cargo:IsLoaded() then
    local transportableGroup = cargo:GetObject()
    if wpZone then
      local zonePoint = wpZone:GetCoordinate()
      transportableGroup:RouteGroundTo(zonePoint, 50, "Diamond", 20, AfterCargoRouter, transportableGroup ) -- route at the zone center
    elseif ptZones then
      transportableGroup:PatrolZones(ptZones, 50, "Diamond", 20, 50) -- patrol a list of zones
    end
  end
end

-- Routes cargo groups through PT Zones after they reach the center of a WP Zone
function AfterCargoRouter(group)
  local ptZones = {}
  local zones = ZoneSets.TGTZONES:GetSet()
  for k, zone in pairs(zones) do
    if group:IsInZone(zone) then
      local zoneName = zone:GetName()
      if string.match(zoneName, sts_Settings.PTZoneTAG) then
        ptZones[#ptZones+1] = zone
      end
    end
  end
  if #ptZones < 1 then return end
  if group:IsAlive() then
    group:PatrolZones(ptZones, 50, "Diamond", 20, 50)
  end
end

-- Check and validate cargo after that is been loaded on carrier
-- Needed to avoid people to overload carriers and transport too many troops that would not have enought room inside carrier
function ValidateCargoAfterLoad(carrierUnit)
  if not sts_Settings.ValidateCargo then return true end
  local carrierUnitName = carrierUnit:GetName()
  local carrierUnitCargoBayMaxWeight = UnitMass[carrierUnitName].maxMass
  local loadableMass = math.ceil(((carrierUnitCargoBayMaxWeight /100) * sts_Settings.OverloadPercentage) + carrierUnitCargoBayMaxWeight)
  if UnitMass[carrierUnitName].cargoMass <= loadableMass then
    return true
  else
    return false
  end
end

-- Unboards troops and define actions to do after unboarding
--cargoGroup = table[1]
--carrierGroup = table[2]
--COALITION = table[3]
--if NOT nil will prevent cargo to be routed in zones after unboarding = table[4]
function UnBoardTroops(table)
  local cargoGroup = table[1]
  local cargoGroupName = cargoGroup:GetName()
  --local cargo_GroupObject = cargoGroup:GetObject()
  local carrierGroup = table[2]
  --local carrierGroupName = carrierGroup:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local COALITION = table[3]
  local carrierPoint = carrierGroup:GetCoordinate()
  --local zoneList = ZoneSets.TGTZONES:GetSet()
  local RouteCargo -- if false cargo will not be routed by CargoRouter() after unboarding
  if table[4] == nil then 
    RouteCargo = true
  else
    RouteCargo = false
  end 
  local MenuGeneratorDelayed = TIMER:New(MenuGenerator, carrierGroup)
  
  if cargoGroup:IsUnboarding() then 
    carrierGroup:MessageToGroup("Cargo is already unboarding", 10, carrierGroup, cargoGroupName)
    return 
  end
  
  -- NOTE  do not use that P.o.S. of :onafterUnBoard() that does not fucking work fine for me -.-
  function cargoGroup:onafterUnLoad(Event, From, To, Core, ToPointVec2)
    --delay for menu re-generation wait to group to be unboarded 
    MenuGeneratorDelayed:Start(5)
    carrierGroup:MessageToGroup("Unboarded!", 10, carrierGroup, cargoGroupName)
    RemoveMass(carrierGroup, cargoGroup)  -- removes cargo mass from carrier
    carrierUnit:RemoveCargo(cargoGroup) -- need to remove cargo manually - cargo group are added to cargo automatically when boarded but not removed when unboarded
    -- Schedule group routing to Zones because need to wait until all of group is unboarded, also simulates times needed to pathfinding - timer set on 40 seconds
    if RouteCargo == true then
      local unloadscheduler = SCHEDULER:New( nil, 
        function()
          CargoRouter(cargoGroup)
        end, {}, 40
      )
    end
  end
  
  if math.floor(carrierUnit:GetVelocityKMH()) <= 10 and math.floor(carrierGroup:GetHeight(true)) <= 20 then -- prevents from unboarding from high speed or altitude
    cargoGroup:UnBoard(carrierPoint:GetRandomCoordinateInRadius(30, 20))
    carrierGroup:MessageToGroup("Unboarding...", 10, carrierGroup, cargoGroupName)
    MenuGeneratorDelayed:Start(1)
  else
    carrierGroup:MessageToGroup("You must be under 20 meters and less then 10 Km/h to unboard!!", 10, carrierGroup, cargoGroupName)
  end
end

-- Board troops to a carrier
--cargoGroup = table[1]
--carrierGroup = table[2]
--COALITION = table[3]
function BoardTroops(table)
  local cargoGroup = table[1]
  local cargoGroupName = cargoGroup:GetName()

  local cargo_GroupObject = cargoGroup:GetObject()
  local cargoAliveUnits = cargo_GroupObject:CountAliveUnits()
  local carrierGroup = table[2]
  --local carrierGroupName = carrierGroup:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  --local carrierUnitName = carrierUnit:GetName()
  --local carrierPoint = carrierUnit:GetCoordinate()
  local COALITION = table[3] 
  if cargoGroup:IsBoarding() then  -- prevent boarding from multiple carriers
    carrierGroup:MessageToGroup("Is already boarding -  cannot board", 15, carrierGroup, cargoGroupName)
    MenuGenerator(carrierGroup)
    return
  end
  local MenuGeneratorDelayed = TIMER:New(MenuGenerator, carrierGroup) 

  --    function cargoGroup:onafterLoad(Event, From, To) -- , CargoCarrier
  function cargoGroup:OnEnterLoaded()
    carrierGroup:MessageToGroup("Boarded!", 10, carrierGroup, cargoGroupName)
    MenuGeneratorDelayed:Start(2)
    AddMass(carrierGroup, cargoGroup, cargoAliveUnits) -- Add cargo mass to carrier
    if not ValidateCargoAfterLoad(carrierUnit) then  -- if cargo not validated it will be unloaded
      UnBoardTroops({cargoGroup, carrierGroup, COALITION, 1})
      carrierGroup:MessageToGroup(cargoGroupName.."\n".."Cargo not loadable. Too big or heavy!", 10, carrierGroup, "- CARGO-INFO")
    end
  end  -- END ON AFTER LOAD
  
  if math.floor(carrierUnit:GetVelocityKMH()) <= 10 and math.floor(carrierGroup:GetHeight(true)) <= 20 then -- prevents from boarding from high speed or altitude
    cargoGroup:Board(carrierUnit, sts_Settings.NearRadius)
    carrierGroup:MessageToGroup("Boarding...", 10, carrierGroup, cargoGroupName)
    MenuGenerator(carrierGroup)
    boardScheduler = SCHEDULER:New( nil, -- if cargo not boarded within 3 minutes, since it is not possible to stop the boarding process, this will abort the boarding process destroyng and respawning cargo
      function()
        if cargoGroup:IsLoaded() then boardScheduler:Stop() return end -- cargo now is loaded do nothing
        if cargoGroup:IsBoarding() then  -- if cargo is still boarding
          cargoGroup:RespawnOnDestroyed(true)
          cargoGroup:Destroy() 
          carrierGroup:MessageToGroup("Unable to board!\nBOARDING ABORTED AND CARGO GROUP RESPAWNED TO IT'S INITIAL POSITION!", 10, carrierGroup, cargoGroupName)
          boardScheduler:Stop()
        end
      end, {}, 180
    ) 
  else
    carrierGroup:MessageToGroup("You must be under 20 meters and less then 10 Km/h to board!!", 10, carrierGroup, cargoGroupName)
  end
end

--Unload crates and define actions to do after unloading
--cargoCrate = table[1]
--carrierGroup = table[2]
--COALITION = table[3]
function UnLoadCrate(table)
  local cargoCrate = table[1]
  local cargoCrateName = cargoCrate:GetName()
  local carrierGroup = table[2]
  --local carrierName = carrierGroup:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local COALITION = table[3]
  local carrierPoint = carrierUnit:GetCoordinate()
  local MenuGeneratorDelayed = TIMER:New(MenuGenerator, carrierGroup)
  function cargoCrate:onafterUnLoad(Event, From, To) -- , CargoCarrier
    
    carrierGroup:MessageToGroup("Crate Unloaded!", 10, carrierGroup, cargoCrateName)
    RemoveMass(carrierGroup, cargoCrate) -- removes mass from carrier
    carrierUnit:RemoveCargo(cargoCrate) -- remove cargo manually-only cargo group are added to cargo automatically when boarded but not removed when unboarded crates need to be added and removed manually
    MenuGeneratorDelayed:Start(1)
  end
  if math.floor(carrierUnit:GetVelocityKMH()) <= 10 and math.floor(carrierGroup:GetHeight(true)) <= 5 then -- prevents from unloading from high speed or altitude
    cargoCrate:UnLoad(carrierPoint:GetRandomCoordinateInRadius(20, 15))  
    MenuGeneratorDelayed:Start(1)
  else
    carrierGroup:MessageToGroup("You must be under 5 meters and lass then 10 Km/h to unload!!", 10, carrierGroup, cargoCrateName)
  end
end

--Load crates to a carrier and generate menus for unboarding
--cargoCrate = table[1]
--carrierGroup = table[2]
--COALITION = table[3]
function LoadCrate(table)
  local cargoCrate = table[1]
  local cargoCrateName = cargoCrate:GetName()
  local carrierGroup = table[2]
  --local carrierGroupName = carrierGroup:GetName()
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  --local carrierUnitName = carrierUnit:GetName()
  --local carrierPoint = carrierUnit:GetCoordinate()
  local COALITION = table[3]
  local MenuGeneratorDelayed = TIMER:New(MenuGenerator, carrierGroup)
  --    function cargoCrate:onafterLoad(Event, From, To, CargoCarrier) -- 
  function cargoCrate:OnEnterLoaded() --       
    carrierGroup:MessageToGroup("Crate Loaded!", 10, carrierGroup, cargoCrateName)
--    MenuGeneratorDelayed:Start(1)
    AddMass(carrierGroup, cargoCrate)
    if not ValidateCargoAfterLoad(carrierUnit) then 
      UnLoadCrate({cargoCrate, carrierGroup, COALITION})
      carrierGroup:MessageToGroup(cargoCrateName.."\n".."Cargo not loadable. Too big or heavy!", 10, carrierGroup, "- CARGO-INFO")
    else
      carrierUnit:AddCargo(cargoCrate)
    end
    MenuGeneratorDelayed:Start(1)
  end -- END enterloaded
  if math.floor(carrierUnit:GetVelocityKMH()) <= 3 and math.floor(carrierGroup:GetHeight(true)) <= 3 then -- prevents from loading from high speed or altitude
    cargoCrate:Load(carrierUnit)
    MenuGenerator(carrierGroup)
  else
    carrierGroup:MessageToGroup("You must be on ground to load crates!!!", 10, carrierGroup, cargoCrateName)
  end
end

  -- ************************************************************************
  -- ***************************  CARGO SPAWNER  ****************************
  -- ************************************************************************
  --TODO DEVELOP
--CargoSpawn = SPAWN:New("AntiTank_x6_GRP-1"):OnSpawnGroup(
--  function( SpawnGroup )
--  if sts_Settings.Debug then MESSAGE:New( "AFTER SPAWN" , 3):ToAll() end --debug
--    local groupName = SpawnGroup:GetName()
--    local COALITION = string.upper(SpawnGroup:GetCoalitionName())
--    if not CargoGroups[COALITION][groupName] then
--      CargoGroups[COALITION][groupName] = CARGO_GROUP:New(SpawnGroup, "GROUP", groupName, sts_Settings.LoadRadius, sts_Settings.NearRadius)
--    end
--  end 
--)

--function SpawnFromStatic(staticName)
--
--  local spawnStatic = STATIC:FindByName( staticName )
--  --local staticHeight = spawnStatic:GetHeight()
--  local staticVec3 = spawnStatic:GetPositionVec3()
--  
---- if sts_Settings.Debug then MESSAGE:New( "height SPAWN "..staticHeight , 5):ToAll() end --debug
--  -- Spawn from the static position at the height specified in the ME of the group template!
--  cargoSpawn = SPAWN:New("AntiTank_x6_GRP-1"):SpawnFromVec3(staticVec3)
-- 
--end 

  -- ************************************************************************
  -- ***************************  MENU HANDLERS  ****************************
  -- ************************************************************************
-- Generates Radio Menus under F10 - Other
function MenuGenerator(carrierGroup)
  local carrierGroupName = carrierGroup:GetName()
  if not string.match(carrierGroupName , sts_Settings.CarrierTAG) then return end 
  local carrierCoalition = string.upper(carrierGroup:GetCoalitionName())
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  local carrierUnitCoord = carrierUnit:GetCoordinate()
--  -- DEBUG
--  local unitCargo = carrierUnit:GetCargo()
--  for k, cargo in pairs(unitCargo) do
--  
--    MESSAGE:New( "cargo --- ---- "..cargo:GetName() , 10):ToAll()
--  end
  
  -------- GROUPS MENUS GEN/DEL --------
  local distanceTableGroups = {} -- table that will contain cargo distance from carrier (format : {[cargoName] = distance}
  local cargoTableGroups = {} -- table that will contain cargo group objects ( format: {[cargoName] = cargoObject}
  for k, cargoGroup in pairs(CargoGroups[carrierCoalition]) do 
    local cargoGroupName = cargoGroup:GetName()

    if cargoGroup:IsInLoadRadius(carrierUnitCoord) and not cargoGroup:IsBoarding() and not cargoGroup:IsLoaded() and cargoGroup:IsAlive() then --if cargo is boardable
      local cargoGroupCoordinate = cargoGroup:GetCoordinate()
      local cargoDistanceFromCarrier = carrierUnitCoord:DistanceFromPointVec2(cargoGroupCoordinate) -- calculates cargo distance from carrier
      distanceTableGroups[cargoGroupName] = math.ceil(cargoDistanceFromCarrier) -- insert data to table
      cargoTableGroups[cargoGroupName] = cargoGroup -- insert data to table
      if Menu[carrierGroupName].commands.unload[cargoGroupName] then -- since the cargo is boardable (so it isn't loaded), if an unload command menu for cargo exists remove it
        Menu[carrierGroupName].commands.unload[cargoGroupName]:Remove()
        Menu[carrierGroupName].commands.unload[cargoGroupName] = nil
      end
    elseif not cargoGroup:IsInLoadRadius(carrierUnitCoord) or not cargoGroup:IsAlive() or cargoGroup:IsLoaded() or cargoGroup:IsBoarding()  then -- if cargo is not boarddable removes command menu
      if Menu[carrierGroupName].commands[cargoGroupName] then
        Menu[carrierGroupName].commands[cargoGroupName]:Remove()
        Menu[carrierGroupName].commands[cargoGroupName] = nil
      end
    end
  end
  for cargoname, distance in spairs(distanceTableGroups, function(t,a,b) return t[b] > t[a] end) do -- generates radio menus for group boarding sorted by distance from carrier
    -- TODO Verify if this "if statement" is still needed
    if Menu[carrierGroupName].commands[cargoname] then 
      Menu[carrierGroupName].commands[cargoname]:Remove()
    end
    Menu[carrierGroupName].commands[cargoname] = MENU_GROUP_COMMAND:New( carrierGroup, "Board "..string.gsub(cargoname, sts_Settings.CargoGroupsTAG, "").."("..CalculateCargoMass(cargoTableGroups[cargoname]).." Kg)", Menu[carrierGroupName].commands.mainTroops, BoardTroops, {cargoTableGroups[cargoname], carrierGroup, carrierCoalition} ) 
  end

  -------- CRATES MENUS GEN/DEL --------
  local distanceTableCrates = {} -- table that will contain cargo distance from carrier (format : {[cargoName] = distance}
  local cargoTableCrates = {} -- table that will contain cargo group objects ( format: {[cargoName] = cargoObject}
  for k, cargoCrate in pairs(CargoCrates[carrierCoalition]) do
    local cargoCrateName = cargoCrate:GetName()

    if cargoCrate:IsInLoadRadius(carrierUnitCoord) and not cargoCrate:IsLoaded() and cargoCrate:IsAlive() then--if cargo is loadable
      local cargoCrateCoordinate = cargoCrate:GetCoordinate()
      local cargoDistanceFromCarrier = carrierUnitCoord:DistanceFromPointVec2(cargoCrateCoordinate) -- calculates cargo distance from carrier
      distanceTableCrates[cargoCrateName] = math.ceil(cargoDistanceFromCarrier) -- insert data to table
      cargoTableCrates[cargoCrateName] = cargoCrate -- insert data to table
      if Menu[carrierGroupName].commands.unload[cargoCrateName] then  -- since the cargo is loadable (so it isn't loaded), if an unload command menu for cargo exists remove it
        Menu[carrierGroupName].commands.unload[cargoCrateName]:Remove()
        Menu[carrierGroupName].commands.unload[cargoCrateName] = nil
      end
    elseif not cargoCrate:IsInLoadRadius(carrierUnitCoord) or not cargoCrate:IsAlive() or cargoCrate:IsLoaded() then -- if cargo is not loadable removes command menu
      if Menu[carrierGroupName].commands[cargoCrateName] then
        Menu[carrierGroupName].commands[cargoCrateName]:Remove()
        Menu[carrierGroupName].commands[cargoCrateName] = nil
      end
    end
  end
  
  for cargoname, distance in spairs(distanceTableCrates, function(t,a,b) return t[b] > t[a] end) do -- generates radio menus for crates loading sorted by distance from carrier
    if Menu[carrierGroupName].commands[cargoname] then 
      Menu[carrierGroupName].commands[cargoname]:Remove()
    end
    Menu[carrierGroupName].commands[cargoname] = MENU_GROUP_COMMAND:New( carrierGroup, "Load "..string.gsub(cargoname, sts_Settings.CargoCrateTAG, "").."("..CalculateCargoMass(cargoTableCrates[cargoname]).." Kg)", Menu[carrierGroupName].commands.mainCrates, LoadCrate, {cargoTableCrates[cargoname], carrierGroup, carrierCoalition} ) 
  end
  
  local unitCargo = carrierUnit:GetCargo() -- generates unload command menus based on loaded cargos
  for k, cargo in pairs(unitCargo) do
    local cargoName = cargo:GetName()
    if not cargo:IsUnboarding() then
      if cargo:GetType() == "GROUP" then --TODO 
        Menu[carrierGroupName].commands.unload[cargoName] = MENU_GROUP_COMMAND:New( carrierGroup, "Unboard "..string.gsub(cargoName, sts_Settings.CargoGroupsTAG, "").." ("..CalculateCargoMass(cargo,carrierUnitName).." Kg)", Menu[carrierGroupName].commands.unload.mainTroops, UnBoardTroops, {cargo, carrierGroup, carrierCoalition} )
      else
        Menu[carrierGroupName].commands.unload[cargoName] = MENU_GROUP_COMMAND:New( carrierGroup, "Unload "..string.gsub(cargoName, sts_Settings.CargoGroupsTAG, "").." ("..CalculateCargoMass(cargo,carrierUnitName).." Kg)", Menu[carrierGroupName].commands.unload.mainCrates, UnLoadCrate, {cargo, carrierGroup, carrierCoalition} )
      end
    elseif cargo:IsUnboarding()  then
      Menu[carrierGroupName].commands.unload[cargoName]:Remove()
    end
  end
end

  -- ************************************************************************
  -- *************************  REFRESH SCHEDULER  **************************
  -- ************************************************************************

MainScheduler = SCHEDULER:New( nil, 
  function()
  
    -- SpawnFromStatic("stitic") -- test
    
    -- for each group of each transport set check if the group is still alive:
    -- if group is NOT alive remove the group from set
    -- if group IS alive then call the function MenuGenerator for this group
    for skey, transportSet in pairs(TransportSets) do
      local transportSetTable = transportSet:GetSet() 
      for gkey, transportGroup in pairs(transportSetTable) do
        if not transportGroup:IsAlive() then 
          transportSet:RemoveGroupsByName(transportGroup:GetName())
        else       
          MenuGenerator(transportGroup)
        end
      end
    end
  end, {}, 5, sts_Settings.RefreshTime
)

  -- ************************************************************************
  -- ****************************  SCRIPT INIT  *****************************
  -- ************************************************************************

--Generate CARGO_GROUPS and CARGO_CRATES for each coalition at the beginning of the mission

TransportableSets.BLUE.Groups:ForEachGroup(
  function (group)
    CargoGroupGenerator(group)
  end
)
TransportableSets.BLUE.Crates:ForEachStatic(
  function (static)
    CargoCrateGenerator(static, "BLUE")
  end
)
TransportableSets.RED.Groups:ForEachGroup(
  function (group)
    CargoGroupGenerator(group)
  end
)
TransportableSets.RED.Crates:ForEachStatic(
  function (static)
    CargoCrateGenerator(static, "RED")
  end
)
TransportableSets.NEUTRAL.Groups:ForEachGroup(
  function (group)
    CargoGroupGenerator(group)
  end
)
TransportableSets.NEUTRAL.Crates:ForEachStatic(
  function (static)
    CargoCrateGenerator(static, "NEUTRAL")
  end
)

MarkZonesOnMap(ZoneSets.TGTZONES:GetSet())
SmokeZones(ZoneSets.SMKZONES:GetSet())

-- init carrier removing all old data if present and creating tables for menu and mass management
function CarrierInit(carrierGroup)
  if not carrierGroup then return end
  local carrierGroupName = carrierGroup:GetName()
  if not string.match(carrierGroupName, sts_Settings.CarrierTAG) then return end
  local carrierUnit = carrierGroup:GetFirstUnitAlive()
  local carrierUnitName = carrierUnit:GetName()
  
  UnitMass[carrierUnitName] = nil --reset mass data
  UnitMass[carrierUnitName] = {}
  UnitMass[carrierUnitName].cargoMass = 0 
  carrierUnit:ClearCargo() -- reset cargo
  carrierUnit:SetCargoBayWeightLimit() -- reset cargo bay limit
  UnitMass[carrierUnitName].maxMass = carrierUnit:GetCargoBayFreeWeight()
  
  if Menu[carrierGroupName] then Menu[carrierGroupName].main:Remove() end -- reset menus
  Menu[carrierGroupName] = nil 
  Menu[carrierGroupName] = {} 
  Menu[carrierGroupName].main = MENU_GROUP:New( carrierGroup, "K-STS" )
  Menu[carrierGroupName].commands = {}
  Menu[carrierGroupName].commands.unload = {}
--  Menu[carrierGroupName].commands.mainUnload = MENU_GROUP:New( carrierGroup, "Unload Cargos", Menu[carrierGroupName].main )
  Menu[carrierGroupName].commands.mainTroops = MENU_GROUP:New( carrierGroup, "Troops Transport", Menu[carrierGroupName].main )
  Menu[carrierGroupName].commands.unload.mainTroops = MENU_GROUP:New( carrierGroup, "Unboard Troops", Menu[carrierGroupName].commands.mainTroops )
  Menu[carrierGroupName].commands.mainCrates = MENU_GROUP:New( carrierGroup, "Crates Transport", Menu[carrierGroupName].main )
  Menu[carrierGroupName].commands.unload.mainCrates = MENU_GROUP:New( carrierGroup, "Unload Crates", Menu[carrierGroupName].commands.mainCrates )
  Menu[carrierGroupName].commands.mainInfo = MENU_GROUP:New( carrierGroup, "Info...", Menu[carrierGroupName].main )
  Menu[carrierGroupName].commands.carrierMassInfo = MENU_GROUP_COMMAND:New( carrierGroup, "Mass Info", Menu[carrierGroupName].commands.mainInfo, CarrierMassInfo, carrierGroup)
  Menu[carrierGroupName].commands.carrierCargoInfo = MENU_GROUP_COMMAND:New( carrierGroup, "Cargo Manifest", Menu[carrierGroupName].commands.mainInfo, CarrierCargoInfo, carrierGroup)
end

MESSAGE:New( "K-STS Loaded" , 5):ToAll()

  -- ************************************************************************
  -- ***************************  EVENT HANDLERS  ***************************
  -- ************************************************************************

-- Event Handling Subscriptions
EventHandler = EVENTHANDLER:New()
EventHandler:HandleEvent(EVENTS.Birth)
EventHandler:HandleEvent(EVENTS.Land)
EventHandler:HandleEvent(EVENTS.Takeoff)
--EventHandler:HandleEvent(EVENTS.Dead)
EventHandler:HandleEvent(EVENTS.MarkChange) 
EventHandler:HandleEvent(EVENTS.MarkRemoved)


function EventHandler:OnEventBirth(EventData)
  CarrierInit(EventData.IniGroup)
  MenuGenerator(EventData.IniGroup)
  
  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."BIRTH EVENT" , 3):ToAll() end --debug
end

function EventHandler:OnEventLand(EventData)
  MenuGenerator(EventData.IniGroup)
  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."LAND EVENT" , 3):ToAll() end --debug
end

function EventHandler:OnEventTakeoff(EventData)
  MenuGenerator(EventData.IniGroup)
  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."TAKE-OFF EVENT" , 3):ToAll() end --debug
end

--function EventHandler:OnEventDead(EventData)
--  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."DEAD EVENT" , 3):ToAll() end --debug
--end

function EventHandler:OnEventMarkChange(EventData)
--EVENTDATA.MarkCoalition
--EVENTDATA.MarkCoordinate
--EVENTDATA.MarkGroupID
--EVENTDATA.MarkID
--EVENTDATA.MarkText
--EVENTDATA.MarkVec3
  AddZoneFromMark(EventData.MarkCoordinate, EventData.MarkText, EventData.MarkID)
  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."MARK CHANGE EVENT" , 3):ToAll() end --debug
end

function EventHandler:OnEventMarkRemoved(EventData)
  RemoveZoneFromMark(EventData.MarkText, EventData.MarkID)
  if sts_Settings.Debug then MESSAGE:New( "DEBUG:  ".."MARK REMOVE EVENT" , 3):ToAll() end --debug
end
