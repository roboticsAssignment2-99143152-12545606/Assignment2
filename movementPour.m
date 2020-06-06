function [qMatrix, steps] = movementPour(Robot, GoalPose, Time, Objects, environment,stepSize)
%movementPour this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = Robot.getPose;
% movementCircle(Robot, GoalPose, Time, Objects)
    [q, s] = movementCircle(Robot, p1, Time,3, 0.1)
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
    %     movementCircle(Robot, p1, Time/iterations, Objects, -3, 0.3);
    [q, s] = movementLine(Robot, qMatrix(end,:), transl(p1(1,4),p1(2,4)+0.2,p1(3,4)+0.1), Time);
    qMatrix = [qMatrix;q]
    steps = steps + s;
% qMatrix = [qMatrix1;qMatrix2];
% steps = steps1 + steps2;
pause(1);
end

