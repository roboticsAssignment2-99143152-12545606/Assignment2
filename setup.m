function [] = setup()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here\

%% init
close all
set(0,'DefaultFigureWindowStyle','docked')
clear
clc

%%
hold on
floorOffset = -0.8905/2; %messured from bounding box
workSize = 1;
workspace = [-workSize workSize -workSize workSize (2*floorOffset) workSize];
N6_1 = D6Model('N6_1',workspace, transl(0,0,0), 1);

N6_1.model.teach();

end

