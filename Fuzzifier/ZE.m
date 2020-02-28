function [u_ze] = ZE(x)
%membership function ZE

%variables to change
zeroboundleft = -1;
onebound  = 0.;

%not to change
slopeleft = 1./(onebound-zeroboundleft);
zeroboundright = -zeroboundleft;
sloperight = -slopeleft;

if x>zeroboundleft && x<=onebound
    u_ze = slopeleft*x-slopeleft*zeroboundleft;

elseif x>onebound && x < zeroboundright
    u_ze = sloperight*x-sloperight*zeroboundright;

else
    u_ze = 0;
end
