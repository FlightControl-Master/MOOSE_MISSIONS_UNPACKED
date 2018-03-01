--- This makes a vehicle respawn itself when the mission starts.
-- Name: GRP-600 - Respawn
-- Author: FlightControl
-- Date Created: 01 Mar 2018

-- Find the Vehicle and create a GROUP object.
Vehicle = GROUP:FindByName( "Vehicle" )

-- Respawn the vehicle.
Vehicle:Respawn()