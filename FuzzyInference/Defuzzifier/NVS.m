function [u_nvs] = NVS(x)
%inverse membership function NVS

run DefuzzyFunctionCoordinates

a1 = (Nvs.a(2)-Nvs.b(2))/(Nvs.a(1)-Nvs.b(1));
b1 = Nvs.a(2)-a1*Nvs.a(1);

a2 = (Nvs.b(2)-Nvs.c(2))/(Nvs.b(1)-Nvs.c(1));
b2 = Nvs.c(2)-a2*Nvs.c(1);

bound1 = Nvs.a(1)*a1+b1;
bound2 = Nvs.b(1)*a1+b1;
bound3 = Nvs.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_nvs = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_nvs = (x-b2)/a2;
else 
    u_nvs = 0;
end