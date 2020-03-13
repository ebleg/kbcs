function [u_ne] = NE3(x)
%membership function NE

run FuzzyFunctionOrdinates

u_ne = max(0,min(1,(Ne3.b-x)/(Ne3.b-Ne3.a)));
end

