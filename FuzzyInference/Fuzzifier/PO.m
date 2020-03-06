function [u_po] = PO(x)
%membership function PO

run FuzzyFunctionOrdinates

u_po = max(0,min(1,(x-Po.a)/(Po.b-Po.a)));
end