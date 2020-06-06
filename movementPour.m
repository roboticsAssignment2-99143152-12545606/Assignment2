function [] = movementPour(Robot, GoalPose, Time, Objects, environment,stepSize)
%movementPour this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = Robot.getPose;
iterations = 1
% movementCircle(Robot, GoalPose, Time, Objects)
motions = 0;
for i=1:iterations
    movementCircle(Robot, p1, Time/(iterations+motions), Objects, environment,3, 0.3, stepSize);
    %     movementCircle(Robot, p1, Time/iterations, Objects, -3, 0.3);
    movementLine(Robot, transl(p1(1,4),p1(2,4)+0.2,p1(3,4)+0.2), Time/(iterations+motions), Objects, environment, stepSize);
end

end

