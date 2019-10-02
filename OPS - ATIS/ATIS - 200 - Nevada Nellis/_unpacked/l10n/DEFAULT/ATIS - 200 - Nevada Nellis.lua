
-- ATIS Nellis AFB on 270.100 MHz AM.
atisNellis=ATIS:New(AIRBASE.Nevada.Nellis_AFB, 270.100)
atisNellis:SetRadioRelayUnitName("Radio Relay Nellis")
atisNellis:SetActiveRunway("21L")
atisNellis:SetTowerFrequencies({327.000, 132.550})
atisNellis:Start()


local airbases=AIRBASE.GetAllAirbases()
for _,_airbase in pairs(airbases) do
  local airbase=_airbase --Wrapper.Airbase#AIRBASE
  airbase:GetRunwayData(nil, true)
end