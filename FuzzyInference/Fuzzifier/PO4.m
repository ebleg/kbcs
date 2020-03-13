function [u_po] = PO4(x)
%membership function PO

run FuzzyFunctionOrdinates

u_po = max(0,min(1,(x-Po4.a)/(Po4.b-Po4.a)));
end