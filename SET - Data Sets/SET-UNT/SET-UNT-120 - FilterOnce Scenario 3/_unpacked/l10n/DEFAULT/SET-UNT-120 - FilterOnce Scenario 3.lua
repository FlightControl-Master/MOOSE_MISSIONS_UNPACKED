SCHEDULER:New( nil,
  function()
    SetUnit = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterOnce()
    SetUnit:Flush()
    SetUnit:I( { Count = SetUnit:Count() } )
  end, {}, 0, 30 )
  
GroupPlanes = GROUP:FindByName( "Planes #001" )

GroupPlanes:HandleEvent( EVENTS.EngineShutdown )

function GroupPlanes:OnEventEngineShutdown( EventData )

  EventData.IniUnit:Destroy()

end