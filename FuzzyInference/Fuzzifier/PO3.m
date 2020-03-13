function [u_po] = PO3(x)
%membership function PO3

run FuzzyFunctionOrdinates

u_po = max(0,min(1,(x-Po3.a)/(Po3.b-Po3.a)));
end
