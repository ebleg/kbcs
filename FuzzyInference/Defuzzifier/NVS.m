function [u_nvs] = NVS(x)
%inverse membership function NVS

%variables to change
zerobound = -0.5;
onebound = 0.;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;
if x>=(zerobound*a+b) && x<= (onebound*a+b)
    u_nvs = (x-b)/a;
    
else 
    u_nvs = 0;
end
