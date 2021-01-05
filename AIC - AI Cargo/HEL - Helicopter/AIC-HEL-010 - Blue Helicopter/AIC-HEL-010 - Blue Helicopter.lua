---
-- Name: AIC-HEL-000 - Helicopter
-- Author: FlightControl
-- Date Created: 13 Apr 2018
-- Date Checked: 01 Jan 2021
-- Updated Moose, needs fix #1417 to work
-- 
BASE:TraceClass("AI_CARGO")
BASE:TraceClass("AI_CARGO_HELICOPTER")
BASE:TraceOn()

WorkerCargoSet = SET_CARGO:New():FilterTypes( "Workers" ):FilterStart()


for i = 1, 5 do
  local WorkerGroup = GROUP:FindByName( string.format( "Infantry %03d", i ) )
  local WorkersCargo = CARGO_GROUP:New( WorkerGroup, "Workers", string.format( "Infantry %d", i ), 750, 35 )
end

local Helicopter = GROUP:FindByName( "Helicopter" )

CargoHelicopter = AI_CARGO_HELICOPTER:New( Helicopter, WorkerCargoSet )


PickupZone = ZONE:New( "PickupZone" )
DeployZones = { ZONE:New( "DeployZone Alpha" ), ZONE:New( "DeployZone Beta" ), ZONE:New( "DeployZone Gamma" ) }

CargoHelicopter:Pickup( PickupZone:GetRandomCoordinate( 400, 100 ) )

function CargoHelicopter:OnAfterLoaded( Helicopter, From, Event, To, Cargo )
  CargoHelicopter:__Deploy(5,DeployZones[math.random( 1, #DeployZones ) ]:GetRandomCoordinate( 500, 100 ), math.random( 50, 250 ) )
end


function CargoHelicopter:OnAfterUnloaded( Helicopter, From, Event, To, Cargo )
  CargoHelicopter:__Pickup( 5,PickupZone:GetRandomCoordinate( 500, 200 ), math.random( 50, 250 ) )
end

