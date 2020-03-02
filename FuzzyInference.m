function [u] = FuzzyInference()
%% Main fuzzy function, uses the folders Fuzzifier and Defuzzifier

x = rand(5,1);
D = rand(13,4);
F = rand(13,1);
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

utop=0;
ubot=0;
for i= 1:length(w)
    utop = utop + F(i)*m(i)*w(i);
    ubot = ubot + w(i) * F(i);
end

u = utop/ubot;
end

