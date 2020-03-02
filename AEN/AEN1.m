function [y2, v2] = AEN1(x2,A1,B1,C1)
% Calculate output of hidden layer (v) and output layer (y)

s = A1*x2;

for m = 1:5
    y2(m) = 1/(1+exp(-1*s(m)));
end

v2 = B1.*x2 + C1.*y2;

end
