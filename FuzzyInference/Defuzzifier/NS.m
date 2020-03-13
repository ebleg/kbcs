function [u_ns] = NS(x)
%inverse membership function NS

run DefuzzyFunctionCoordinates

a1 = (Ns.a(2)-Ns.b(2))/(Ns.a(1)-Ns.b(1));
b1 = Ns.a(2)-a1*Ns.a(1);

a2 = (Ns.b(2)-Ns.c(2))/(Ns.b(1)-Ns.c(1));
b2 = Ns.c(2)-a2*Ns.c(1);

bound1 = Ns.a(1)*a1+b1;
bound2 = Ns.b(1)*a1+b1;
bound3 = Ns.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_ns = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_ns = (x-b2)/a2;
else 
    u_ns = 0;
end

