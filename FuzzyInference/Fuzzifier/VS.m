function [u_vs] = VS(x)
%membership function VS

run FuzzyFunctionOrdinates

u_vs = max(0,min([((x-Vs.a)/(Vs.b-Vs.a)),1,((Vs.c-x)/(Vs.c-Vs.b))]));
