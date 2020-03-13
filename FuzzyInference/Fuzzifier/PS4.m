function [u_vs] = PS4(x)
%membership function VS

run FuzzyFunctionOrdinates

u_vs = max(0,min([((x-Ps4.a)/(Ps4.b-Ps4.a)),1,((Ps4.c-x)/(Ps4.c-Ps4.b))]));
end
