-- Create a group set.
SetVehicles = SET_GROUP:New()

-- Add groups by name to the set.
SetVehicles:AddGroupsByName( { "Vehicle A", "Vehicle B", "Vehicle C" } )

-- For each unit in the set, smoke the unit green. So, for each unit in the 3 groups within the set, the smoke will be triggered.
SetVehicles:ForEachGroup( 
  --- @param Wrapper.Group#GROUP MooseGroup
  function( MooseGroup ) 
    for UnitId, UnitData in pairs( MooseGroup:GetUnits() ) do
      local UnitAction = UnitData -- Wrapper.Unit#UNIT
      UnitAction:SmokeGreen()
    end
  end 
)


-- Now we remove Vehicle A.
SetVehicles:RemoveGroupsByName( { "Vehicle A" } )

-- So Vehicle A should not be smoking now in a red color.
SetVehicles:ForEachGroup( 
  --- @param Wrapper.Group#GROUP MooseGroup
  function( MooseGroup ) 
    for UnitId, UnitData in pairs( MooseGroup:GetUnits() ) do
      local UnitAction = UnitData -- Wrapper.Unit#UNIT
      UnitAction:SmokeRed()
    end
  end 
)
