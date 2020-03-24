function [u_pl] = PL(x)
%inverse membership function PL

    run DefuzzyFunctionCoordinates

    a = (Pl(1,2)-Pl(2,2))/(Pl(1,1)-Pl(2,1));
    b = Pl(1,2)-a*Pl(1,1);

    bound1 = Pl(1,1)*a+b;
    bound2 = Pl(2,1)*a+b;
    if x>max(bound1,bound2)
        u_pl = max(bound1,bound2);

    elseif x>=min(bound1,bound2) && x<=max(bound1,bound2)
        u_pl = (x-b)/a;

    else 
        u_pl = 0;
    end
end