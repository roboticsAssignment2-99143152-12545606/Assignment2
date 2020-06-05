function [] = MoveQMatrix(Robot_Arm,qMatrix,Objects,Environment,stepsize)
%UNTITLED4 Summary of this function goes here
%   This function will now pause movement until the obstacle has been
%   moved

if ~exist('stepsize')
    stepsize = 1;
end

for qStep = 1:stepsize:size(qMatrix,1)
    q = qMatrix(qStep,:);
    
    for i = 1:size(Environment,2)
        colResult = IsCollision(Robot_Arm.model,qMatrix,Environment(i).model.faces,...
            Environment(i).model.points,Environment(i).faceNormals,'1');
        
        if colResult == true
            disp('COLLISION')
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

