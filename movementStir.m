function [] = movementStir(Robot, GoalPose, Time, Objects)
%movementStir this function will simulate shaking for the robot
%   code mainly used from lab9
p1 = Robot.getPose;
iterations = 4
% movementCircle(Robot, GoalPose, Time, Objects)

for i=0:iterations  
    movementCircle(Robot, p1, Time/iterations, Objects);
    i
end

end

