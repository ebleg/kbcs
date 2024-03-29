% ASN's neural network 
%% parameters 

run parameters 

push                = 1;       

weight_e            = ones(4,1); 
weight_f            = ones(4,1); 
weight_d            = ones(4,1); 
stochastic          = ones(4,1); 

input               = [2 2 1 1]';
reinforcement       = 2;


[p,output,weight_d,weighted_sum] = calculateprobability(weight_e, weight_f,weight_d, input, reinforcement,stochastic);



q = (p+1)/2;

if push > 0 
    pushd = q;
else 
    pushd = 1-q; 
end 

if sign(pushd) ~= sign(push)
    stochastic = 1-p; 
else 
    stochastic = -p; 
end 



function [p,output,weight_d,weighted_sum] = calculateprobability(weight_e, weight_f,weight_d, input, reinforcement,stochastic)

param.aric.rho      = 1;
param.aric.rhoh     = 0.2;

weighted_sum = weight_d.*(input);
output = Sigmoid(weighted_sum);

weight_e = weight_e + param.aric.rho.*(reinforcement).*stochastic.*(input);
weight_f = weight_f + param.aric.rho.*(reinforcement).*stochastic.*output; 

weight_d = weight_d + param.aric.rhoh.*(reinforcement).*output.*(1-output).*sign(weight_f).*stochastic.*(input');


p = weight_e.*(input) + weight_f.*output;

end 


function y = Sigmoid(x)
y = 1./(1+exp(-x)); 
end 