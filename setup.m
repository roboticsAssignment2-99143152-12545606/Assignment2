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
%run C:\Users\Jay\Data\Robotics\rvctools\startup_rvc.m

%%
hold on
% floorOffset = -0.8905/2; %messured from bounding box
% workSize = 10;
% workspace = [-workSize workSize -workSize workSize (2*0) workSize];
workspace = [-2 3 -2 2 0 2]

L1 = Link('d',0.700,'a',0,'alpha',pi/2,'offset',pi/2,'qlim',deg2rad([-360 360]));
            L2 = Link('d',-0.350,'a',0,'alpha',0,'qlim',deg2rad([-180 180]));
            L3 = Link('d',0.165,'a',0,'alpha',-pi/2,'qlim',deg2rad([-180 180]));
            L4 = Link('d',0.350,'a',0,'alpha',pi/2,'qlim',deg2rad([-180 180]));
            L5 = Link('d',0.097,'a',0,'alpha',-pi/2,'qlim',deg2rad([-180 180]));
            L6 = Link('d',0.023,'a',0,'alpha',0,'qlim',deg2rad([-180 180]));
model = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'robot');
% plot(model, [0,0,0,0,0,0], 'workspace', workspace);
model.teach();
% axis equal;
% view(3)
% pause();
% N6_1 = D6Model('N6_1',workspace, transl(0,0,0), 1);

% N6_1.model.teach();

end

