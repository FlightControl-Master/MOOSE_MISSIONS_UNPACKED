--- This makes a vehicle respawn itself within ZONEVEHICLE1.
-- The vehicle group consists of multiple units and are spawned in randomized within the new zone.
-- When the last vehicle of the group is destroyed, the group will respawn.
--
-- Name: GRP-620 - Respawn multiple units when destroyed
-- Author: FlightControl
-- Date Created: 01 Mar 2018

-- Find the Vehicle and create a GROUP object.
Vehicle = GROUP:FindByName( "Vehicle" )

-- Setup RespawnZone1 linking to the trigger zone ZONEVEHICLE1.
RespawnZone1 = ZONE:New( "ZONEVEHICLE1")

-- Prepare the spawning to be done in RespawnZone1.
Vehicle:InitZone( RespawnZone1 )
Vehicle:InitRandomizePositionZone( true )

Vehicle:HandleEvent( EVENTS.Dead )
function Vehicle:OnEventDead( EventData )

  self:E( { "Size ", Size = Vehicle:GetSize() } )
  
  -- When the last vehicle of the group is declared dead, respawn the group.
  if Vehicle:GetSize() == 1 then
    -- Respawn the vehicle in RespawnZone1.
    Vehicle:Respawn()
  end
end