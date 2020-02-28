% ASN's neural network 

rho     = 1; 
rhoh    = 0.2; 
beta    = 0.2; 
betah   = 0.05; 
gamma   = 0.9; 

% q       = (p+1)/2;
% 
% if push > 0
%     push' = q; 
% else 
%     push' = 1-q;
% end 
% 
% for t = 1:10
% d(t+1) = d(t) + rhoh*r(t+1)*z(t)*(1-z(t))*sign(f(t))*s(t)*x(t); 
% end 

%% weight function 
function weight = calculateweight(weight, input, correct_output, reinforcement)

N = 4;
for k = 1:N 
    transposedinput = input(k,:)'; 
    d               = correct_output(k); 
    weightsum       = weight*transposedinput; 
    output          = Sigmoid(weightsum);
    
    error           = d- output;
    delta           = output*(1-output)*error; 
    
    dweight         = rho*reinforcement*st*transposed_input; 
    fweight         = rho*reinforcement*st*output;
    
    weight          = weight + rhoh*reinforcement*output*(1-output)*sign(weight)*st*transposed_input;
    
    probability     = 
    
end 
end 



%% sigmoid 
function y = Sigmoid(x)
y = 1/(1+exp(-x)); 
end 