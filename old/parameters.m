%% PARAMETERS

param = struct();

%% System parameters
param.sys.l = 0.5;      % Pole length [original]
param.sys.mc = 2;       % Cart mass
param.sys.m = 1;        % Pole mass;
param.sys.muc = 0.1;    % Friction coeff of the cart
param.sys.mup = 0.1;    % Friction coeff of the pole
param.sys.g = 9.80665;  % Gravitational acceleration

%% ARIC Settings
param.aric.rho = 1;
param.aric.rhoh = 0.2;
param.aric.beta = 0.2;
param.aric.betah = 0.05;
param.aric.gamma = 0.9;