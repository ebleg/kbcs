function [m] = defuzzifier(w)
% Deffuzifies the action

%% Rules
%Rule-l:    IF theta is PO      AND     thetadot is PO      THEN F is PL
%Rule-2:    IF theta is PO      AND     thetadot is ZE      THEN F is PM 
%Rule-3:    IF theta is PO      AND     thetadot is NE      THEN F is ZE
%Rule-4:    IF theta is ZE      AND     thetadot is PO      THEN F is PS
%Rule-5:    IF theta is ZE      AND     thetadot is ZE      THEN F is ZE
%Rule-6:    IF theta is ZE      AND     thetadot is NE      THEN F is NS
%Rule-7:    IF theta is NE      AND     thetadot is PO      THEN F is ZE
%Rule-8:    IF theta is NE      AND     thetadot is ZE      THEN F is NM
%Rule-9:    IF theta is NE      AND     thetadot is NE      THEN F is NL 

%Rule-10:   IF theta is VS      AND     thetadot is VS      AND     x is NE     AND     xdot is NE      THEN F is NS       
%Rule-11:   IF theta is VS      AND     thetadot is VS      AND     x is NE     AND     xdot is VS      THEN F is NVS 
%Rule-12:   IF theta is VS      AND     thetadot is VS      AND     x is PO     AND     xdot is VS      THEN F is PVS
%Rule-12:   IF theta is VS      AND     thetadot is VS      AND     x is PO     AND     xdot is PO      THEN F is PS

%% Create m vector

m = zeros(length(w),1);

m(1) = PL(w(1));
m(2) = PM(w(2));
m(3) = ZE(w(3));
m(4) = PS(w(4));
m(5) = ZE(w(5));
m(6) = NS(w(6));
m(7) = ZE(w(7));
m(8) = NM(w(8));
m(9) = NL(w(9));
m(10) = NS(w(10));
m(11) = NVS(w(11));
m(12) = PVS(w(12));
m(13) = PS(w(13));

end

