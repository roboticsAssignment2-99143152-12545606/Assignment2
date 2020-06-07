%% Summary
% This program was created for Assignment Task 2 of Robotics

%% Authors
% James Walsh - 
% Jonathan Wilde - 12545606

%% Reference List
% =========================================================================
% Collision checking
%   Code obtained from tutorial 5, and modified for use in the assignment
%
% N6 Model
%   Model was taken from the Epson files.
%   https://epson.com/For-Work/Robots/6-Axis/Flexion-N6-Compact-6-Axis-Robots---1000mm/p/RN6-A10SS73SS
%
% Rick Sanchez Model
%   https://www.thingiverse.com/thing:2134321

function [] = setup()
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

%%
hold on
% floorOffset = -0.8905/2; %measured from bounding box
% workSize = 10;N6
% workspace = [-workSize workSize -workSize workSize (2*0) workSize];
workspace = [-3 3 -5 5 0 5];

%% Setup joystick
[JS_1, joy, joy_info] = JoystickClass();

%% Loop here
% while(1)
%     
%     [axes, buttons, povs] = JS_1.JoystickRead(joy);
%     disp(buttons(1,2))
%     
% end

%%  setting up objects
van = Objects('Van', '1', workspace, transl(0,0,0), 0);
wildT = Objects('WildTurkey','2',workspace, transl(0.75,-1.85,1.87), -pi/2);
smirn = Objects('Smirnoff', '3', workspace, transl(0.75,-1.65,1.87), -pi/2);
glass = Objects('Glass', '4', workspace, transl(-1.1,-1,1.55), -pi/2);
eStop1 = Objects('E-Stop', '5', workspace, transl(-1,1,1.4), pi/2);
rick = Objects('Rick', '6', workspace, transl(-2,0,0), 0);

% setting up  models
N6_1 = D6Model('N6_1',workspace, transl(0,-0.5,0.650));
N6_2 = D6Model('N6_2',workspace, transl(0,-2,0.650));

% Adjust view
view(300,20);

% N6_1.model.teach();
q = ([90,90,90,0,0,0]);
N6_1.model.animate(q);
N6_2.model.animate(q);
N6_1.model.teach
%N6_2.model.teach
% 
% pause(0.1);

%MoveQMatrix(N6_1, q, [], [van]);
%MoveQMatrix(N6_1, deg2rad([148,277,-93,0,0,0]),[],[van]);

end

