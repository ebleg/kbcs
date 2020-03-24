function [dX] = systemDynamics(X, U, param)
% System Dynamics
%   State space representation of the car-pole system dynamics. X and dX
%   refer to the state vectors, and not to the position of the cart.
%   Param contains system parameters such as the cart and pole mass,
%   friction coefficients etc. 
%       X = state vector
%       X = [x, dx/dt, theta, dtheta/dt]'
    X(3:4) = deg2rad(X(3:4));
    ml = param.sys.m*param.sys.l;
    M = param.sys.m + param.sys.mc;
        
    d2theta = (param.sys.g*sin(X(3)) ...
           + cos(X(3))*(-U - ml*X(4)^2*sin(X(3)) + param.sys.muc*sign(X(2)))/M ...
           - param.sys.mup*X(4)/ml)/param.sys.l/(4/3 - (param.sys.m*cos(X(3))^2)/M);
 
    d2x = (U + ml*(X(4)^2*sin(X(3)) - d2theta*cos(X(3))) - param.sys.muc*sign(X(2)))/M;
    dX = [X(2) d2x X(4) d2theta]';
end

