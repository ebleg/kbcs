function [u_ze] = ZE(x)
%inverse membership function PVS

run DefuzzyFunctionCoordinates


a1 = (Ze.a(2)-Ze.b(2))/(Ze.a(1)-Ze.b(1));
b1 = Ze.a(2)-a1*Ze.a(1);

a2 = (Ze.b(2)-Ze.c(2))/(Ze.b(1)-Ze.c(1));
b2 = Ze.c(2)-a2*Ze.c(1);

bound1 = Ze.a(1)*a1+b1;
bound2 = Ze.b(1)*a1+b1;
bound3 = Ze.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_ze = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_ze = (x-b2)/a2;
else 
    u_ze = 0;
end