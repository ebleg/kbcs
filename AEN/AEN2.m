function [r_dakje2] = AEN2(x2,v1,v2)
% Calculate r_dakje2

gamma = 1;                          % discount rate 0 =< gamma =< 1

if abs(x2(3)) > pi/15               %[rad]
    r_dakje2 = -1 - v1;
elseif abs(x2(1)) > 2.4             %[m]
    r_dakje2 = -1 - v1;
else
    r_dakje2 = gamma * v2 - v1;
end

end
