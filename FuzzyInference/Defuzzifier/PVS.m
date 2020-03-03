function [u_pvs] = PVS(x)
%inverse membership function PVS

run DefuzzyFunctionCoordinates

a = (Pvs.a(2)-Pvs.b(2))/(Pvs.a(1)-Pvs.b(1));
b = Pvs.a(2)-a*Pvs.a(1);

bound1 = Pvs.a(1)*a+b;
bound2 = Pvs.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_pvs = (x-b)/a;
    
else 
    u_pvs = 0;
end