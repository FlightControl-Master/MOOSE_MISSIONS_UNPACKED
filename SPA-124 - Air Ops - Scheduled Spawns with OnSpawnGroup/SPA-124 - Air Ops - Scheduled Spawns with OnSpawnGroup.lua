----------------------------------------------------------------------
--SPA-124 - Air Ops - Scheduled Spawns with OnSpawnGroup() Escort Task
----------------------------------------------------------------------
 --//////////////////////////////////
 --////////////Tankers and awacs v1
 --//////////////////////////////////
--////////// By Targs35 /////////////
--//////////////// from 62nd Air Wing, Brisbane server..
--///////////////////////////////////
 ------- With thanks to the guys at MOOSE and in particular Pikes, Nolove, Delta99 and Wingthor
 -- Funky Frank is the man..
-----////////////////////////////////
--///////////  Spawn Tanker and Escorts  ///

  do
      
    local PointVec1 = POINT_VEC3:New( -100, 20, 80  ) -- This is a Vec3 class - defines the position of the escorts relative to the escorted group
    local PointVec2 = POINT_VEC3:New( -100, 20, 150  ) -- This is a Vec3 class - defines the position of the escorts relative to the escorted group
    
    --Create Spawn Groups, use the OnSpawnGroup() function to spawn two escorts and task them
       
    local Tanker_Texaco = SPAWN
      :New("Tanker_Texaco_Droge")
      :InitLimit( 1, 2 ) -- spawn 1 *alive* units max
      :InitCleanUp( 240 )
      :OnSpawnGroup(function (tanker) -- tanker contains the GROUP object when the tanker spawns
        local Escort_Texaco_1 = SPAWN
          :New("Escort_Texaco_F14 001")
          :InitLimit( 1, 2 )
          :InitCleanUp( 240 )
          :OnSpawnGroup(function (spawndgroup) -- spawndgrp contains the GROUP object when the escort spawns
            local FollowDCSTask1 = spawndgroup:TaskFollow( tanker, PointVec1 ) -- create task
            spawndgroup:SetTask( FollowDCSTask1, 1 ) -- push task on the GROUP
          end
          )
          :SpawnScheduled( 60, 0.5 )
        
        local Escort_Texaco_2 = SPAWN
          :New("Escort_Texaco_F14 002")
          :InitLimit( 1, 2 )
          :InitCleanUp( 240 )
          :OnSpawnGroup(function (spawndgroup) -- spawndgrp contains the GROUP object when the escort spawns
            local FollowDCSTask2 = spawndgroup:TaskFollow( tanker, PointVec2 )
            spawndgroup:SetTask( FollowDCSTask2, 1 )
          end
          )
          :SpawnScheduled( 60, 0.5 )     
      end
      )
      :SpawnScheduled( 60, 0.5 )

end
