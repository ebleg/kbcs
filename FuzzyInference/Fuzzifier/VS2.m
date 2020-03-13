function [u_vs] = VS2(x)
%membership function VS

run FuzzyFunctionOrdinates

u_vs = max(0,min([((x-Vs2.a)/(Vs2.b-Vs2.a)),1,((Vs2.c-x)/(Vs2.c-Vs2.b))]));
end
