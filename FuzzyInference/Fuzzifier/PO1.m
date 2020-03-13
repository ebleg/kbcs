function [u_po] = PO1(x)
%membership function PO1

run FuzzyFunctionOrdinates

u_po = max(0,min(1,(x-Po1.a)/(Po1.b-Po1.a)));
end