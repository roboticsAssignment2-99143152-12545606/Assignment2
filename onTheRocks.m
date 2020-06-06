function [] = onTheRocks(robots,objects,environment)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

robots(1)

pourPose = transl(-0.8,-1.8,1.5);

MoveWObjects(robots(1), objects(1).getPose(), [], []);
MoveWObjects(robots(1), pourPose, [objects(1)], []);

[qMatrix, steps] = movementPour(robots(1), [], 2, objects,[], 50)
MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);
[qMatrix, steps] = movementShake(robots(1), pourPose * transl(0,0,0.1), 5)
MoveQMatrix(robots(1), qMatrix, objects(1), [], 50);

end

