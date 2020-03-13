function [u_ps] = PS(x)
%inverse membership function PS

run DefuzzyFunctionCoordinates

a1 = (Ps.a(2)-Ps.b(2))/(Ps.a(1)-Ps.b(1));
b1 = Ps.a(2)-a1*Ps.a(1);

a2 = (Ps.b(2)-Ps.c(2))/(Ps.b(1)-Ps.c(1));
b2 = Ps.c(2)-a2*Ps.c(1);

bound1 = Ps.a(1)*a1+b1;
bound2 = Ps.b(1)*a1+b1;
bound3 = Ps.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_ps = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_ps = (x-b2)/a2;
else 
    u_ps = 0;
end