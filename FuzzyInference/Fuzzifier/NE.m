function [u_ne] = NE(x)
%membership function NE

run FuzzyFunctionOrdinates

u_ne = max(0,min(1,(Ne.b-x)/(Ne.b-Ne.a)));
end
