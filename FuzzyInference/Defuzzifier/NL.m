function [u_nl] = NL(x)

    run DefuzzyFunctionCoordinates

    a = (Nl(1,2)-Nl(2,2))/(Nl(1,1)-Nl(2,1));
    b = Nl(1,2)-a*Nl(1,1);

    bound1 = Nl(1,1)*a+b;
    bound2 = Nl(2,1)*a+b;
    if x<min(bound1,bound2)
        u_nl = min(bound1,bound2);

    elseif x>=min(bound1,bound2) && x<=max(bound1,bound2)
        u_nl = (x-b)/a;

    else 
        u_nl = 0;
    end
end




