function [u_pm] = PM(x)
%inverse membership function PM

%variables to change
zerobound = 1;
onebound = 3;

%not to change
slope = 1/(onebound-zerobound);

a = slope;
b = -slope*zerobound;
if x>=(zerobound*a+b) && x<=(onebound*a+b)
    u_pm = (x-b)/a;
    
else 
    u_pm = 0;
    
end

