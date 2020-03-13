function [u_ze] = ZE1(x)
%membership function ZE

run FuzzyFunctionOrdinates

u_ze = max(0,min([((x-Ze1.a)/(Ze1.b-Ze1.a)),1,((Ze1.c-x)/(Ze1.c-Ze1.b))]));
end
