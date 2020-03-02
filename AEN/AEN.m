% AEN

x2 = [1 2 3 4 5]';
start = true;

if start == true
    A1 = ones(5,5);
    B1 = ones(1,5);
    C1 = ones(1,5);
    r_dakje2 = 0;
    x1 = ones(5,1);
    y1 = ones(5,1);
    v1 = ones (1,1);
end

% Run AEN1
[y2, v2] = AEN1(x2,A1,B1,C1);

% Run AEN2
[r_dakje2] = AEN2(x2,v1,v2);

% Run AEN3
[A2, B2, C2] = AEN3(A1, B1, C1, r_dakje2, x1, y1);

A1 = A2;
B1 = B2;
C1 = C2;
x1 = x2;
y1 = y2;
v1 = v2;




