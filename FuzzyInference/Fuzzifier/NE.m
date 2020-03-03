function [u_ne] = NE(x)
%membership function NE

%variable to change
zerobound = -1;
onebound  = -2;

%not to change
slope = 1/(onebound-zerobound);

if x>=zerobound
    u_ne = 0;

elseif x<zerobound && x > onebound
    u_ne = slope*x-slope*zerobound;

else
    u_ne = 1;
end

