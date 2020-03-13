function [u_po] = PO2(x)
%membership function PO2

run FuzzyFunctionOrdinates

u_po = max(0,min(1,(x-Po2.a)/(Po2.b-Po2.a)));
end
