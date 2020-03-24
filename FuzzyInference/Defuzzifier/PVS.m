function [u_pvs] = PVS(x)
%inverse membership function PVS

    run DefuzzyFunctionCoordinates

    u_pvs = Pvs(2,1) + 0.5*(Pvs(1,1)-2*Pvs(2,1)+Pvs(3,1))*(1-x);
end