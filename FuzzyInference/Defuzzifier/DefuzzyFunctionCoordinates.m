%% this file contains the coordinates of the fuzzifier functions

%NL function
Nl.a = [-5, 1];      %left coordinate
Nl.b = [-2, 0];      %right x-ordinate

%NM function
Nm.a = [-3, 1];      %left
Nm.b = [-1, 0];      %right

%NS function
Ns.a = [-2.5, 0];    %left
Ns.b = [0, 1];       %right

%NVS function
Nvs.a = [-1, 0];     %left
Nvs.b = [0, 1];      %right

%PVS function
Pvs.a = -Nvs.b; %left
Pvs.b = -Nvs.a; %right

%PS function
Ps.a = -Ns.b;   %left
Ps.b = -Ns.a;   %right

%PM function
Pm.a = -Nm.b;   %left
Pm.b = -Nm.a;   %right

%PL function
Pl.a = -Nl.b;   %left
Pl.b = -Nl.a;   %right


