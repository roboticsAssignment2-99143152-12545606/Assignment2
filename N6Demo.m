%% Epson Flexion N6 DH Model
% 41013 Robotics

% Link('theta',__,'d',__,'a',__,'alpha',__,'offset',__,'qlim',[ ... ])
%% Establish DH Parameters
L1 = Link('d',0.867,'a',0.15,'alpha',pi/2,'qlim',deg2rad([-360 360]));

L2 = Link('d',0,'a',0.350,'alpha',0,'qlim',deg2rad([-360 360]));

L3 = Link('d',0,'a',0,'alpha',-pi/2,'qlim',deg2rad([-180 180]));

L4 = Link('d',0.515,'a',0,'alpha',pi/2,'qlim',deg2rad([-200 200]));

L5 = Link('d',0,'a',0,'alpha',-pi/2,'qlim',deg2rad([-125 125]));

L6 = Link('d',0.11,'a',0,'alpha',0,'qlim',deg2rad([-360 360]));

% Initialise & plot robot
myN6 = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'EpsonN6')

q = zeros(1,6)

myN6.plot(q)

myN6.teach()