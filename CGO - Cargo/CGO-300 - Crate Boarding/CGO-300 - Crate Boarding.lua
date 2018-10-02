
Barrels = STATIC:FindByName( "Barrels" )
CargoBarrels = CARGO_CRATE:New( Barrels, "EAQ-234-432" )

CargoCarrier = UNIT:FindByName( "Carrier" )

-- This call will make the Cargo run to the CargoCarrier.
-- Upon arrival at the CargoCarrier, the Cargo will be Loaded into the Carrier.
-- This process is now fully automated.
CargoBarrels:Load( CargoCarrier ) 

