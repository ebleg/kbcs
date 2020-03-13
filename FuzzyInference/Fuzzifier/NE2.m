function [u_ne] = NE2(x)
%membership function NE

run FuzzyFunctionOrdinates

u_ne = max(0,min(1,(Ne2.b-x)/(Ne2.b-Ne2.a)));
end


