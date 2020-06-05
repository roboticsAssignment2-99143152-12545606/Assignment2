function [] = MoveQMatrix(Robot_Arm,qMatrix,Objects,Environment,stepsize)
%UNTITLED4 Summary of this function goes here
%   This function will now pause movement until the obstacle has been
%   moved

if ~exist('stepsize')
    stepsize = 1;
end

for qStep = 1:stepsize:size(qMatrix,1)
    q = qMatrix(qStep,:);
    % First assign to true, so it enters the checking loop for this
    % iteration of qMatrix
    colResult = true;
    % Loop here
    while colResult == true
        for i = 1:size(Environment,2)
            colResult = IsCollision(Robot_Arm.model,qMatrix,Environment(i).model.faces,...
                Environment(i).model.points,Environment(i).faceNormals,'1');
            % Return as soon as a collision is detected
            if colResult == true
                return
            end
        end
    end
    
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

