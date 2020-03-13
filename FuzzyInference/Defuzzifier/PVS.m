function [u_pvs] = PVS(x)
%inverse membership function PVS

run DefuzzyFunctionCoordinates


a1 = (Pvs.a(2)-Pvs.b(2))/(Pvs.a(1)-Pvs.b(1));
b1 = Pvs.a(2)-a1*Pvs.a(1);

a2 = (Pvs.b(2)-Pvs.c(2))/(Pvs.b(1)-Pvs.c(1));
b2 = Pvs.c(2)-a2*Pvs.c(1);

bound1 = Pvs.a(1)*a1+b1;
bound2 = Pvs.b(1)*a1+b1;
bound3 = Pvs.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_pvs = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_pvs = (x-b2)/a2;
else 
    u_pvs = 0;
end