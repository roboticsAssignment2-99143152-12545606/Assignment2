function [] = movementShake(Robot, GoalPose, Time, Objects)
%movementShake this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = Robot.getPose;

for i=0:4
    movementLine(Robot, transl(p1(1,4),p1(2,4),p1(3,4) + 0.5), Time, Objects);
    movementLine(Robot, transl(p1(1,4),p1(2,4),p1(3,4)), Time, Objects);
end
end

