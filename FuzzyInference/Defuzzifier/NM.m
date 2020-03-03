function [u_nm] = NM(x)
%inverse membership function NM

%variables to change
zerobound = -1;
onebound = -3;

%not to change
slope = 1/(onebound-zerobound);
a = slope;
b = -slope*zerobound;
if x<=(zerobound*a+b) && x>=(onebound*a+b)
    u_nm = (x-b)/a;
    
else 
    u_nm = 0;
    
end

