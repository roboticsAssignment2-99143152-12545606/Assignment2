function [] = onTheRocks(robots,objects,environment)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

robots(1)

pourPose = transl(-0.8,-1.8,1.5);
pourPose = objects(2).getPose() * transl(0,0,0.1) * troty(pi/2);
placePose = objects(1).getPose() * troty(-pi/2);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-110),steps);
MoveQMatrix(robots(1),qMatrix,[],[]);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(110),steps);

[qMatrix, steps] = MoveWObjects(robots(1), pourPose, [objects(1)], []);

s = steps/2;
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(-120),s);

MoveQMatrix(robots(1),qMatrix,[objects(1)],[]);

[qMatrix, steps] = movementPour(robots(1), [], 2, objects,[], 50)

s = steps/2;
qMatrix(1:s,6) = lspb(deg2rad(-120),deg2rad(-90),s);
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(0),s);

MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);

q = deg2rad([90,90,90,0,0,0])
[qMatrix, steps] = MoveWObjects(robots(1), q, [objects(1)], []);
MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [objects(1)], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-60),steps);
MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);
end

