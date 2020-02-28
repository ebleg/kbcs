%% REINFORCEMENT LEARNING - BASED ARCHITECTURE FOR FUZZY CONTROL
% Reproduction assignment for Knowledge Based Control Systems
% 
% Bart Kevers, Britt Krabbenborg, Maxime Croft & Emiel Legrand
% Delft, February 2020
% 
% -------------------------------------------------------------------------

clear; 
close all;

%% Parameters
run parameters

%% System dynamics
X0 = [0 -2 0 pi/6];
T_MAX = 2;

forcing = @(t) sin(2*t);
fhandle = @(t, X) systemDynamics(X, forcing(t), param);
[t, y] = ode45(fhandle, [0 T_MAX], X0);

%% Linearization
% Compute Jacobians - 3d party code
% (https://nl.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation)
A = jacobianest(@(X) systemDynamics(X, 0, param), [0 0 0 0]');
B = jacobianest(@(U) systemDynamics([0 0 0 0]', U, param), 0);



%% Control

%% State visualisation
suptitle('System response');
subplot(221);
plot(t, y(:, 1));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Cart position [m]');

subplot(222);
plot(t, y(:, 2));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Cart speed [m/s]');

subplot(223);
plot(t, y(:, 3));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Pole angle [rad]');

subplot(224);
plot(t, y(:, 4));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Pole angular velocity [rad/s]');

