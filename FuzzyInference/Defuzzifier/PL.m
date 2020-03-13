function [u_pl] = PL(x)
%inverse membership function PL

run DefuzzyFunctionCoordinates

a = (Pl.a(2)-Pl.b(2))/(Pl.a(1)-Pl.b(1));
b = Pl.a(2)-a*Pl.a(1);

bound1 = Pl.a(1)*a+b;
bound2 = Pl.b(1)*a+b;
if x>max(bound1,bound2)
    u_pl = 1;
    
elseif x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_pl = (x-b)/a;
    
else 
    u_pl = 0;
end