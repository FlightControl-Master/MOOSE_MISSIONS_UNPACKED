-- The mission contains templates, which are late activated groups. Only the active groups should be included.
-- It should count 3 groups in DCS.log.

SetGroup = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterActive():FilterOnce()
SetGroup:Flush()
SetGroup:I( { Count = SetGroup:Count() } )

MESSAGE:NewType( "There are " .. SetGroup:Count() .. " groups in the SetGroup.", MESSAGE.Type.Information ):ToAll()
