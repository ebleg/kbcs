function [u_nm] = NM(x)
%inverse membership function NM

run DefuzzyFunctionCoordinates

a = (Nm.a(2)-Nm.b(2))/(Nm.a(1)-Nm.b(1));
b = Nm.a(2)-a*Nm.a(1);

bound1 = Nm.a(1)*a+b;
bound2 = Nm.b(1)*a+b;
if x>=min(bound1,bound2) && x<=max(bound1,bound2)
    u_nm = (x-b)/a;
else 
    u_nm = 0;
end



