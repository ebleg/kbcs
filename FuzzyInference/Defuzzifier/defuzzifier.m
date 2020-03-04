function [m] = defuzzifier(w)
    % Defuzzifies the action

    %% Retrieve Rules
    Fuzzy_Rules = ...
        {@zero, @zero, @PO, @PO, @PL;...
         @zero, @zero, @PO, @ZE, @PM;...
         @zero, @zero, @PO, @NE, @ZE;...
         @zero, @zero, @ZE, @PO, @PS;...
         @zero, @zero, @ZE, @ZE, @ZE;...
         @zero, @zero, @ZE, @NE, @NS;...
         @zero, @zero, @NE, @PO, @ZE;...
         @zero, @zero, @NE, @ZE, @NM;...
         @zero, @zero, @NE, @NE, @NL;...
         @VS, @VS, @NE, @NE, @NS;...
         @VS, @VS, @NE, @VS, @NVS;...
         @VS, @VS, @PO, @VS, @PVS;...
         @VS, @VS, @PO, @PO, @PS};

    Rules = Fuzzy_Rules(:,end);
    %% Create m vector

    m = zeros(length(w),1);

    for i= 1:length(m)
        m(i) = Rules{i}(w(i));
    end

    %% vector to check the m vector
    % mtest = zeros(length(w),1);
    % mtest(1) = PL(w(1));
    % mtest(2) = PM(w(2));
    % mtest(3) = ZE(w(3));
    % mtest(4) = PS(w(4));
    % mtest(5) = ZE(w(5));
    % mtest(6) = NS(w(6));
    % mtest(7) = ZE(w(7));
    % mtest(8) = NM(w(8));
    % mtest(9) = NL(w(9));
    % mtest(10) = NS(w(10));
    % mtest(11) = NVS(w(11));
    % mtest(12) = PVS(w(12));
    % mtest(13) = PS(w(13));

end
