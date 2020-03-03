function [u_ns] = NS(x)
%inverse membership function NS

run DefuzzyFunctionCoordinates

a = (Ns.a(2)-Ns.b(2))/(Ns.a(1)-Ns.b(1));
b = Ns.a(2)-a*Ns.a(1);

bound1 = Ns.a(1)*a+b;
bound2 = Ns.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_ns = (x-b)/a;
    
else 
    u_ns = 0;
end

