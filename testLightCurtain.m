function [] = testLightCurtain(IntShape, lightCurtain)
% Set the initial starting point of the object
IntShape.model.base = transl([0,-4,1.5]);
IntShape.model.animate(0);
    
intersect = false;

while (intersect == false)
    IntShape.model.base = IntShape.model.base * transl([0, 0.1, 0]);
    IntShape.model.animate(0);
    
    [objPoints, objFaces, objNormals] = IntShape.getPLYData()

    % Go through each link and also each triangle face
    for i = 1 : 18
        for faceIndex = 1:size(objFaces,1)
            vertOnPlane = objPoints(objFaces(faceIndex,1)',:);
            [intersectP,check] = LinePlaneIntersection(objNormals(faceIndex,:),vertOnPlane,...
                            [lightCurtain.X(1),lightCurtain.Y(1),(lightCurtain.Z(1)-(i/10))],[lightCurtain.X(2),lightCurtain.Y(2),(lightCurtain.Z(2)-(i/10))]);
    %         disp(check)
            if check == 1 && IsIntersectionPointInsideTriangle(intersectP,objPoints(objFaces(faceIndex,:)',:))
                disp('Intersection')
                plot3(intersectP(1),intersectP(2),intersectP(3),'g*')
                intersect = true;
            end
        end
    end
    pause(1)
end

end

