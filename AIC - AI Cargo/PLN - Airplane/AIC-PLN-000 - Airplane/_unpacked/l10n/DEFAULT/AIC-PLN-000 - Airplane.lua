---
-- Name: AIC-PLN-000 - Airplane
-- Author: FlightControl
-- Date Created: 14 Apr 2018
--

VehicleCargoSet = SET_CARGO:New():FilterTypes( "Vehicles" ):FilterStart()


for i = 1, 10 do
  local WorkerGroup = GROUP:FindByName( string.format( "Vehicle #%03d", i ) )
  local WorkersCargo = CARGO_GROUP:New( WorkerGroup, "Vehicles", string.format( "Vehicle %d", i ), 5000, 35 )
end

local Airplane = GROUP:FindByName( "Airplane" )

CargoAirplane = AI_CARGO_AIRPLANE:New( Airplane, VehicleCargoSet )


PickupAirbase = AIRBASE:FindByName( AIRBASE.Caucasus.Kobuleti )
DeployAirbases = { AIRBASE:FindByName( AIRBASE.Caucasus.Batumi ), AIRBASE:FindByName( AIRBASE.Caucasus.Gudauta ) }


CargoAirplane:Pickup( PickupAirbase )

function CargoAirplane:onafterLoaded( Airplane, From, Event, To, Cargo )
  CargoAirplane:Deploy( DeployAirbases[math.random( 1, #DeployAirbases ) ], math.random( 50, 250 ) )
end


function CargoAirplane:onafterUnloaded( Airplane, From, Event, To, Cargo )
  CargoAirplane:Pickup( PickupAirbase, math.random( 50, 250 ) )
end


