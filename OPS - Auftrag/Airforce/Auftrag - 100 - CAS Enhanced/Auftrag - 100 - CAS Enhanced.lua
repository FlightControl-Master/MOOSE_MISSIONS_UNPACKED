---
-- Mission: Close Air Support (CAS) Enhanced
-- 
-- A group of three A-10s will provide close air support in (polygon) zone called "Zone CAS" and attack ground targets it detects automatically.
-- Targets in zone "Zone No Engage" are spared as intel reports a great risk of civilan casualties in this area.
--
-- Why "enhanced"?
-- 
-- In contrast to the AUFTRAG type CAS, which uses the DCS enroute task "engageTargetsInZone" you can
-- * Specify a polygon zone as CAS zone. DCS task only allows circular zones.
-- * Set a max engage range relative to the aircraft.
-- * Define a "no engage" zone, where targets are not engaged.
-- 
-- Note that in the :SetEngageDetectedOn() function, the second parameter {"Ground Units"} defines which types of targets are engaged.
-- This gives you a lot of flexibility in the types of targets that are engaged. Other choices would be
-- * {"Ground Units Non Airdefence"} to engage everything on the ground but air defence units.
-- * {"Ground vehicles"} to engage vehicles but not infantry.
-- * {"Infantry"} to engage only infantry.
-- * {"Armed ground units"} to engage only armed forces.
---

-- CAS zone.
local zoneCAS=ZONE_POLYGON:NewFromGroupName("Zone CAS")

-- No engage zone. Targets in this zone will not be engaged.
local zoneNoGo=ZONE:New("Zone No Engage")

-- Create a flight group.
local flightgroup=FLIGHTGROUP:New("A-10C CAS Group")

-- Automatically engage targets:
-- * Only detected targets within 15 NM radius of the group are engaged.
-- * Targets must have the attribute "Ground Units". See https://wiki.hoggitworld.com/view/DCS_enum_attributes
-- * Only targets which are in zoneCAS are engaged.
-- * Targets within zoneNoGo are NOT engaged.
flightgroup:SetEngageDetectedOn(15, {"Ground Units"}, zoneCAS, zoneNoGo)

-- Create a PATROLZONE mission. Speed is 250 knots, altitude 12,000 ft.
local mission=AUFTRAG:NewPATROLZONE(zoneCAS, 250, 12000)

-- Assign mission to pilot.
flightgroup:AddMission(mission)


--- Function called when the group detectes a previously unkwown group. This is only for debuggin and not necessary for the CAS mission.
function flightgroup:OnAfterDetectedGroupNew(From, Event, To, Group)
  local group=Group --Wrapper.Group#GROUP
  -- Message to everybody and in the DCS log file.
  local text=string.format("Detected group %s", group:GetName())
  MESSAGE:New(text, 120,flightgroup:GetName()):ToAll()
  env.info(text)  
end