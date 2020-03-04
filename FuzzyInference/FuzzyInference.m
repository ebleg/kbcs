function [u] = FuzzyInference(x, D, F)
%% Main fuzzy function, uses the folders Fuzzifier and Defuzzifier

% random input to test function
% x = rand(5,1);
% D = rand(13,4);
% F = rand(13,1);

%FuzzyInference selects the control action required to balance the cartpole

% x(1) = x
% x(2) = xdot
% x(3) = theta
% x(4) = thetadot
% x(5) = bias unit

%x = matrix(5,1)  : input variables
%D = matrix(13,4) : connection weights between input and hidden layer
%F = matrix(13,1) : connection weights between hidden layer and output

%% add paths
addpath( "Defuzzifier",...
         "Fuzzifier")

%% start code
w = fuzzifier(x, D);
m = defuzzifier(w);

u = norm(F.*m.*w)/norm(w.*F);
end

