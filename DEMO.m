%% Summary
% This program was created for Assignment Task 2 of Robotics

%% Authors
% James Walsh
% Jonathan Wilde - 12545606

%% Reference List
% =========================================================================
% Collision checking
%   Code obtained from tutorial 5, and modified for use in the assignment
%
% D6 Model
%

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

%% Setup joystick
[JS_1, joy, joy_info] = JoystickClass();

%% Loop here
while(1)
    
    [axes, buttons, povs] = JS_1.JoystickRead(joy);
    disp(buttons(1,2))
    
end

%%
hold on
% floorOffset = -0.8905/2; %measured from bounding box
% workSize = 10;N6
% workspace = [-workSize workSize -workSize workSize (2*0) workSize];
workspace = [-3 3 -5 5 0 5]

% setting up environment
van = Objects('Van', '1', workspace, transl(0,0,0), 0);
eStop1 = Objects('E-Stop', '5', workspace, transl(-1,1,1.4), pi/2);

% setting up objects
wildT = Objects('WildTurkey','2',workspace, transl(0.6,-1.85,1.75), -pi/2);
smirn = Objects('Smirnoff', '3', workspace, transl(0.6,-1.65,1.75), -pi/2);
glass = Objects('Glass', '4', workspace, transl(-0.5,-2,1.45), -pi/2);

% setting up  models
N6_1 = D6Model('N6_1',workspace, transl(-0.05,-1.6,0.605));
N6_2 = D6Model('N6_2',workspace, transl(-0.05,-2.4,0.605));

% N6_1.model.teach();
q = deg2rad([90,90,90,0,0,0])
N6_1.model.animate(q);
N6_2.model.animate(q);

%% this section does shaking

MoveWObjects(N6_1, glass.getPose() * transl(0,0.5,0.2) * troty(pi/2), [],[]);
P = N6_1.getPose;
P = P(1:3,4)';
[qMatrix, steps] = movementShake(N6_1, transl(P) * transl(0,0,0.25), 1, [])
s = steps;
qMatrix(1:end,6) = ones(s,1) .* deg2rad(90);
MoveQMatrix(N6_1, qMatrix, [glass], [], 10);
'done'
return

%% this section does stiring

MoveWObjects(N6_1, glass.getPose() * transl(0,0,-0.05), [],[]);

[qMatrix, steps] = movementStir(N6_1, [], 10, [])

MoveQMatrix(N6_1, qMatrix, [], [], 10);
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


end
