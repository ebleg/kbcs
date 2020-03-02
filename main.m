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
X0 = [0 -2 0 3*pi/6];
T_MAX = 2;

% Define control force
% forcing = @(t) sin(2*t);
forcing = @(t) 0;

fhandle = @(t, X) systemDynamics(X, forcing(t), param);
[t, y] = ode45(fhandle, [0 T_MAX], X0);

%% Linearization
% Compute Jacobians - 3d party code
% (https://nl.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation)
A = jacobianest(@(X) systemDynamics(X, 0, param), [0 0 0 0]');
B = jacobianest(@(U) systemDynamics([0 0 0 0]', U, param), 0);

f_linearized = @(t, X) A*X + B*forcing(t);
[t_lin, y_lin] = ode45(f_linearized, [0 T_MAX], X0);

%% Control
% Simple LQR control
R = eye(4);
Q = 1;
N = zeros(4, 1);
K = lqr(A, B, R, Q, N);

lqrsys = ss(A - B*K, B, eye(4), 0);
resp = step(ss);

tSample = 0:1e-2:10;
[y_lqr, t_lqr] = lsim(lqrsys, zeros(numel(tSample), 1), tSample, X0);

run stateVisualisation






