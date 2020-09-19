---
-- Name: AIC-PLN-000 - Airplane
-- Author: FlightControl
-- Date Created: 14 Apr 2018
--

VehicleCargoSet = SET_CARGO:New():FilterTypes( "Vehicles" ):FilterStart()


for i = 1, 10 do
  local WorkerGroup = GROUP:FindByName( string.format( "Vehicle #%03d", i ) )
  local WorkersCargo = CARGO_GROUP:New( WorkerGroup, "Vehicles", string.format( "Vehicle %d", i ), 5000, 35 )
  WorkersCargo:SetWeight(10000)
end

local Airplane = GROUP:FindByName( "Airplane" )

CargoAirplane = AI_CARGO_AIRPLANE:New( Airplane, VehicleCargoSet )


PickupAirbase = AIRBASE:FindByName( AIRBASE.Caucasus.Kobuleti )
DeployAirbases = { AIRBASE:FindByName( AIRBASE.Caucasus.Batumi ), AIRBASE:FindByName( AIRBASE.Caucasus.Gudauta ) }


CargoAirplane:Pickup( PickupAirbase:GetCoordinate() )

function CargoAirplane:OnAfterLoaded( Airplane, From, Event, To, Cargo )
  CargoAirplane:__Deploy(0.2, DeployAirbases[math.random(#DeployAirbases)]:GetCoordinate(), math.random( 500, 750 ) )
end


--function CargoAirplane:OnAfterUnloaded( Airplane, From, Event, To, Cargo )
function CargoAirplane:OnAfterDeployed(Airplane, From, Event, To, DeployZone)
  CargoAirplane:__Pickup(0.2, PickupAirbase:GetCoordinate(), math.random( 500, 750 ) )
end


