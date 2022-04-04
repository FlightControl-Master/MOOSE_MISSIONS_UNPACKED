---
-- AUFTRAG: Cargo Transport
-- 
-- A UH-1H Huey is stationed at Batumi.
-- It is assigned to pick up three cargo crates in the vicinity and bring it to Batumi.
-- The transports are carried out in a well-defined order.
---

BASE:TraceOn()
BASE:TraceLevel(2)
BASE:TraceClass("OPSGROUP")
BASE:TraceClass("AUFTRAG")
AUFTRAG.verbose=3
OPSGROUP.verbose=3

-- Static cargo objects.
-- NOTE that
-- * We need the "UNIT NAME here (not the "NAME").
-- * It has to have the tick box "CAN BE CARGO" activated.
local staticAmmo=STATIC:FindByName("Static Ammo-1")
local staticBarrels=STATIC:FindByName("Static Barrels-1")
local staticOiltank=STATIC:FindByName("Static Oiltank-1")

-- Zone where to drop off the cargo.
-- NOTE that this has to be a zone defined in the ME!
local dropZone=ZONE:New("Drop Zone")

-- Create a flightgroup.
local helo=FLIGHTGROUP:New("Rotary-1")

-- Create mission to transport ammo. This has the highest prio (lowest value) so is done first.
local missionAmmo=AUFTRAG:NewCARGOTRANSPORT(staticAmmo, dropZone)
missionAmmo:SetPriority(30)

-- Create mission to transport barrels. This has lowest prio (highest value) so is done last.
local missionBarrels=AUFTRAG:NewCARGOTRANSPORT(staticBarrels, dropZone)
missionBarrels:SetPriority(70)

-- Create mission to transport an oil tank. This has medium prio and is done after the ammo but before the barrels.
local missionOiltank=AUFTRAG:NewCARGOTRANSPORT(staticOiltank, dropZone)
missionOiltank:SetPriority(50)

-- Assign mission to Huey crew.
helo:AddMission(missionAmmo)
helo:AddMission(missionBarrels)
helo:AddMission(missionOiltank)


