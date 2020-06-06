function [qMatrix, steps] = movementShake(Robot, GoalPose, Time, objects, environment)
%movementShake this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = GoalPose;
p2 = Robot.getPose;

for i=0:4

    [q, s] = movementLine(Robot(1), Robot(1).model.getpos,transl(p1(1,4),p1(2,4),p1(3,4)), Time);

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
    
    [q, s] = movementLine(Robot(1), qMatrix(end,:),transl(p2(1,4),p2(2,4),p2(3,4)), Time);

    qMatrix = [qMatrix;q];
    steps = steps + s;
end
end

