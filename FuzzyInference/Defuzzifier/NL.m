function [u_nl] = NL(x)
%inverse membership function NL

run DefuzzyFunctionCoordinates

a = (Nl.a(2)-Nl.b(2))/(Nl.a(1)-Nl.b(1));
b = Nl.a(2)-a*Nl.a(1);

bound1 = Nl.a(1)*a+b;
bound2 = Nl.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_nl = (x-b)/a;
    
else 
    u_nl = 0;
end





