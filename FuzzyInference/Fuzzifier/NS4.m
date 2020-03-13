function [u_vs] = NS4(x)
%membership function VS

run FuzzyFunctionOrdinates

u_vs = max(0,min([((x-Ns4.a)/(Ns4.b-Ns4.a)),1,((Ns4.c-x)/(Ns4.c-Ns4.b))]));
end
