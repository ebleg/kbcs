function [m] = defuzzifier(w)
    % Defuzzifies the action
    %% Retrieve Rules
run FuzzyRules

Rules = Fuzzy_Rules(:,end);
%% Create m vector

m = zeros(length(w),1);

for i= 1:length(m)
    m(i) = Rules{i}(w(i));
end
m = m.*[ones(1,9), 10*ones(1,4)];
end

