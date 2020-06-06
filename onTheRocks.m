function [] = onTheRocks(robots,objects,environment)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
pourPose = objects(2).getPose();

MoveWObjects(robots(2), objects(1).getPose(), [], []);
% MoveWObjects(robots(2), pourPose * troty(pi/2), [objects(1)], []);
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, pourPose ,2);
MoveQMatrix(robots(2), qMatrix, objects(1), [], 1);

[qMatrix, steps] = movementPour(robots(2), [], 2, objects,[], 50)
MoveQMatrix(robots(2), qMatrix, objects(1), [], 1);
[qMatrix, steps] = movementShake(robots(2), pourPose * transl(0,0,0.05), 5)
MoveQMatrix(robots(2), qMatrix, objects(1), [], 10);

end

