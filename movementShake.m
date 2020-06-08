function [qMatrix, steps] = movementShake(Robot, GoalPose, Time, objects, environment, axiss)
%movementShake this function will simulate shaking for the robot
%   
if ~exist('axiss','var')
    axiss = 1;
end

p1 = GoalPose;
p2 = Robot.getPose;

for i=0:4
    [q, s] = movementLine(Robot, Robot.model.getpos,transl(p1(1,4),p1(2,4),p1(3,4)), Time, axiss);
    if ~exist('qMatrix','var')
        qMatrix = q;        
    else
        qMatrix = [qMatrix;q];
    end
    if ~exist('steps','var')
        steps = s;        
    else
        steps = steps + s;
    end  
    [q, s] = movementLine(Robot, qMatrix(end,:),transl(p2(1,4),p2(2,4),p2(3,4)), Time, axiss);
    qMatrix = [qMatrix;q];
    steps = steps + s;
end
end

