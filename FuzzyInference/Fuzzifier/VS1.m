function [u_vs] = VS1(x)
%membership function VS

run FuzzyFunctionOrdinates

u_vs = max(0,min([((x-Vs1.a)/(Vs1.b-Vs1.a)),1,((Vs1.c-x)/(Vs1.c-Vs1.b))]));
end
