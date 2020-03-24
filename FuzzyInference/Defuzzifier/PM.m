function [u_pm] = PM(x)
%inverse membership function PM

    run DefuzzyFunctionCoordinates
    
    u_pm = Pm(2,1) + 0.5*(Pm(1,1)-2*Pm(2,1)+Pm(3,1))*(1-x);

end
