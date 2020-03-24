function [u_nvs] = NVS(x)
%inverse membership function NVS

    run DefuzzyFunctionCoordinates

    u_nvs = Nvs(2,1) + 0.5*(Nvs(1,1)-2*Nvs(2,1)+Nvs(3,1))*(1-x);

end