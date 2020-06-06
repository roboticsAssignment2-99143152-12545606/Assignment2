function [q, s] = movementStir(Robot, GoalPose, Time, Objects)
%movementStir this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = Robot.getPose;

% movementCircle(Robot, GoalPose, Time, Objects)


%     movementCircle(Robot, p1, Time, Objects, 1);
[q, s] = movementCircle(Robot, p1, Time,1, 4)


end

