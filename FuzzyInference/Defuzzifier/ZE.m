function [u_ze] = ZE(x)
%inverse membership function PVS

    run DefuzzyFunctionCoordinates

    u_ze = Ze(2,1) + 0.5*(Ze(1,1)-2*Ze(2,1)+Ze(3,1))*(1-x);
end