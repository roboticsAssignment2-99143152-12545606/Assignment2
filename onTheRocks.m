function [] = onTheRocks(robots,objects,environment)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

robots(1)

pourPose = transl(-0.8,-1.8,1.5);

MoveWObjects(robots(1), objects(1).getPose(), [], []);
MoveWObjects(robots(1), pourPose, [objects(1)], []);
movementPour(robots(1), [], 10, objects,[], 50)

end

