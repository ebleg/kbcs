function [u_pvs] = PVS(x)
%inverse membership function PVS

%variables to change
zerobound = 0.5;
onebound = 0.;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;

if x<=(zerobound*a+b) && x>= (onebound*a+b)
    u_pvs = (x-b)/a;
    
else 
    u_pvs = 0;
    
end

