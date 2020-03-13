function [u_ze] = ZE2(x)
%membership function ZE

run FuzzyFunctionOrdinates

u_ze = max(0,min([((x-Ze2.a)/(Ze2.b-Ze2.a)),1,((Ze2.c-x)/(Ze2.c-Ze2.b))]));
end
