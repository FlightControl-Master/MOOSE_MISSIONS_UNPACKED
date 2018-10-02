-- The mission contains templates, which are late activated groups. Only the active units should be included.
-- It should count 24 units in DCS.log.

SetUnit = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterActive():FilterOnce()
SetUnit:Flush()
SetUnit:I( { Count = SetUnit:Count() } )

MESSAGE:NewType( "There are " .. SetUnit:Count() .. " units in the SetUnit.", MESSAGE.Type.Information ):ToAll()
