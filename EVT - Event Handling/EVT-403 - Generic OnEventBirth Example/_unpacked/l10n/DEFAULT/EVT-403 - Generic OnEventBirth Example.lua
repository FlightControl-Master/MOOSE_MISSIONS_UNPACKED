---
-- Name: EVT-401 - Generic OnEventHit Example
-- Author: FlightControl
-- Date Created: 15 February 2017
--
-- # Situation:
--
-- Ground targets are shooting each other.
-- 
-- # Test cases:
-- 
-- 1. Observe the ground forces shooting each other.
-- 2. Observe when a tank receives a hit, a dcs.log entry is written in the logging.
-- 3. The generic EventHandler objects should receive the hit events.

CC = COMMANDCENTER:New( GROUP:FindByName( "HQ" ), "HQ" )

EventHandler1 = EVENTHANDLER:New()


EventHandler1:HandleEvent( EVENTS.Birth )

--- @param Core.Event#EVENT self
-- @param Core.Event#EVENTDATA EventData
function EventHandler1:OnEventBirth( EventData )
  self:E("hello 1")
  self:E( EventData.IniUnit:GetName() )
  CC:GetPositionable():MessageToAll( "I just got born!", 15 , "Alert!" )
end



