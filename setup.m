function [] = setup()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here\

%% init
close all
set(0,'DefaultFigureWindowStyle','docked')
clear
clc
% Mac run command
% run /Users/jonathanwilde/git/Robotics/rvctools/startup_rvc.m
% Windows run command
%run C:\Git\Robotics\rvctools\startup_rvc.m

%%
hold on
% floorOffset = -0.8905/2; %messured from bounding box
% workSize = 10;
% workspace = [-workSize workSize -workSize workSize (2*0) workSize];
workspace = [-2 3 -2 2 0 2]

% setting up  models
N6_1 = D6Model('N6_1',workspace, transl(0,0,0));
N6_1.model.delay = 0.1;

% setting up objects
bottle = Objects('WildTurkey','1',workspace, transl(1,0,0.35), -pi/2);
bottle.model.delay = 0;

% N6_1.model.teach();
q = deg2rad([90,90,90,0,0,0])
N6_1.model.animate(q);
MoveWObjects(N6_1, transl(-0.33,0,0.4) * troty(90),[]);
% N6_1.model.teach
% 
% pause(0.1);
movementPour(N6_1, [], 10, [bottle], 50)

'done'

end

