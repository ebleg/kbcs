function [w] = fuzzifier(x, D)
% Fuzzifies the input variables

x = [x; 1]; % add bias unit to input vector
%% Retrieve Rules
run FuzzyRules
Rules = Fuzzy_Rules(:,1:5);
 
 RulesX = zeros(size(Rules,1),size(Rules,2)); %matrix of solution of functions
 for i= 1:size(Rules,1)
     for j= 1:size(Rules,2)
       RulesX(i,j) = Rules{i,j}(x(j));
     end
 end
%% Create w vector
w = zeros(size(RulesX,1),1);
for i=1:length(w)
    if i<=9 %9 is hardcoded, be careful
        w(i) = min(D(i,3:5).*RulesX(i,3:5)); %3 to 5 is hardcoded, be careful
    else
        w(i) = min(D(i,:).*RulesX(i,:));
    end

end

