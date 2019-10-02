atisDubai=ATIS:New(AIRBASE.PersianGulf.Dubai_Intl, 131.7)
atisDubai:SetRadioRelayUnitName("Radio Relay Dubai Intl")
atisDubai:SetMetricUnits()
atisDubai:SetActiveRunway("R")
atisDubai:SetTowerFrequencies({251.05, 118.75})
atisDubai:Start()


atisAbuDhabi=ATIS:New(AIRBASE.PersianGulf.Abu_Dhabi_International_Airport, 125.1)
atisAbuDhabi:SetRadioRelayUnitName("Radio Relay Abu Dhabi International Airport")
atisAbuDhabi:SetMetricUnits()
atisAbuDhabi:SetActiveRunway("L")
atisAbuDhabi:SetTowerFrequencies({250.5, 119.2})
atisAbuDhabi:Start()


atisJiroft=ATIS:New(AIRBASE.PersianGulf.Jiroft_Airport, 130)
atisJiroft:SetMetricUnits()
atisJiroft:SetTowerFrequencies({250.75, 136})
atisJiroft:Start()


local airbases=AIRBASE.GetAllAirbases()
for _,_airbase in pairs(airbases) do
  local airbase=_airbase --Wrapper.Airbase#AIRBASE
  airbase:GetRunwayData(nil, true)
end