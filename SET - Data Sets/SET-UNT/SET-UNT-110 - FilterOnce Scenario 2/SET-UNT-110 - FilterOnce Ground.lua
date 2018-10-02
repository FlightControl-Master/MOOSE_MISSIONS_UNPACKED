SetUnit = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterOnce()
SetUnit:Flush()
SetUnit:I( { Count = SetUnit:Count() } )

SCHEDULER:New( nil,
  function()
    SetUnit = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterOnce()
    SetUnit:Flush()
    SetUnit:I( { Count = SetUnit:Count() } )
  end, {}, 60 )

