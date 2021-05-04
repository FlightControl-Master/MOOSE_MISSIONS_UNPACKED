
-- ATIS Batumi Airport on 143.00 MHz AM.
atisBatumi=ATIS:New(AIRBASE.Caucasus.Batumi, 143.00)
atisBatumi:SetRadioRelayUnitName("Radio Relay Batumi")
atisBatumi:SetTowerFrequencies({260, 131})
atisBatumi:Start()

-- ATIS Vaziani Airport on 144.00 MHz AM.
atisVaziani=ATIS:New(AIRBASE.Caucasus.Vaziani, 144.00)
atisVaziani:SetRadioRelayUnitName("Radio Relay Vaziani")
atisVaziani:SetTowerFrequencies({269, 140})
atisVaziani:Start()

local airbases=AIRBASE.GetAllAirbases()
for _,_airbase in pairs(airbases) do
  local airbase=_airbase --Wrapper.Airbase#AIRBASE
  airbase:GetRunwayData(nil, true)
end
