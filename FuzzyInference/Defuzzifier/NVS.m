function [u_nvs] = NVS(x)
%inverse membership function NVS

run DefuzzyFunctionCoordinates

a = (Nvs.a(2)-Nvs.b(2))/(Nvs.a(1)-Nvs.b(1));
b = Nvs.a(2)-a*Nvs.a(1);

bound1 = Nvs.a(1)*a+b;
bound2 = Nvs.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_nvs = (x-b)/a;
    
else 
    u_nvs = 0;
end