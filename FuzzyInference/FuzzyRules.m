%% Define the rules of the fuzzy logic

Fuzzy_Rules = ...
    {@zero, @zero, @PO1, @PO2, @one, @PL;...
     @zero, @zero, @PO1, @ZE2, @one, @PM;...
     @zero, @zero, @PO1, @NE2, @one, @ZE;...
     @zero, @zero, @ZE1, @PO2, @one, @PS;...
     @zero, @zero, @ZE1, @ZE2, @one, @ZE;...
     @zero, @zero, @ZE1, @NE2, @one, @NS;...
     @zero, @zero, @NE1, @PO2, @one, @ZE;...
     @zero, @zero, @NE1, @ZE2, @one, @NM;...
     @zero, @zero, @NE1, @NE2, @one, @NL;...
     @PO3, @PO4, @VS1, @VS2, @one, @PS;...
     @PO3, @PS4, @VS1, @VS2, @one, @PVS;...
     @NE3, @NE4, @VS1, @VS2, @one, @NS;...
     @NE3, @NS4, @VS1, @VS2, @one, @NVS};
