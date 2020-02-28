function [u_nl] = NL(x)
%inverse membership function NL

%variables to change
zerobound = -2;
onebound = -5;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;
if x<=(zerobound*a+b) && x>= (onebound*a+b)
    u_nl = (x-b)/a;
    
else 
    u_nl = 0;
end

