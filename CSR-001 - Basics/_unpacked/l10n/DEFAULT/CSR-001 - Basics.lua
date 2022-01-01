-------------------------------------------------------------------------
-- CSR-001 - Basics - Basic Demo
-------------------------------------------------------------------------
-- Documentation
-- 
-- AICSAR: https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Functional.AICSAR.html
-- 
-------------------------------------------------------------------------
-- Grab a flight and eject from the plane once the mission was loaded.
-- Follow your parachuting pilot. Once landing, a helicopter will launch
-- to pick you up and fly you to the MASH.
-------------------------------------------------------------------------
-- Date: Jan 2022
-------------------------------------------------------------------------

local my_aicsar=AICSAR:New("Luftrettung",coalition.side.BLUE,"Downed Pilot","Rescue Helo",AIRBASE:FindByName("Test FARP"),ZONE:New("MASH"))

