
CC = COMMANDCENTER:New( GROUP:FindByName( "HQ"), "Maupertus HQ")

MissionMedical = MISSION:New( CC, "Rescue General", "Urgent", "Rescue the General", coalition.side.BLUE )

SetGroupRescue = SET_GROUP:New():FilterPrefixes( "Hero" ):FilterOnce()
SetCargoGeneral = SET_CARGO:New():FilterPrefixes( "General" ):FilterOnce()

TaskMedicalTransport = TASK_CARGO_DISPATCHER:New( MissionMedical, SetGroupRescue )
TaskMedicalTransport:AddTransportTask( "Rescue", SetCargoGeneral, "Rescue the wounded general at the airbase Picauville" )

function TaskMedicalTransport:OnAfterCargoPickedUp( From, Event, After, Task, TaskPrefix, TaskUnit, Cargo )
  MESSAGE:NewType( "Now fly to the airbase Maupertus to transfer the general to the waiting B-17.", MESSAGE.Type.Briefing )
end

function TaskMedicalTransport:OnAfterCargoDeployed( From, Event, To, Task, TaskPrefix, TaskUnit, Cargo, DeployZone )
  MESSAGE:NewType( "OK, you have successfully transferred the general, now ensure the B-17 reaches its destination within the UK.", MESSAGE.Type.Briefing )
  Cargo:SetDeployed( false )
end



-- Enemy defenses

-- Now we will make some random defenses between Picauville and Maupertus.

-- The ZONE_POLYGON object "Enemy Defense Area" has alraedy been declared with the #ZONE_POLYGON tag within the mission editor.
-- We just need to find it.

EnemyArea = ZONE_POLYGON:FindByName( "Enemy Area" )

-- Here we spawn in the air defenses, based on the templates starting with the Enemy Defenses...
SpawnDefenses = SPAWN:New( "SpawnDefenses" ):InitLimit( 50, 10 ):InitRandomizeTemplatePrefixes( { "Enemy Defense" } ):InitRandomizeZones( { EnemyArea } ):SpawnScheduled( 60, 0 )



