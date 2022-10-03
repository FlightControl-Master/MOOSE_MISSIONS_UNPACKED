------------------------------------------------------------
-- Weapon Factory
-- 
-- The airwing at Batumi (CVW-9) consists of one squadron,
-- the VFA-14 Tophatters.
-- 
-- Initially, the squadron has no assets and the airwing
-- has no payloads.
-- 
-- A factory at Batumi produces airframes and weapons for
-- the airwing/squadron.
-- 
-- Every two minutes, a payload is produced and added to
-- the airwing.
-- Every five minutes, a new asset is produced and added to
-- the squadron.
-- 
-- If the factory gets destroyed, production will come to a
-- standstill. This should happen after 17 minutes.
-- 
-- Amount of assets in stock and payloads is printed to the
-- screen.
------------------------------------------------------------

---
-- Squadrons
---

-- VFA-14 Tophatters: Hornet*2, Callsign Dodge, Modex 100+, Skill Excellent, specialized on GCI missions.
local VFA14=SQUADRON:New("F/A-18C Template", 0, "VFA-14 (Tophatters)") --Ops.Squadron#SQUADRON
VFA14:SetGrouping(2)
VFA14:SetModex(100)
VFA14:SetCallsign(CALLSIGN.Aircraft.Dodge)
VFA14:SetRadio(251)
VFA14:SetLivery("VFA-34")
VFA14:SetSkill(AI.Skill.EXCELLENT)
VFA14:AddMissionCapability({AUFTRAG.Type.GCICAP}, 100)
VFA14:AddMissionCapability({AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY}, 50)


---  
-- Airwing
---

-- Create an airwing.
local CVW9=AIRWING:New("Warehouse Batumi", "CVW-9") --Ops.AirWing#AIRWING

-- Add squadrons to airwing.
CVW9:AddSquadron(VFA14)

---
-- Airwing Payloads
---

-- F-18 payloads.
local payloadF18_GCICAP=CVW9:NewPayload("F/A-18C Payload GCICAP", 0, {AUFTRAG.Type.GCICAP}, 100)

---
-- Start CVW-9
---

-- Start airwing.
CVW9:Start()

---
-- Produce Assets and Payloads.
---

-- A factory that produces weapons (airframes and payloads).
local factory=STATIC:FindByName("Static Factory Batumi")

-- Create an explosion at the factory after 17 minutes.
factory:GetCoordinate():Explosion(5000, 17*60)

-- Produce payloads every 10 min.
local function ProducePayloads()

  -- Check that factory is alive.
  if factory and factory:IsAlive() then
  
    -- Increase amount of payloads by one.
    CVW9:IncreasePayloadAmount(payloadF18_GCICAP, 1)
  
  end
  
  -- Get amount of available payloads.
  local N=CVW9:GetPayloadAmount(payloadF18_GCICAP)

  -- Info message to log file.
  env.info(string.format("Playloads available after production = %d", N))
end
-- Start a timer to simulate payload production.
TIMER:New(ProducePayloads):Start(2*60, 2*60)

-- Produce payloads every 10 min.
local function ProduceAssets()

  -- Check that factory is alive.
  if factory and factory:IsAlive() then
  
    -- Increase amount of payloads by one.
    CVW9:AddAssetToSquadron(VFA14, 1)
  
  end
  
  -- Count amount of assets in stock.
  local N=CVW9:CountAssets(true)

  -- Info message to DCS log file.
  env.info(string.format("Assets available after production = %d", N))
end
-- Start a timer to simulate asset production.
TIMER:New(ProduceAssets):Start(5*60, 5*60)

---
-- Status Display
---

--- Display status on screen.
local function Status()

  -- Amount of assets in stock.
  local N=CVW9:CountAssets(true)
  
  -- Abount of payloads in stock that can do GCICAP
  local n=CVW9:CountPayloadsInStock({AUFTRAG.Type.GCICAP})

  -- Info text.
  local text=string.format("Assets in stock: %d", N)  
  
  -- Payloads  
  text=text.."\nPayloads:"
  text=text..string.format("\n * GCICAP %d", n)
  
  -- Info message to all.
  MESSAGE:New(text, 25):ToAll()
end

-- Display primary and secondary mission status every 30 seconds.
TIMER:New(Status):Start(5, 30)
