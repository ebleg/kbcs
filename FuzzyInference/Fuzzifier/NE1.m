function [u_ne] = NE1(x)
%membership function NE

run FuzzyFunctionOrdinates

u_ne = max(0,min(1,(Ne1.b-x)/(Ne1.b-Ne1.a)));
end
