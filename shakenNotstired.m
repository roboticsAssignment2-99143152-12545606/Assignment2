function [] = shakenNotstired(robots,objects,environment)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
pourPose = transl(-0.8,-1.8,1.5);
pourPose = objects(2).getPose() * transl(0,0,0.1) * troty(pi/2);
placePose = objects(1).getPose() * troty(-pi/2);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-110),steps);
MoveQMatrix(robots(1),qMatrix,[],[]);

qMatrix(1:steps,1) = lspb(qMatrix(end,1),deg2rad(220),steps);
MoveQMatrix(robots(1),qMatrix,[objects(1)],[]);

[qMatrix, steps] = MoveWObjects(robots(1), pourPose, [objects(1)], []);

s = steps/2;
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(-180),s);

MoveQMatrix(robots(1),qMatrix,[objects(1)],[]);

[qMatrix, steps] = movementPour(robots(1), [], 2, objects,[], 50)

s = steps/2;
qMatrix(1:s,6) = lspb(deg2rad(-180),deg2rad(-220),s);
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(-90),s);

MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);

q = deg2rad([90,90,90,0,0,0])
[qMatrix, steps] = MoveWObjects(robots(1), q, [objects(1)], []);
MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);

[qMatrix, steps] = MoveWObjects(robots(1), placePose, [objects(1)], []);
qMatrix(1:steps,6) = lspb(qMatrix(1,6),deg2rad(-80),steps);
MoveQMatrix(robots(1), qMatrix, objects(1), [], 1);

%second arm
shakerPose = objects(3).getPose();
pickPose = objects(3).getPose();
[qMatrix, steps] = MoveWObjects(robots(2), pickPose, [], []);
MoveQMatrix(robots(2),qMatrix,[],[]);

glassPose = objects(2).getPose();
shakePose = objects(2).getPose() * transl(0,0,0.2);
[qMatrix, steps] = MoveWObjects(robots(2), shakePose, [], []);
MoveQMatrix(robots(2),qMatrix,[objects(3)],[]);

shakePose = objects(2).getPose() * transl(0,0,0);
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, shakePose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[objects(3)],[], 10);

shakePose = objects(2).getPose() * transl(0,0,0.3);
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, shakePose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[objects(3), objects(2)],[], 10);

[qMatrix, steps] = movementShake(robots(2), robots(2).getPose + transl(0,0,-0.2), 4, [objects(3), objects(2)], [], 2)
MoveQMatrix(robots(2),qMatrix,[objects(3), objects(2)],[], 50);

shakePose = glassPose;
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, shakePose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[objects(3), objects(2)],[], 10);

shakePose = glassPose * transl(0,0,0.2);
[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, shakePose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[objects(3)],[], 10);

[qMatrix, steps] = movementLine(robots(2), robots(2).model.getpos, shakerPose, 2, 2)
MoveQMatrix(robots(2),qMatrix,[objects(3)],[], 10);
end

