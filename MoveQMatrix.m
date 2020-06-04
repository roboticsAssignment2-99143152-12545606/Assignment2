function [] = MoveQMatrix(Robot_Arm,qMatrix,Objects,colCheck)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

for qStep = 1:size(qMatrix,1)
    q = qMatrix(qStep,:);
    
    for i = 1:size(colCheck)
        colResult = IsCollision(Robot_Arm,qMatrix,colCheck(i).model.faces,...
            colCheck(i).model.points,colCheck(i).model.faceNormals,'1');
    end
    
%     if colResult == true
%         disp('Collision detected');
%     else
        Robot_Arm.model.animate(q);
        if isempty(Objects) == 0
            newBase = Robot_Arm.model.fkine(q);
        end
        for i = 1:size(Objects,2)
            Objects(i).model.base = newBase * trotx(Objects(i).rot);
            Objects(i).model.animate(0);
        end
        pause(0.01);
%     end
end

end

