-------------------------------------------------------------------------
-- MTS-200 - MANTIS - Advanced Mode
-------------------------------------------------------------------------
-- Documentation
-- 
-- MANTIS: https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Functional.Mantis.html
-- 
-- Note: As of Dec/20, MANTIS is WIP. Needs a recent build of Moose.lua > 17 Dec 20
--        for CONTROLLABLE:RelocateGroundRandomInRadius() to be available
--        https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/CONTROLLABLE.RelocateGroundRandomInRadius.html
-------------------------------------------------------------------------
-- Observe a set of SAM sites being attacked by F18 SEAD, A10 and Helicopters. 
-- HQ and EWR will be destroyed after 10 and 15 mins, respectively
-- Detection will slow down accordingly, if both units are dead, all SAM sites go to RED state
-- Set up of a new HQ and EWR will recover MANTIS
-------------------------------------------------------------------------
-- Date: 21 Dec 2020
-------------------------------------------------------------------------

myredmantis = MANTIS:New("myredmantis","Red SAM","Red EWR","Red HQ","red",true)
--myredmantis:SetAutoRelocate(true, true) -- make HQ and EWR relocatable, if they are actually mobile in DCS!
myredmantis:SetAdvancedMode(true, 100) -- switch on advanced mode - detection will slow down or die if HQ and EWR die
myredmantis:Debug(false)
myredmantis.verbose = true -- watch DCS.log
myredmantis:Start()

function destroy(objectname)
  local text = "Destroying "..objectname
  m=MESSAGE:New(text,30,"Info"):ToAll()
  local grp = GROUP:FindByName(objectname)
  grp:Destroy()
end

function createhq()
  newhq = SPAWN
    :New("Red HQ-1")
    :InitDelayOff()
    :OnSpawnGroup(
    function (group)
      myredmantis:SetCommandCenter(group)
    end
    )
    :Spawn()
  local text = "Creating new HQ!"
  m=MESSAGE:New(text,30,"Info"):ToAll()
end

function createewr()
  newewr = SPAWN
    :New("Red EWR-1")
    :InitDelayOff()
    :Spawn()
  local text = "Creating new EWR!"
  m=MESSAGE:New(text,30,"Info"):ToAll()
end

hqtimer = TIMER:New(destroy,"Red HQ") 
ewrtimer = TIMER:New(destroy,"Red EWR")
awacstimer = TIMER:New(destroy,"Red EWR Awacs")

nhqtimer = TIMER:New(createhq)
newrtimer = TIMER:New(createewr)

-- slow down
hqtimer:Start(300) -- 5 min
ewrtimer:Start(360) -- 6 min
awacstimer:Start(420) -- 7 min

--speed up
nhqtimer:Start(600) -- 10 min
newrtimer:Start(660) -- 11 min
