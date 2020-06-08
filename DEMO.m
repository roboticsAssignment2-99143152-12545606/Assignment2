%% Summary
% This program was created for Assignment Task 2 of Robotics

%% Authors
% James Walsh
% Jonathan Wilde - 12545606

function [] = DEMO()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% init
close all
set(0,'DefaultFigureWindowStyle','docked')
clear
clc
% Mac run command
% run /Users/jonathanwilde/git/Robotics/rvctools/startup_rvc.m
% Windows run command
% run C:\Git\Robotics\rvctools\startup_rvc.m

%% Setup joystick as ESTOP
[JS_1, joy, joy_info, NOJOY] = JoystickClass();

if NOJOY == true
    disp('Joystick has not been initialised')
else
    disp('Joystick initialised')
end

%%
hold on
% floorOffset = -0.8905/2; %measured from bounding box
% workSize = 10;N6
% workspace = [-workSize workSize -workSize workSize (2*0) workSize];
workspace = [-3 3 -5 5 0 5]

% setting up environment
van = Objects('Van', '1', workspace, transl(0,0,0), 0);
eStop1 = Objects('E-Stop', '2', workspace, transl(-1,1,1.4), pi/2);

% Set up light curtain
lightCurtain.X = [-0.95, 0.8];
lightCurtain.Y = [-2.9, -2.9];
lightCurtain.Z = [2.3, 2.3];

for lineIt = lightCurtain.Z(1):-0.1:0.5
    plot3(lightCurtain.X,lightCurtain.Y,[lineIt, lineIt],'--r','LineWidth',0.1);
end

% setting up objects
wildT = Objects('WildTurkey','3',workspace, transl(0.6,-1.85,1.75), -pi/2);
smirn = Objects('Smirnoff', '4', workspace, transl(0.6,-1.65,1.75), -pi/2);
soda = Objects('Soda', '5', workspace, transl(0.6,-2.05,1.80), -pi/2);
bulmers = Objects('Bulmers', '6', workspace, transl(0.6,-2.30,1.84), -pi/2);
glass = Objects('Glass', '7', workspace, transl(-0.5,-2,1.45), -pi/2);
shaker = Objects('ShakerAssy', '8', workspace, transl(-0.5,-1.6,1.45), -pi/2);

% Enable this shaker top for collision testing
shakerTop = Objects('Shaker', '9', workspace, transl(-0.5,-2,1.55), -pi/2);

% setting up  models
N6_1 = D6Model('N6_1',workspace, transl(-0.05,-1.6,0.605));
N6_2 = D6Model('N6_2',workspace, transl(-0.05,-2.4,0.605));

% Assign joystick to each robot
N6_1.setJoy(JS_1, joy, NOJOY);
N6_2.setJoy(JS_1, joy, NOJOY);

% N6_1.model.teach();
q = deg2rad([90,90,90,0,0,0])
N6_1.model.animate(q);
N6_2.model.animate(q);

%% this section does shaking

MoveWObjects(N6_1, shaker.getPose() * transl(0,0.5,0.2) * troty(pi/2), [],[]);
P = N6_1.getPose;
P = P(1:3,4)';
[qMatrix, steps] = movementShake(N6_1, transl(P) * transl(0,0,0.25), 1, [])
s = steps;
qMatrix(1:end,6) = ones(s,1) .* deg2rad(90);
MoveQMatrix(N6_1, qMatrix, [shaker], [], 10);
'done'
return

%% this section does stiring

MoveWObjects(N6_1, glass.getPose() * transl(0,0,-0.05), [],[shakerTop]);

[qMatrix, steps] = movementStir(N6_1, [], 10, [])

MoveQMatrix(N6_1, qMatrix, [], [shakerTop], 10);
'done'
return

%% this section do pouring 
MoveWObjects(N6_1, glass.getPose() * transl(0,0,0.02), [],[]);

[qMatrix, steps] = movementPour(N6_1, [], 10, [smirn], 200)

s = steps/2;
qMatrix((s+1):end,6) = lspb(qMatrix(s,6),deg2rad(90),s);

MoveQMatrix(N6_1, qMatrix, [smirn], [], 10);
%onTheRocks([N6_1, N6_2],[wildT],van);
'done'
return

%% this section to check light curtain
Square = Objects('Square', '1', workspace, transl([0,-4,1.5]), 0);

intersect = false;

while (intersect == false)
    Square.model.base = Square.model.base * transl([0, 0.1, 0]);
    Square.model.animate(0);
    
    objPoints = cell2mat(Square.model.points);
    objFaces = cell2mat(Square.model.faces);
    objNormals = cell2mat(Square.faceNormals);

    % Go through each link and also each triangle face
    for i = 1 : 18
        for faceIndex = 1:size(objFaces,1)
            vertOnPlane = objPoints(objFaces(faceIndex,1)',:);
            [intersectP,check] = LinePlaneIntersection(objNormals(faceIndex,:),vertOnPlane,...
                            [lightCurtain.X(1),lightCurtain.Y(1),(lightCurtain.Z(1)-(i/10))],[lightCurtain.X(2),lightCurtain.Y(2),(lightCurtain.Z(2)-(i/10))]);
    %         disp(check)
%             if check == 1 && IsIntersectionPointInsideTriangle(intersectP,objPoints(objFaces(faceIndex,:)',:))
            if check == 1
                disp('Intersection')
                plot3(intersectP(1),intersectP(2),intersectP(3),'g*')
                intersect = true;
    %             result = true;
    %             if returnOnceFound
    %                 return
    %             end
            end
        end
    end
end
end
