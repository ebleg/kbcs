function [u_ze] = ZE(x)
%membership function ZE

run FuzzyFunctionOrdinates

u_ze = max(0,min([((x-Ze.a)/(Ze.b-Ze.a)),1,((Ze.c-x)/(Ze.c-Ze.b))]));
end
