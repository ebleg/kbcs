function [w] = fuzzifier(x, D)
% Fuzzifies the input variables 

% x(1) = x
% x(2) = xdot
% x(3) = theta
% x(4) = thetadot
% x(5) = bias unit

%% add bias to state variables

xstate = zeros((length(x)-1),1); %vector with solely state variables
for i = 1:(length(xstate))
    xstate(i) = x(i) + x(end);
end

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

Rules = ...
    {@zero, @zero, @PO, @PO;...
     @zero, @zero, @PO, @ZE;...
     @zero, @zero, @PO, @NE;...
     @zero, @zero, @ZE, @PO;...
     @zero, @zero, @ZE, @ZE;...
     @zero, @zero, @ZE, @NE;...
     @zero, @zero, @NE, @PO;...
     @zero, @zero, @NE, @ZE;...
     @zero, @zero, @NE, @NE;...
     @VS, @VS, @NE, @NE;...
     @VS, @VS, @NE, @VS;...
     @VS, @VS, @PO, @VS;...
     @VS, @VS, @PO, @PO}; %array of functions
 
 RulesX = zeros(size(Rules,1),size(Rules,2)); %matrix of solution of functions
 for i= 1:size(Rules,1)
     for j= 1:size(Rules,2)
       RulesX(i,j) = Rules{i,j}(x(j));
     end
 end
%% Create w vector
w = zeros(size(D,1),1);

for i=1:length(w)
    if i<=9 %9 is hardcoded, be careful
        w(i) = min(D(i,2:4).*RulesX(i,2:4)); %2 to 4 is hardcoded, be careful
    else
        w(i) = min(D(i,:).*RulesX(i,:));
    end
end

%% test vector to check if w is correctly computed
% wtest = zeros(size(D,1),1);
% wtest(1) = min([D(1,3)*PO(x(3)), D(1,4)*PO(x(4))]);
% wtest(2) = min([D(2,3)*PO(x(3)), D(2,4)*ZE(x(4))]);
% wtest(3) = min([D(3,3)*PO(x(3)), D(3,4)*NE(x(4))]);
% wtest(4) = min([D(4,3)*ZE(x(3)), D(4,4)*PO(x(4))]);
% wtest(5) = min([D(5,3)*ZE(x(3)), D(5,4)*ZE(x(4))]);
% wtest(6) = min([D(6,3)*ZE(x(3)), D(6,4)*NE(x(4))]);
% wtest(7) = min([D(7,3)*NE(x(3)), D(7,4)*PO(x(4))]);
% wtest(8) = min([D(8,3)*NE(x(3)), D(8,4)*ZE(x(4))]);
% wtest(9) = min([D(9,3)*NE(x(3)), D(9,4)*NE(x(4))]);
% 
% wtest(10)= min([D(10,3)*VS(x(3)), D(10,4)*VS(x(4)), D(10,1)*NE(x(1)), D(10,2)*NE(x(2))]);
% wtest(11)= min([D(11,3)*VS(x(3)), D(11,4)*VS(x(4)), D(11,1)*NE(x(1)), D(11,2)*VS(x(2))]);
% wtest(12)= min([D(12,3)*VS(x(3)), D(12,4)*VS(x(4)), D(12,1)*PO(x(1)), D(12,2)*VS(x(2))]);
% wtest(13)= min([D(13,3)*VS(x(3)), D(13,4)*VS(x(4)), D(13,1)*PO(x(1)), D(13,2)*PO(x(2))]);



end

