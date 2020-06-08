function [] = stirredRumAndCoke(robots,objects,environment)
%STIRREDRUMANDCOKE Summary of this function goes here
%   Detailed explanation goes here

icePose = transl(0.5,-1.25,1.15);
[qMatrix, steps] = MoveWObjects(robots(1), icePose, [], []);
% qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-110),steps);
MoveQMatrix(robots(1),qMatrix,[],[]);

rumPose = objects(1).getPose;
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, rumPose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[],[], 10);

pourPose = objects(4).getPose() * transl(0,0,0.1) * troty(pi/2);
placePose = objects(1).getPose() * troty(-pi/2);

[qMatrix, steps] = MoveWObjects(robots(2), placePose, [], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-110),steps);
MoveQMatrix(robots(2),qMatrix,[],[]);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(110),steps);

[qMatrix, steps] = MoveWObjects(robots(2), pourPose, [objects(1)], []);
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, pourPose, 2, 1)
s = steps/2;
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(80),s);

MoveQMatrix(robots(2),qMatrix,[objects(1)],[]);

[qMatrix, steps] = movementPour(robots(2), [], 2, objects,[], 50)

s = steps/2;
qMatrix(1:s,6) = lspb(deg2rad(80),deg2rad(30),s);
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(180),s);

MoveQMatrix(robots(2), qMatrix, objects(1), [], 10);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(90),steps);
qMatrix(1:steps,2) = lspb(qMatrix(end,2),deg2rad(90),steps);
qMatrix(1:steps,3) = lspb(qMatrix(end,3),deg2rad(90),steps);
MoveQMatrix(robots(2),qMatrix,[objects(1)],[], 10);

q = deg2rad([90,90,90,0,0,0])
[qMatrix, steps] = MoveWObjects(robots(2), q, [objects(1)], []);
MoveQMatrix(robots(2), qMatrix, objects(1), [], 1);

[qMatrix, steps] = MoveWObjects(robots(2), placePose, [objects(1)], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-40),steps);
MoveQMatrix(robots(2), qMatrix, objects(1), [], 1);

%pick up and do soda
pourPose = objects(4).getPose() * transl(0,0,0.1) * troty(pi/2);
placePose = objects(2).getPose() * troty(pi/2);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [], []);
[qMatrix, steps] = movementLine(robots(1), robots(1).model.getpos, placePose, 2, 1)
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-110),steps);
MoveQMatrix(robots(1),qMatrix,[],[]);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(110),steps);

[qMatrix, steps] = MoveWObjects(robots(1), pourPose, [objects(2)], []);
[qMatrix, steps] = movementLine(robots(1), robots(1).model.getpos, pourPose, 2, 1)
s = steps/2;
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(-180),s);

MoveQMatrix(robots(1),qMatrix,[objects(2)],[]);

[qMatrix, steps] = movementPour(robots(1), [], 2, objects,[], 50)

s = steps/2;
qMatrix(1:s,6) = lspb(deg2rad(-180),deg2rad(-130),s);
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(-90),s);

MoveQMatrix(robots(1), qMatrix, objects(2), [], 10);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(90),steps);
qMatrix(1:steps,2) = lspb(qMatrix(end,2),deg2rad(90),steps);
qMatrix(1:steps,3) = lspb(qMatrix(end,3),deg2rad(90),steps);
MoveQMatrix(robots(1),qMatrix,[objects(2)],[], 10);

q = deg2rad([90,90,90,0,0,0])
[qMatrix, steps] = MoveWObjects(robots(1), q, [objects(2)], []);
MoveQMatrix(robots(1), qMatrix, objects(2), [], 1);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [objects(2)], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(200),steps);
MoveQMatrix(robots(1), qMatrix, objects(2), [], 1);

% come back to stir
spoonPose = objects(5).getPose;
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, spoonPose * transl(0,0,0.25), 2, 2);
MoveQMatrix(robots(2), qMatrix, [], [], 1);

robotxyzpose = robots(2).getPose
robotxyzpose = robotxyzpose(1:3,4)'
[qMatrix, steps] = MoveWObjects(robots(2), transl(robotxyzpose(1),robotxyzpose(2),robotxyzpose(3)) * trotz(pi), [objects(2)], []);
MoveQMatrix(robots(2), qMatrix, [], [], 5);

[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, spoonPose, 2, 2);
MoveQMatrix(robots(2), qMatrix, [], [], 1);

[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, spoonPose * transl(0,0,0.25), 2, 2);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 1);

glassPose = objects(4).getPose;
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, glassPose * transl(0,0,0.25), 2, 2);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 1);

robotxyzpose = robots(2).getPose
robotxyzpose = robotxyzpose(1:3,4)'
[qMatrix, steps] = MoveWObjects(robots(2), transl(robotxyzpose(1),robotxyzpose(2),robotxyzpose(3)) * trotz(pi), [objects(2)], []);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 5);

[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, glassPose * transl(0,0,0.1), 2, 2);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 1);

[qMatrix, steps] = movementStir(robots(2), [], 4, []);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 4);

[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, glassPose * transl(0,0,0.25), 2, 2);
MoveQMatrix(robots(2), qMatrix, [objects(5)], [], 1);

q = deg2rad([90,90,90,0,0,0])
[qMatrix, steps] = MoveWObjects(robots(2), q, [objects(2)], []);
MoveQMatrix(robots(2), qMatrix,[], [], 1);

end

