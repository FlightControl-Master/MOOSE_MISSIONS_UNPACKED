---
-- This demo mission illustrates how to draw zones (circular and polygon) defined in the Mission Editor on the F10 map.
-- 
-- Furthermore, it shows how to create circles, rectangles, lines, arrows and text at arbitrary coordinates on the F10 map.
--- 

-- Circular zone defined in the ME.
local circzone=ZONE:New("Circular Zone")

-- Draw the zone on the F10 map. Colors are taken from the ME settings.
circzone:DrawZone()


-- Quad-point zone defined in the ME.
local quadzone=ZONE:New("Quad Zone") --Core.Zone#ZONE_POLYGON_BASE

-- Draw the zone on the F10 map. Colors are taken from the ME settings.
quadzone:DrawZone()

-- After 600 seconds, the drawing is removed.
quadzone:UndrawZone(500)


-- Polygon zone defined by waypoints of the group "Rotary-1". This surrounds a lake near Poti.
local polyzone=ZONE_POLYGON:NewFromGroupName("Rotary-1")

-- Draw the zone. Line color is green, fill color is turquoise with 50% alpha. Line type is dashed.
polyzone:DrawZone(-1, {0,1,0}, 1.0, {0,1,1}, 0.5, 2) 


-- Get coordinates of some airbases of the map.
local coordBatumi=AIRBASE:FindByName("Batumi"):GetCoordinate()
local coordKobuleti=AIRBASE:FindByName("Kobuleti"):GetCoordinate()
local coordGudauta=AIRBASE:FindByName(AIRBASE.Caucasus.Gudauta):GetCoordinate()
local coordKrymsk=AIRBASE:FindByName(AIRBASE.Caucasus.Krymsk):GetCoordinate()
local coordBeslan=AIRBASE:FindByName(AIRBASE.Caucasus.Beslan):GetCoordinate()
local coordNalchik=AIRBASE:FindByName(AIRBASE.Caucasus.Nalchik):GetCoordinate()
local coordMinVody=AIRBASE:FindByName(AIRBASE.Caucasus.Mineralnye_Vody):GetCoordinate()
local coordMozdok=AIRBASE:FindByName(AIRBASE.Caucasus.Mozdok):GetCoordinate()


-- Draw a circle with 15 km radius around Krymsk Airbase.
coordKrymsk:CircleToAll(15000)

-- Draw a rectancle. First corner is Gudauta. Opposite corner is 30000 meters in heading 135 degrees.
coordGudauta:RectToAll(coordGudauta:Translate(30000, 135))

-- Draw a quad-point shape. Corners are defined by the airbases.
coordBeslan:QuadToAll(coordNalchik, coordMinVody, coordMozdok, nil, {1,0,1}, nil, {0,1,0}, 0.8, 4)

-- Draw a blue line from Mozdok to Krymsk.
coordMozdok:LineToAll(coordKrymsk, nil, {0,0,1})

-- Draw a green arrow from Batumi to a ship group called "Naval-1". This arrow is only visible to the blue coalition.
coordBatumi:ArrowToAll(GROUP:FindByName("Naval-1"):GetCoordinate(), 2, {0,1,0})

-- Write text "Target Warehouse" at position of a static warehouse.
STATIC:FindByName("Static Warehouse-1"):GetCoordinate():TextToAll("Target Warehouse")