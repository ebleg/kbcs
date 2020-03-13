function [u_ne] = NE4(x)
%membership function NE

run FuzzyFunctionOrdinates

u_ne = max(0,min(1,(Ne4.b-x)/(Ne4.b-Ne4.a)));
end

