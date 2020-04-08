%% REINFORCEMENT LEARNING - BASED ARCHITECTURE FOR FUZZY CONTROL
% Reproduction assignment for Knowledge Based Control Systems
% 
% Bart Kevers, Britt Krabbenborg, Maxime Croft & Emiel Legrand
% Delft, February 2020
% 
% -------------------------------------------------------------------------

clear; 
close all;
oldpath = path;
P = path(oldpath, './tools');
P = path(P, './data');
P = path(P, './fuzzyInference');
P = path(P, './fuzzyInference/fuzzifier');
P = path(P, './fuzzyInference/defuzzifier');

%% Parameters
load('parameters_v3.mat'); % System parameters from Anderson [13]
% load('parameters_easy.mat'); % Longer pole length

par.sim.h = 1e-2;
par.sim.T_MAX = 1e1;

%% Linearization
% Compute Jacobians - 3d party code
% (https://nl.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation)
A = jacobianest(@(X) systemDynamics(X, 0, par), [0 0 0 0]');
B = jacobianest(@(U) systemDynamics([0 0 0 0]', U, par), 0);
f_linearized = @(t, X) A*X + B*forcing(t);

%% Simple LQR control
R = eye(4);
Q = 1;
N = zeros(4, 1);
K = lqr(A, B, R, Q, N);
lqrsys = ss(A - B*K, B, eye(4), 0);
resp = step(ss);

LQR_nl = @(t, x) systemDynamics(x, -K*x, par);

%% Neuro-fuzzy controller simulation
nstates = 4;

% Initialize controller
aric = ARIC(par);
tdvfa = TDVFA();
learningComplete = false;
nTriesARIC = 0;
nTriesTD = 0;
maxTries = 1e3;

NormX = @(x) [x(1)/2.4, x(2)/2.4, x(3)/(pi/15), x(4)]'; %normalise x vector
deNormX = @(x) [x(1)*2.4, x(2)*2.4, x(3)/(pi/15), x(4)]'; %denormalise x vector

xlqr = nan(nstates, numel(trange));
ulqr = nan(size(trange));

% Learning loop ARIC
while ~learningComplete
    % Initialize variables
    trange = nan(size(0:par.sim.h:par.sim.T_MAX)); % Useful for plotting, trange and x will always have the same length
    xar = nan(nstates, numel(trange));
    uar = nan(size(trange));
    i = 2; % Don't overwrite initial condition
    
    % Initial conditions    
    xar(:, 1) = [0, 0, 0.2, 0]; %x(1:2) in [m], x(3:4) in [rad]

    failed = false;
    reset = true;
    
    % Simulation loop ARIC
    while ~failed && i <= par.sim.T_MAX/par.sim.h 
        failed = aric.updateWeights(NormX(xar(:, i-1)), reset);
        uar(i) = aric.getControllerOutput(NormX(xar(:, i-1)));
        if isnan(u(i))
            error('NaN input');
        end
        
        f = @(x) systemDynamics(x, uar(i), par); % New function handle at each timestep probably computational nightmare, but leave it for now
        xar(:, i) = RK4(f, xar(:, i-1), par.sim.h);
        
        if reset
            reset = false;
        end
        i = i + 1;
    end

    nTriesARIC = nTriesARIC + 1;
    fprintf('Try #%d: t_max = %f\n', nTriesARIC, i*par.sim.h)

    if i >= round(par.sim.T_MAX/par.sim.h, 0) || nTriesARIC == maxTries
       learningComplete = true; 
    end
end

path(oldpath);