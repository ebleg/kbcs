%% REINFORCEMENT LEARNING - BASED ARCHITECTURE FOR FUZZY CONTROL
% Reproduction assignment for Knowledge Based Control Systems
% 
% Bart Kevers, Britt Krabbenborg, Maxime Croft & Emiel Legrand
% Delft, February 2020
% 
% -------------------------------------------------------------------------

clear; 
close all;
addpath('./fuzzyInference/');
addpath('./fuzzyInference/defuzzifier');
addpath('./fuzzyInference/fuzzifier');
addpath('./tools');
addpath('./data');

%% Parameters
load('parameters_v2.mat'); % System parameters from Anderson [13]
% load('parameters_easy.mat'); % Longer pole length

%% Linearization
% Compute Jacobians - 3d party code
% (https://nl.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation)
A = jacobianest(@(X) systemDynamics(X, 0, param), [0 0 0 0]');
B = jacobianest(@(U) systemDynamics([0 0 0 0]', U, param), 0);
f_linearized = @(t, X) A*X + B*forcing(t);

%% Simple LQR control
R = eye(4);
Q = 1;
N = zeros(4, 1);
K = lqr(A, B, R, Q, N);
lqrsys = ss(A - B*K, B, eye(4), 0);
resp = step(ss);

%% Neuro-fuzzy controller simulation
T_MAX = 100;    % Max simulation time
h = 1e-2;       % RK4 step size
nstates = 4;

% Initialize controller
aric = ARIC(param);
learningComplete = false;
nTries = 0;

% Learning loop
while ~learningComplete
    % Initialize variables
    trange = nan(size(0:h:T_MAX)); % Useful for plotting, trange and x will always have the same length
    x = nan(nstates, numel(trange));
    u = nan(size(trange));
    i = 2; % Don't overwrite initial condition

    % Initial conditions
    x(:, 1) = [0 0.2 0 0]';
    
    failed = false;
    reset = true;

    % Simulation loop
    while ~failed && i <= T_MAX/h
        u(i) = aric.getControllerOutput(x(:, i-1));
        f = @(x) systemDynamics(x, u(i), param); % New function handle at each timestep probably computational nightmare, but leave it for now
        x(:, i) = RK4(f, x(:, i-1), h);
        failed = aric.updateWeights(x(:, i), reset);
        
        if reset
            reset = false;
        end
        
        i = i + 1;
    end
    
    nTries = nTries + 1;
    fprintf('Try #%d: t_max = %f\n', nTries, i*h)
    
    if i >= round(T_MAX/h, 0)
       learningComplete = true; 
    end
end
