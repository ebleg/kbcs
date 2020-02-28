function [u_ns] = NS(x)
%inverse membership function NS

%variables to change
zerobound = -2.5;
onebound = 0.;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;

if x>=(zerobound*a+b) && x<=(onebound*a+b)
    u_ns = (x-b)/a;
    
else 
    u_ns = 0;
end

