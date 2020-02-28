function [u_po] = PO(x)
%membership function PO

%variable to change
zerobound = 1;
onebound  = 2;

%not to change
slope = 1/(onebound-zerobound);

if x<=zerobound
    u_po = 0;

elseif x>zerobound && x < onebound
    u_po = slope*x-slope*zerobound;

else
    u_po = 1;
end
