function [u_ps] = PS(x)
%inverse membership function PS

    run DefuzzyFunctionCoordinates
    
    u_ps = Ps(2,1) + 0.5*(Ps(1,1)-2*Ps(2,1)+Ps(3,1))*(1-x);

end