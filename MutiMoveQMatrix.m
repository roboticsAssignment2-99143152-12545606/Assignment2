function [outputArg1,outputArg2] = MutiMoveQMatrix(Robot_Arm1,qMatrix1,Objects1,Environment1,stepsize1,...
    Robot_Arm2,qMatrix2,Objects2,Environment2,stepsize)
%MUTIMOVEQMATRIX Summary of this function goes here
%   Detailed explanation goes here
if ~exist('stepsize1','var')
    stepsize = 1;
end
if ~exist('stepsize2','var')
    stepsize = 1;
end
qSize = size(qMatrix1,1);
if size(qMatrix2,1) > qSize
    qSize = size(qMatrix2,1);
end
for qStep = 1:stepsize:qSize
    if qStep < size(qMatrix1,1)
        q = qMatrix1(qStep,:);
        colResult = false;
        
        
        % Check joy, if 0 joystick is not initialised
        if Robot_Arm1.NOJOY == true
            % Do nothing and skip the ESTOP check
        else
            try estop = Robot_Arm.checkJoy();
            catch estop = 0;
            end
            
            % This checks for ESTOP
            if estop == 0
                % Do nothing and continue - No estop present
            else
                disp('ESTOP DETECTED - HALTING ALL ACTIONS')
                return
            end
        end
        
        
        for i = 1:size(Environment1,2)
            colResult = IsCollision(Robot_Arm.model,qMatrix,Environment1(i).model.faces,...
                Environment1(i).model.points,Environment1(i).faceNormals,'1');
        end
        
        if colResult == true
            disp('Collision detected')
        else
            Robot_Arm1.model.animate(q);
            if isempty(Objects1) == 0
                newBase = Robot_Arm1.model.fkine(q);
            end
            for i = 1:size(Objects,2)
                Objects1(i).model.base = newBase * trotx(Objects1(i).rot);
                Objects1(i).model.animate(0);
            end
            pause(0.01);
        end
    end
    if qStep < size(qMatrix2,1)
        q = qMatrix2(qStep,:);
        colResult = false;
        
        
        % Check joy, if 0 joystick is not initialised
        if Robot_Arm2.NOJOY == true
            % Do nothing and skip the ESTOP check
        else
            try estop = Robot_Arm.checkJoy();
            catch estop = 0;
            end
            
            % This checks for ESTOP
            if estop == 0
                % Do nothing and continue - No estop present
            else
                disp('ESTOP DETECTED - HALTING ALL ACTIONS')
                return
            end
        end
        
        
        for i = 1:size(Environment2,2)
            colResult = IsCollision(Robot_Arm.model,qMatrix,Environment2(i).model.faces,...
                Environment2(i).model.points,Environment2(i).faceNormals,'1');
        end
        
        if colResult == true
            disp('Collision detected')
        else
            Robot_Arm2.model.animate(q);
            if isempty(Objects2) == 0
                newBase = Robot_Arm2.model.fkine(q);
            end
            for i = 1:size(Objects,2)
                Objects2(i).model.base = newBase * trotx(Objects2(i).rot);
                Objects2(i).model.animate(0);
            end
            pause(0.01);
        end
    end
end


end

