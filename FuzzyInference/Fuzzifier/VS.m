function [u_vs] = VS(x)
%membership function VS

%variables to change
zeroboundleft = -1.5;
onebound  = 0.;

%not to change
slopeleft = 1./(onebound-zeroboundleft);
zeroboundright = -zeroboundleft;
sloperight = -slopeleft;

if x>zeroboundleft && x<=onebound
    u_vs = slopeleft*x-slopeleft*zeroboundleft;

elseif x>onebound && x < zeroboundright
    u_vs = sloperight*x-sloperight*zeroboundright;

else
    u_vs = 0;
end

