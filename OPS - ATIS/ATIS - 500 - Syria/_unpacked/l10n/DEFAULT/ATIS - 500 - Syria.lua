
--[[

-- Beirut Rafic Hariri Airport
atisBeirut=ATIS:New(AIRBASE.Syria.Beirut_Rafic_Hariri, 130.0)
atisBeirut:SetRadioRelayUnitName("Radio Relay "..AIRBASE.Syria.Beirut_Rafic_Hariri)
atisBeirut:SetTowerFrequencies({251.450, 118.900, 39.850, 4.475})
atisBeirut:SetVOR(112.60)
atisBeirut:AddILS(109.5, "17")
atisBeirut:SetMapMarks()
atisBeirut:Start()

-- Damascus Airport
atisDamascus=ATIS:New(AIRBASE.Syria.Damascus, 131.0)
atisDamascus:SetRadioRelayUnitName("Radio Relay "..AIRBASE.Syria.Damascus)
atisDamascus:SetTowerFrequencies({251.500, 118.500, 39.900, 4.500})
atisDamascus:SetActiveRunway("R")
atisDamascus:SetVOR(116.00)
atisDamascus:AddILS(109.9, "23")
atisDamascus:SetMapMarks()
atisDamascus:Start()

-- Ramat David Airport
atisRamatDavid=ATIS:New(AIRBASE.Syria.Ramat_David, 132.0)
atisRamatDavid:SetRadioRelayUnitName("Radio Relay "..AIRBASE.Syria.Ramat_David)
atisRamatDavid:SetTowerFrequencies({251.000, 118.600, 39.400, 4.250})
atisRamatDavid:ReportQNHOnly()       -- More realitic as only QNH not QFE is reported.
atisRamatDavid:ReportZuluTimeOnly()  -- More realistic as 
atisRamatDavid:SetMapMarks()
atisRamatDavid:Start()

]]

PROFILER.Start()

-- Incirlik
atisIncirlik=ATIS:New(AIRBASE.Syria.Incirlik, 250.40)
atisIncirlik:SetRadioRelayUnitName("Radio Relay "..AIRBASE.Syria.Incirlik)
atisIncirlik:SetImperialUnits()
atisIncirlik:SetTACAN(21)
atisIncirlik:SetTowerFrequencies({250.350})
atisIncirlik:AddILS(109.30, "5")
atisIncirlik:AddILS(111.70, "23")
atisIncirlik:Start()