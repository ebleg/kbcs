function [u_ps] = PS(x)
%inverse membership function PS

%variables to change
zerobound = 2.5;
onebound = 0.;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;

if x<=(zerobound*a+b) && x>= (onebound*a+b)
    u_ps = (x-b)/a;
    
else 
    u_ps = 0;
    
end
