function [] = MoveQMatrix(Robot_Arm,qMatrix,Objects,Environment,stepsize)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if ~exist('stepsize')
    stepsize = 1;
end

for qStep = 1:stepsize:size(qMatrix,1)
    q = qMatrix(qStep,:);
    colResult = false;
    

    % Check joy, if 0 joystick is not initialised
    if Robot_Arm.NOJOY == true
        % Do nothing and skip the ESTOP check
    else
        estop = Robot_Arm.checkJoy();
        
        % This checks for ESTOP
        if estop == 0
            % Do nothing and continue - No estop present
        else
            disp('ESTOP DETECTED - HALTING ALL ACTIONS')
            return
        end
    end

    
    for i = 1:size(Environment,2)
        colResult = IsCollision(Robot_Arm.model,qMatrix,Environment(i).model.faces,...
            Environment(i).model.points,Environment(i).faceNormals,'1');
    end
    
    if colResult == true
        disp('Collision detected')
    else
        Robot_Arm.model.animate(q);
        if isempty(Objects) == 0
            newBase = Robot_Arm.model.fkine(q);
        end
        for i = 1:size(Objects,2)
            Objects(i).model.base = newBase * trotx(Objects(i).rot);
            Objects(i).model.animate(0);
        end
        pause(0.01);
    end
end

end

