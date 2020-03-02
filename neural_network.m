% ASN's neural network 
%% parameters 

%run parameters 

rho                 = 1; 
rhoh                = 0.2; 
push                = 1;       

weight_e            = ones(4,1); 
weight_f            = ones(4,1); 
weight_d            = ones(4,1); 

input               = [2 1 2 1]';
reinforcement       = [2 1 2 1]';


p = calculateprobability(weight_e, weight_f,weight_d, input, reinforcement,rho,rhoh,stochastic);

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


function p = calculateprobability(weight_e, weight_f,weight_d, input, reinforcement,rho,rhoh,stochastic)


weighted_sum = weight_d.*(input);
output = Sigmoid(weighted_sum);


weight_e = weight_e + rho.*(reinforcement).*stochastic.*(input);
weight_f = weight_f + rho.*(reinforcement).*stochastic.*output; 

weight_d = weight_d + rhoh.*(reinforcement).*output.*(1-output).*sign(weight_f).*stochastic.*(input);

p = weight_e.*(input) + weight_f.*output;

end 

function y = Sigmoid(x)
y = 1/(1+exp(-x)); 
end 