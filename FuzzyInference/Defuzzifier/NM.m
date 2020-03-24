function [u_nm] = NM(x)
%inverse membership function NM

    run DefuzzyFunctionCoordinates

    u_nm = Nm(2,1) + 0.5*(Nm(1,1)-2*Nm(2,1)+Nm(3,1))*(1-x);


end



