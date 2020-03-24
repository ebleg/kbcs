function [u_ns] = NS(x)
%inverse membership function NS

    run DefuzzyFunctionCoordinates

    u_ns = Ns(2,1) + 0.5*(Ns(1,1)-2*Ns(2,1)+Ns(3,1))*(1-x);

end

