function [u_pl] = PL(x)
%inverse membership function PL

%variables to change
zerobound = 2;
onebound = 5;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;

if x>=(zerobound*a+b) && x<=(onebound*a+b)
    u_pl = (x-b)/a;
    
else 
    u_pl = 0;
    
end

