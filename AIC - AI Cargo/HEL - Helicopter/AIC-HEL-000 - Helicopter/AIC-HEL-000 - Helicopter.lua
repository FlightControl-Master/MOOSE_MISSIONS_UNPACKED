---
-- Name: AIC-HEL-000 - Helicopter
-- Author: FlightControl
-- Date Created: 13 Apr 2018
--

WorkerCargoSet = SET_CARGO:New():FilterTypes( "Workers" ):FilterStart()


for i = 1, 10 do
  local WorkerGroup = GROUP:FindByName( string.format( "Infantry#%03d", i ) )
  local WorkersCargo = CARGO_GROUP:New( WorkerGroup, "Workers", string.format( "Infantry %d", i ), 1000, 35 )
end

local Helicopter = GROUP:FindByName( "Helicopter" )

CargoHelicopter = AI_CARGO_HELICOPTER:New( Helicopter, WorkerCargoSet )


PickupZone = ZONE:New( "PickupZone" )
DeployZones = { ZONE:New( "DeployZone Alpha" ), ZONE:New( "DeployZone Beta" ), ZONE:New( "DeployZone Gamma" ) }

CargoHelicopter:Pickup( PickupZone:GetRandomCoordinate( 500, 200 ) )

function CargoHelicopter:onafterLoaded( Helicopter, From, Event, To, Cargo )
  CargoHelicopter:Deploy( DeployZones[math.random( 1, #DeployZones ) ]:GetRandomCoordinate( 500, 100 ), math.random( 50, 250 ) )
end


function CargoHelicopter:onafterUnloaded( Helicopter, From, Event, To, Cargo )
  CargoHelicopter:Pickup( PickupZone:GetRandomCoordinate( 500, 200 ), math.random( 50, 250 ) )
end


