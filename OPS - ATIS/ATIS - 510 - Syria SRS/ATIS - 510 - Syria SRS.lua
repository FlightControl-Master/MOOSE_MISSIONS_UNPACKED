---
-- SRS:
-- SRS version 1.9.6.0+ required. See https://github.com/ciribob/DCS-SimpleRadioStandalone
-- SRS is installed in the D:\DCS\_SRS directory. NOTE that backslashes need to be escaped and you have to adjust the directory for you personal install path.
---


-- Damascus Airport: Use male voice with en-US culture (accent)
atisDamascus=ATIS:New(AIRBASE.Syria.Damascus, 250.00)
atisDamascus:SetSRS("D:\\DCS\\_SRS", "male", "en-US")
atisDamascus:SetTowerFrequencies({251.500, 118.500, 39.900, 4.500})
atisDamascus:SetActiveRunway("R")
atisDamascus:SetVOR(116.00)
atisDamascus:AddILS(109.9, "23")
atisDamascus:SetMapMarks()
atisDamascus:Start()


-- Incirlik: Use specific voice named "Microsoft Hedda Desktop", which is a female German adult. Hope you don't mind the accent too much ;)
atisIncirlik=ATIS:New(AIRBASE.Syria.Incirlik, 251.50)
atisIncirlik:SetSRS("D:\\DCS\\_SRS", nil, nil, "Microsoft Hedda Desktop")
atisIncirlik:SetImperialUnits()
atisIncirlik:SetTACAN(21)
atisIncirlik:SetTowerFrequencies({250.350})
atisIncirlik:AddILS(109.30, "5")
atisIncirlik:AddILS(111.70, "23")
atisIncirlik:Start()


