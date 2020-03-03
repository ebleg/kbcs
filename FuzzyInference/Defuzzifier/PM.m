function [u_pm] = PM(x)
%inverse membership function PM

run DefuzzyFunctionCoordinates

a = (Pm.a(2)-Pm.b(2))/(Pm.a(1)-Pm.b(1));
b = Pm.a(2)-a*Pm.a(1);

bound1 = Pm.a(1)*a+b;
bound2 = Pm.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_pm = (x-b)/a;
    
else 
    u_pm = 0;
end