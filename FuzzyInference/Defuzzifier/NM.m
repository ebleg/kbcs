function [u_nm] = NM(x)
%inverse membership function NM

run DefuzzyFunctionCoordinates

a1 = (Nm.a(2)-Nm.b(2))/(Nm.a(1)-Nm.b(1));
b1 = Nm.a(2)-a1*Nm.a(1);

a2 = (Nm.b(2)-Nm.c(2))/(Nm.b(1)-Nm.c(1));
b2 = Nm.c(2)-a2*Nm.c(1);

bound1 = Nm.a(1)*a1+b1;
bound2 = Nm.b(1)*a1+b1;
bound3 = Nm.c(1)*a2+b2;

if x>=min(bound1,bound2) && x<=max(bound1, bound2)
    u_nm = (x-b1)/a1;
    
elseif x>min(bound2,bound3) && x<max(bound2,bound3)
    u_nm = (x-b2)/a2;
else 
    u_nm = 0;
end



