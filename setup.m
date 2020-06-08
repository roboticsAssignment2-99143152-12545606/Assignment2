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

function [RobotArms,Objects,environmentObjects] = setup()
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

%%  setting up environments
van = Objects('Van', '1', workspace, transl(0,0,0), 0);
eStop1 = Objects('E-Stop', '5', workspace, transl(-1,1,1.4), pi/2);
rick = Objects('Rick', '6', workspace, transl(-2,0,0), 0);

environmentObjects = [van, eStop1, rick];

%%  setting up objects
wildT = Objects('WildTurkey','2',workspace, transl(0.5,-2.25,1.75), pi/2);
smirn = Objects('Smirnoff', '3', workspace, transl(0.5,-1.65,1.75), -pi/2);
glass = Objects('Glass', '4', workspace, transl(-0.6,-2,1.50), -pi/2);
spoonGlass = Objects('Spoon_Glass', '5', workspace, transl(-0.6,-2.6,1.50), 0);
spoon = Objects('Spoon', '6', workspace, transl(-0.6,-2.6,1.57), 0);

shaker = Objects('ShakerAssy', '6', workspace, transl(-0.5,-1.6,1.45), -pi/2);
% Enable this shaker top for collision testing
shakerTop = Objects('Shaker', '7', workspace, transl(-0.5,-2,1.55), -pi/2);

Objects = [wildT,smirn,glass,spoonGlass,spoon,shaker,shakerTop];

% Adjust view
view(300,20);

% setting up  models
N6_1 = D6Model('N6_1',workspace, transl(-0.15,-1.6,0.605 + 0.4));
N6_2 = D6Model('N6_2',workspace, transl(-0.15,-2.4,0.605 + 0.4));

RobotArms = [N6_2, N6_1];

% N6_1.model.teach();
q = deg2rad([90,90,90,0,0,0]);
N6_1.model.animate(q);
N6_2.model.animate(q);

% N6_2.model.teach
%
% pause(0.1);
% movementPour(N6_1, [], 10, [bottle], 50)

% onTheRocks([N6_2, N6_1],[wildT, glass],van);
shakenNotstired([N6_2, N6_1],[smirn, shaker, shakerTop,glass],[van, eStop1, rick])

'done'

%MoveQMatrix(N6_1, q, [], [van]);
%MoveQMatrix(N6_1, deg2rad([148,277,-93,0,0,0]),[],[van]);

end

