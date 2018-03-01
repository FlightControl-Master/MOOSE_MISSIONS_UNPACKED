--- This makes a vehicle respawn itself when the mission starts.
-- The vehicle is hidden, so you need to observe from the watch tower!
-- Name: GRP-601 - Respawn hidden
-- Author: FlightControl
-- Date Created: 01 Mar 2018

-- Find the Vehicle and create a GROUP object.
Vehicle = GROUP:FindByName( "Vehicle" )

-- Respawn the vehicle.
Vehicle:Respawn()