function [u_pm] = PM(x)
%inverse membership function PM

run DefuzzyFunctionCoordinates

a1 = (Pm.a(2)-Pm.b(2))/(Pm.a(1)-Pm.b(1));
b1 = Pm.a(2)-a1*Pm.a(1);

a2 = (Pm.b(2)-Pm.c(2))/(Pm.b(1)-Pm.c(1));
b2 = Pm.c(2)-a2*Pm.c(1);

bound1 = Pm.a(1)*a1+b1;
bound2 = Pm.b(1)*a1+b1;
bound3 = Pm.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_pm = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_pm = (x-b2)/a2;
else 
    u_pm = 0;
end
