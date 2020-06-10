%% Summary
% This program was created for Assignment Task 2 of Robotics.
% This is fully operable from the GUI, which would be recommended.
% Debug only from this function!

%% Authors
% James Walsh - *****ADD SN HERE*****
% Jonathan Wilde - 12545606

%% Main setup function runs here
function [RobotArms,moveableObjects,environmentObjects] = setup()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Initialise MATLAB and run RVC
% Clear all in prep for new run
close all
clear
clc
% Uncomment if working with restricted screen space
% set(0,'DefaultFigureWindowStyle','docked')
% Use these to run RVC from MAC & WINDOWS
    % Mac run command
    % run /Users/jonathanwilde/git/Robotics/rvctools/startup_rvc.m
    % Windows run command
    % run C:\Git\Robotics\rvctools\startup_rvc.m

%% Initialise workspace for plotting
hold on
workspace = [-3 3 -5 5 0 5];

%% Joystick initialise
% These will need to be passed in to each object requiring control
[JS_1, joy, joy_info, NOJOY] = JoystickClass();

%%  setting up environments
van = Objects('Van', '1', workspace, transl(0,0,0), 0);
eStop1 = Objects('E-Stop', '5', workspace, transl(-1,1,1.4), pi/2);
colObj = Objects('CollisionObject', '6', workspace, transl(-0.6,0,1.4), 0);

% Categorise environment objects for future use
environmentObjects = [van, eStop1, colObj];

% Set up light curtain
lightCurtain.X = [-0.95, 0.8];
lightCurtain.Y = [-2.9, -2.9];
lightCurtain.Z = [2.3, 2.3];

for lineIt = lightCurtain.Z(1):-0.1:0.5
    plot3(lightCurtain.X,lightCurtain.Y,[lineIt, lineIt],'--r','LineWidth',0.1);
end

%  setting up objects
wildT = Objects('WildTurkey','2',workspace, transl(0.5,-2.25,1.75), pi/2);
smirn = Objects('Smirnoff', '3', workspace, transl(0.5,-1.65,1.75), -pi/2);
glass = Objects('Glass', '4', workspace, transl(-0.6,-2,1.50), pi);
spoonGlass = Objects('Spoon_Glass', '5', workspace, transl(-0.6,-2.6,1.50), 0);
spoon = Objects('Spoon', '6', workspace, transl(-0.6,-2.6,1.57), pi);
shakerTop = Objects('Shaker', '7', workspace, transl(-0.6,-2.3,1.4), pi);
soda = Objects('Soda', '17', workspace, transl(-0.6,-1.4,1.75), -pi/2);
rum = Objects('Smirnoff', '13', workspace, transl(0.5,-2.75,1.75), -pi/2);

% Categorise moveable objects for future use
moveableObjects = [wildT,smirn,glass,spoonGlass,spoon, shakerTop, soda, rum, []];

% setting up  models
N6_1 = N6Model('N6_1',workspace, transl(-0.15,-1.6,0.605 + 0.4));
N6_2 = N6Model('N6_2',workspace, transl(-0.15,-2.4,0.605 + 0.4));
% Pass joy functionality for jogging
N6_1.setJoy(JS_1, joy, NOJOY);
N6_2.setJoy(JS_1, joy, NOJOY);

% Categorise robots for future use
RobotArms = [N6_1, N6_2];

% N6_1.model.teach();
q = deg2rad([90,90,90,0,0,0]);
N6_1.model.animate(q);
N6_2.model.animate(q);

% Adjust view
view(300,20);

%% Test joystick jogging N6
%while(1)
%    N6_1.joggingLoop(0.01, 1)
%    pause(0.1)
%end
%
%% Test joystick jogging a given item
%item2set = colObj;
%
%item2set.setJoy(JS_1, joy, NOJOY);
%
%while(1)
%    item2set.joggingLoop(0.01, 1)
%    pause(0.1)
%end
%% Stirring rum & coke debug section
% stirredRumAndCoke([N6_1, N6_2],[rum,soda,ice,glass,spoon],[colObj])

% 'done'

%MoveQMatrix(N6_1, q, [], [van]);
%MoveQMatrix(N6_1, deg2rad([148,277,-93,0,0,0]),[],[van]);

%% this section to check light curtain
% Square = Objects('Square', '1', workspace, transl([-4,-4,1.5]), 0);
% 
% % Adjust view
% view(300,20);
% 
% testLightCurtain(Square, lightCurtain);

end

