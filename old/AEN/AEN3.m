function [A2, B2, C2] = AEN3(A1, B1, C1, r_dakje2, x1, y1)
% Calculate weights A2, B2, C2

beta = 1;                   % constant beta > 0
beta_h = 1;                 % constant beta_h > 0

B2 = B1 + beta * r_dakje2 * x1;
C2 = C1 + beta * r_dakje2 * y1;
A2 = A1 + (beta_h * r_dakje2) .* sign(C1)' .* y1 .* (1 - y1) * x1';
 
end

