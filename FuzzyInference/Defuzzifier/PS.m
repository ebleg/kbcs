function [u_ps] = PS(x)
%inverse membership function PS

run DefuzzyFunctionCoordinates

a = (Ps.a(2)-Ps.b(2))/(Ps.a(1)-Ps.b(1));
b = Ps.a(2)-a*Ps.a(1);

bound1 = Ps.a(1)*a+b;
bound2 = Ps.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_ps = (x-b)/a;
    
else 
    u_ps = 0;
end