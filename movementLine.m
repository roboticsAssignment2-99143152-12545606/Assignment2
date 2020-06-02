function [] = movementLine(Robot, GoalPose, Time, Objects)
%movementLine this function will simulate shaking for the robot
%   code mainly used from lab9

% Lab 9 - Question 1 - Resolved Motion Rate Control in 6DOF

% 1.1) Set parameters for the simulation
% mdl_puma560;        % Load robot model now imported
t = Time;             % Total time (s)
deltaT = 0.02;      % Control frequency
steps = t/deltaT;   % No. of steps for simulation
delta = 2*pi/steps; % Small angle change
epsilon = 0.1;      % Threshold value for manipulability/Damped Least Squares
W = diag([1 1 1 0.1 0.1 0.1]);    % Weighting matrix for the velocity vector

% 1.2) Allocate array data
m = zeros(steps,1);             % Array for Measure of Manipulability
qMatrix = zeros(steps,6);       % Array for joint anglesR
qdot = zeros(steps,6);          % Array for joint velocities
theta = zeros(3,steps);         % Array for roll-pitch-yaw angles
x = zeros(3,steps);             % Array for x-y-z trajectory
positionError = zeros(3,steps); % For plotting trajectory error
angleError = zeros(3,steps);    % For plotting trajectory error

% user james
% get xyz from poses
p1 = Robot.getPose
p2 = GoalPose;

%plot start
% Robot.model.plot(Robot.model.ikine(p1)); redundant

cords1 = p1(1:3,4);
cords2 = p2(1:3,4);

% 1.3) Set up trajectory, initial pose
xs = lspb(cords1(1),cords2(1),steps);                % Trapezoidal trajectory scalar
ys = lspb(cords1(2),cords2(2),steps);                % Trapezoidal trajectory scalar
zs = lspb(cords1(3),cords2(3),steps);                % Trapezoidal trajectory scalar

for i=1:steps
    x(1,i) = xs(i); % Points in x
    x(2,i) = ys(i); % Points in y
    x(3,i) = zs(i); % Points in z
    theta(1,i) = -90;                 % Roll angle
    theta(2,i) = -90;            % Pitch angle
    theta(3,i) = 90;                 % Yaw angle
end
mat = [x',theta'];
T = [rpy2r(theta(1,1),theta(2,1),theta(3,1)) x(:,1);zeros(1,3) 1];          % Create transformation of first point and angle
q0 = zeros(1,6);                                                            % Initial guess for joint angles
% qMatrix(1,:) = Robot.model.ikcon(Robot.model.fkine(Robot.model.getpos),q0);                                            % Solve joint angles to achieve first waypoint
qMatrix(1,:) = Robot.model.getpos;
% 1.4) Track the trajectory with RMRC
for i = 1:steps-1
    T = Robot.model.fkine(qMatrix(i,:));                                           % Get forward transformation at current joint state
    deltaX = x(:,i+1) - T(1:3,4);                                         	% Get position error from next waypoint
    Rd = rpy2r(theta(1,i+1),theta(2,i+1),theta(3,i+1));                     % Get next RPY angles, convert to rotation matrix
    Ra = T(1:3,1:3);                                                        % Current end-effector rotation matrix
    Rdot = (1/deltaT)*(Rd - Ra);                                                % Calculate rotation matrix error
    S = Rdot*Ra';                                                           % Skew symmetric!
    linear_velocity = (1/deltaT)*deltaX;
    angular_velocity = [S(3,2);S(1,3);S(2,1)];                              % Check the structure of Skew Symmetric matrix!!
    deltaTheta = tr2rpy(Rd*Ra');                                            % Convert rotation matrix to RPY angles
    xdot = W*[linear_velocity;angular_velocity];                          	% Calculate end-effector velocity to reach next waypoint.
    J = Robot.model.jacob0(qMatrix(i,:));                 % Get Jacobian at current joint state
    m(i) = sqrt(det(J*J'));
    if m(i) < epsilon  % If manipulability is less than given threshold
        lambda = (1 - m(i)/epsilon)*5E-2;
    else
        lambda = 0;
    end
    invJ = inv(J'*J + lambda *eye(6))*J';                                   % DLS Inverse
    qdot(i,:) = (invJ*xdot)';                                                % Solve the RMRC equation (you may need to transpose the         vector)
    for j = 1:6                                                             % Loop through joints 1 to 6
        if qMatrix(i,j) + deltaT*qdot(i,j) < Robot.model.qlim(j,1)                     % If next joint angle is lower than joint limit...
            qdot(i,j) = 0; % Stop the motor
        elseif qMatrix(i,j) + deltaT*qdot(i,j) > Robot.model.qlim(j,2)                 % If next joint angle is greater than joint limit ...
            qdot(i,j) = 0; % Stop the motor
        end
    end
    qMatrix(i+1,:) = qMatrix(i,:) + deltaT*qdot(i,:);                         	% Update next joint state based on joint velocities
    positionError(:,i) = x(:,i+1) - T(1:3,4);                               % For plotting
    angleError(:,i) = deltaTheta;                                           % For plotting
end

% 1.5) Plot the results
figure(1)
plot3(x(1,:),x(2,:),x(3,:),'k.','LineWidth',1)
% Robot.model.animate(qMatrix)
MoveQMatrix(Robot,qMatrix,Objects);

% for reporting and error checking
% for i = 1:6
%     figure(2)
%     subplot(3,2,i)
%     plot(qMatrix(:,i),'k','LineWidth',1)
%     title(['Joint ', num2str(i)])
%     ylabel('Angle (rad)')
%     refline(0,Robot.model.qlim(i,1));
%     refline(0,Robot.model.qlim(i,2));
%     
%     figure(3)
%     subplot(3,2,i)
%     plot(qdot(:,i),'k','LineWidth',1)
%     title(['Joint ',num2str(i)]);
%     ylabel('Velocity (rad/s)')
%     refline(0,0)
% end
% 
% figure(4)
% subplot(2,1,1)
% plot(positionError'*1000,'LineWidth',1)
% refline(0,0)
% xlabel('Step')
% ylabel('Position Error (mm)')
% legend('X-Axis','Y-Axis','Z-Axis')
% 
% subplot(2,1,2)
% plot(angleError','LineWidth',1)
% refline(0,0)
% xlabel('Step')
% ylabel('Angle Error (rad)')
% legend('Roll','Pitch','Yaw')
% figure(5)
% plot(m,'k','LineWidth',1)
% refline(0,epsilon)
% title('Manipulability')


end

