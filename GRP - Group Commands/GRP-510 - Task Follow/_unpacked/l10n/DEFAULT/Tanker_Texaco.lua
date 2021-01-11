--Texaco

 --//////////////////////////////////
 --////////////Tankers and awacs v1
 --//////////////////////////////////
--////////// By Targs35 /////////////
--//////////////// from 62nd Air Wing, Brisbane server..
--///////////////////////////////////
 ------- With thanks to the guys at MOOSE and in particular Pikes, Nolove, Delta99 and Wingthor
 -- Funky Frank is the man..
-----////////////////////////////////
----/////////////////  Object names in ME  /
--- Names are used for both Group and UnitName --
---Tanker_Texaco_Droge
---Escort_Texaco
--/////////////////////////////////////
--///////////  Spawn Tanker and Escorts  ///

  ---its from here things get new for me, code below is in BETA

  do    
    --Create Spawn Groups
   
    local Tanker_Texaco = SPAWN:New("Tanker_Texaco_Droge"):InitLimit( 1, 10 ):SpawnScheduled( 60, .0 ):InitCleanUp( 240 )
    local Escort_Texaco_1 = SPAWN:New("Escort_Texaco_F15C-1"):InitLimit( 1, 20 ):SpawnScheduled( 120, .1 ):InitCleanUp( 240 )
    local Escort_Texaco_2 = SPAWN:New("Escort_Texaco_F15C"):InitLimit( 1, 20 ):SpawnScheduled( 120, .2 ):InitCleanUp( 240 )
    -- Now to spawn the ojects  
    --Texaco set Task
    --Spawn Groups into world
    local GroupTanker_Texaco = Tanker_Texaco:Spawn()
    local GroupEscort_Texaco_1 = Escort_Texaco_1:Spawn()
    local GroupEscort_Texaco_2 = Escort_Texaco_2:Spawn()


    local PointVec1 = POINT_VEC3:New( -100, 20, 80  ) -- This is a Vec3 class.
    local PointVec2 = POINT_VEC3:New( -100, 20, 150  ) -- This is a Vec3 class.
    local FollowDCSTask1 = GroupEscort_Texaco_1:TaskFollow( GroupTanker_Texaco, PointVec1:GetVec3() )
    local FollowDCSTask2 = GroupEscort_Texaco_2:TaskFollow( GroupTanker_Texaco, PointVec2:GetVec3() )
    GroupEscort_Texaco_1:SetTask( FollowDCSTask1, 1 )
    GroupEscort_Texaco_2:SetTask( FollowDCSTask2, 2 )


end

env.info("Tanker_Texaco Loaded v.03.5")


