classdef Fuzzy
    %Class containing all fuzzy functions
    
    properties
        Po1, Ze1, Ne1, Vs1, Po2, Ze2, Ne2, Vs2, Po3, Ne3, Po4, Ne4, Ps4, Ns4, ...
        Pl, Pm, Ps, Pvs, Nl, Nm, Ns, Nvs, Ze
    end
    
    methods
        %class constructor
        function obj = Fuzzy()
            obj.Po1 = [0.0 ; 0.3];
            obj.Ze1 = [-0.3 ; 0 ; 0.3];
            obj.Ne1 = [-0.3 ; 0];
            obj.Vs1 = [-0.05 ; 0.0 ; 0.05];
            obj.Po2 = [0.0 ; 1.0];
            obj.Ze2 = [-1.0; 0 ; 1];
            obj.Ne2 = [-1 ; 0];
            obj.Vs2 = [-0.1 ; 0; 0.1];
            obj.Po3 = [0 ; 0.5];
            obj.Ne3 = [-0.5 ; 0];
            obj.Po4 = [0 ; 1];
            obj.Ne4 = [-1 ; 0];
            obj.Ps4 = [-0.01 ; 0 ; 1];
            obj.Ns4 = [-1 ; 0 ; 0.01];
            
            obj.Pl = [15, 0 ;
                      20, 1];
            obj.Pm = [5, 0;
                      10, 1;
                      16, 0];
            obj.Ps = [1, 0;
                      5, 1;
                      10, 0];
            obj.Pvs= [0, 0;
                      1, 1;
                      2, 0];
            obj.Nl = [-20, 1;
                      -15, 0];
            obj.Nm = [-16, 0;
                      -10, 1;
                      -5, 0];
            obj.Ns = [-10, 0;
                      -5, 1;
                      -1, 0];
            obj.Nvs= [-2, 0;
                      -1, 1;
                      0, 0];
            obj.Ze = [-1, 0;
                      0, 1;
                      1, 0];
        end
        
        %% Fuzzification and Defuzzication functions
        % Fuzzification function
        function [w] = fuzzifier(obj, x, D)
            % Fuzzifies the input variables

            x = [x; 1]; % add bias unit to input vector
            % Retrieve Rules
            Fuzzy_Rules = ...
            {@obj.zero, @obj.zero, @obj.PO1, @obj.PO2, @obj.one, @obj.PL;...
             @obj.zero, @obj.zero, @obj.PO1, @obj.ZE2, @obj.one, @obj.PM;...
             @obj.zero, @obj.zero, @obj.PO1, @obj.NE2, @obj.one, @obj.ZE;...
             @obj.zero, @obj.zero, @obj.ZE1, @obj.PO2, @obj.one, @obj.PS;...
             @obj.zero, @obj.zero, @obj.ZE1, @obj.ZE2, @obj.one, @obj.ZE;...
             @obj.zero, @obj.zero, @obj.ZE1, @obj.NE2, @obj.one, @obj.NS;...
             @obj.zero, @obj.zero, @obj.NE1, @obj.PO2, @obj.one, @obj.ZE;...
             @obj.zero, @obj.zero, @obj.NE1, @obj.ZE2, @obj.one, @obj.NM;...
             @obj.zero, @obj.zero, @obj.NE1, @obj.NE2, @obj.one, @obj.NL;...
             @obj.PO3, @obj.PO4, @obj.VS1, @obj.VS2, @obj.one, @obj.PS;...
             @obj.PO3, @obj.PS4, @obj.VS1, @obj.VS2, @obj.one, @obj.PVS;...
             @obj.NE3, @obj.NE4, @obj.VS1, @obj.VS2, @obj.one, @obj.NS;...
             @obj.NE3, @obj.NS4, @obj.VS1, @obj.VS2, @obj.one, @obj.NVS};

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
        end
        
        %Defuzzification function
        function [m] = defuzzifier(obj, w)
        
        %retrieve rules
        Fuzzy_Rules = ...
        {@obj.zero, @obj.zero, @obj.PO1, @obj.PO2, @obj.one, @obj.PL;...
         @obj.zero, @obj.zero, @obj.PO1, @obj.ZE2, @obj.one, @obj.PM;...
         @obj.zero, @obj.zero, @obj.PO1, @obj.NE2, @obj.one, @obj.ZE;...
         @obj.zero, @obj.zero, @obj.ZE1, @obj.PO2, @obj.one, @obj.PS;...
         @obj.zero, @obj.zero, @obj.ZE1, @obj.ZE2, @obj.one, @obj.ZE;...
         @obj.zero, @obj.zero, @obj.ZE1, @obj.NE2, @obj.one, @obj.NS;...
         @obj.zero, @obj.zero, @obj.NE1, @obj.PO2, @obj.one, @obj.ZE;...
         @obj.zero, @obj.zero, @obj.NE1, @obj.ZE2, @obj.one, @obj.NM;...
         @obj.zero, @obj.zero, @obj.NE1, @obj.NE2, @obj.one, @obj.NL;...
         @obj.PO3, @obj.PO4, @obj.VS1, @obj.VS2, @obj.one, @obj.PS;...
         @obj.PO3, @obj.PS4, @obj.VS1, @obj.VS2, @obj.one, @obj.PVS;...
         @obj.NE3, @obj.NE4, @obj.VS1, @obj.VS2, @obj.one, @obj.NS;...
         @obj.NE3, @obj.NS4, @obj.VS1, @obj.VS2, @obj.one, @obj.NVS};

        Rules = Fuzzy_Rules(:,end);
        %% Create m vector

        m = zeros(length(w),1);

        for i= 1:length(m)
            m(i) = Rules{i}(w(i));
        end
        end
        
        %% Fuzzification membership functions 
        %membership function NE1
        function [u_ne] = NE1(obj, x)
            u_ne = max(0,min(1,(obj.Ne1(2)-x)/(obj.Ne1(2)-obj.Ne1(1))));
        end
        
        %membership function NE1
        function [u_ne] = NE2(obj, x)
            u_ne = max(0,min(1,(obj.Ne2(2)-x)/(obj.Ne2(2)-obj.Ne2(1))));
        end
        
        %membership function NE3
        function [u_ne] = NE3(obj, x)
            u_ne = max(0,min(1,(obj.Ne3(2)-x)/(obj.Ne3(2)-obj.Ne3(1))));
        end
        
        %membership function NE4
        function [u_ne] = NE4(obj, x)
            u_ne = max(0,min(1,(obj.Ne4(2)-x)/(obj.Ne4(2)-obj.Ne4(1))));
        end
        
        %membership function NS4
        function [u_vs] = NS4(obj, x)
            u_vs = max(0,min([((x-obj.Ns4(1).a)/(obj.Ns4(2)-obj.Ns4(1))),1,((obj.Ns4(3)-x)/(obj.Ns4(3)-obj.Ns4(2)))]));
        end
        
        %membership function one
        function [u] = one(obj, x)
            u = 1;
        end
        
        %membership function PO1
        function [u_po] = PO1(obj, x)
            u_po = max(0,min(1,(x-obj.Po1(1))/(obj.Po1(2)-obj.Po1(1))));
        end
        
        %membership function PO2
        function [u_po] = PO2(obj, x)
            u_po = max(0,min(1,(x-obj.Po2(1))/(obj.Po2(2)-obj.Po2(1))));
        end
        
        %membership function PO3
        function [u_po] = PO3(obj, x)
            u_po = max(0,min(1,(x-obj.Po3(1))/(obj.Po3(2)-obj.Po3(1))));
        end
        
        %membership function PO4
        function [u_po] = PO4(obj, x)
            u_po = max(0,min(1,(x-obj.Po4(1))/(obj.Po4(2)-obj.Po4(1))));
        end
        
        %membership function PS4
        function [u_vs] = PS4(obj, x)
            u_vs = max(0,min([((x-obj.Ps4(1))/(obj.Ps4(2)-obj.Ps4(1))),1,((obj.Ps4(3)-x)/(obj.Ps4(3)-obj.Ps4(2)))]));
        end
        
        %membership function VS1
        function [u_vs] = VS1(obj, x)
            u_vs = max(0,min([((x-obj.Vs1(1))/(obj.Vs1(2)-obj.Vs1(1))),1,((obj.Vs1(3)-x)/(obj.Vs1(3)-obj.Vs1(2)))]));
        end
        
        %membership function VS2
        function [u_vs] = VS2(obj, x)
            u_vs = max(0,min([((x-obj.Vs2(1))/(obj.Vs2(2)-obj.Vs2(1))),1,((obj.Vs2(3)-x)/(obj.Vs2(3)-obj.Vs2(2)))]));
        end
        
        %membership function ZE
        function [u_ze] = ZE1(obj, x)
            u_ze = max(0,min([((x-obj.Ze1(1))/(obj.Ze1(2)-obj.Ze1(1))),1,((obj.Ze1(3)-x)/(obj.Ze1(3)-obj.Ze1(2)))]));
        end
        
        %membership function ZE
        function [u_ze] = ZE2(obj, x)
            u_ze = max(0,min([((x-obj.Ze2(1))/(obj.Ze2(2)-obj.Ze2(1))),1,((obj.Ze2(3)-x)/(obj.Ze2(3)-obj.Ze2(2)))]));
        end
        
        %membership function zero        
        function [u] = zero(obj, x)
            u = 0;
        end

        %% Defuzzication membership functions
        %inverse membership function NL
        function [u_nl] = NL(obj, x)

            a = (obj.Nl(1,2)-obj.Nl(2,2))/(obj.Nl(1,1)-obj.Nl(2,1));
            b = obj.Nl(1,2)-a*obj.Nl(1,1);

            bound1 = obj.Nl(1,1)*a+b;
            bound2 = obj.Nl(2,1)*a+b;
            if x<min(bound1,bound2)
                u_nl = min(bound1,bound2);

            elseif x>=min(bound1,bound2) && x<=max(bound1,bound2)
                u_nl = (x-b)/a;

            else 
                u_nl = 0;
            end
        end
        
        %inverse membership function NM
        function [u_nm] = NM(obj, x) 
            u_nm = obj.Nm(2,1) + 0.5*(obj.Nm(1,1)-2*obj.Nm(2,1)+obj.Nm(3,1))*(1-x);
%             a1 = (obj.Nm(1,2)-obj.Nm(2,2))/(obj.Nm(1,1)-obj.Nm(2,1));
%             b1 = obj.Nm(1,2)-a1*obj.Nm(1,1);
% 
%             a2 = (obj.Nm(2,2)-obj.Nm(3,2))/(obj.Nm(2,1)-obj.Nm(3,1));
%             b2 = obj.Nm(3,2)-a2*obj.Nm(3,1);
% 
%             bound1 = obj.Nm(1,1)*a1+b1;
%             bound2 = obj.Nm(2,1)*a1+b1;
%             bound3 = obj.Nm(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_nm = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_nm = (x-b2)/a2;
%             else 
%                 u_nm = 0;
%             end
        end
        
        %inverse membership function NS
        function [u_ns] = NS(obj, x)
            u_ns = obj.Ns(2,1) + 0.5*(obj.Ns(1,1)-2*obj.Ns(2,1)+obj.Ns(3,1))*(1-x);
%             a1 = (obj.Ns(1,2)-obj.Ns(2,2))/(obj.Ns(1,1)-obj.Ns(2,1));
%             b1 = obj.Ns(1,2)-a1*obj.Ns(1,1);
% 
%             a2 = (obj.Ns(2,2)-obj.Ns(3,2))/(obj.Ns(2,1)-obj.Ns(3,1));
%             b2 = obj.Ns(3,2)-a2*obj.Ns(3,1);
% 
%             bound1 = obj.Ns(1,1)*a1+b1;
%             bound2 = obj.Ns(2,1)*a1+b1;
%             bound3 = obj.Ns(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_ns = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_ns = (x-b2)/a2;
%             else 
%                 u_ns = 0;
%             end
        end
        
        %inverse membership function NVS
        function [u_nvs] = NVS(obj, x)
            u_nvs = obj.Nvs(2,1) + 0.5*(obj.Nvs(1,1)-2*obj.Nvs(2,1)+obj.Nvs(3,1))*(1-x);
%             a1 = (obj.Nvs(1,2)-obj.Nvs(2,2))/(obj.Nvs(1,1)-obj.Nvs(2,1));
%             b1 = obj.Nvs(1,2)-a1*obj.Nvs(1,1);
% 
%             a2 = (obj.Nvs(2,2)-obj.Nvs(3,2))/(obj.Nvs(2,1)-obj.Nvs(3,1));
%             b2 = obj.Nvs(3,2)-a2*obj.Nvs(3,1);
% 
%             bound1 = obj.Nvs(1,1)*a1+b1;
%             bound2 = obj.Nvs(2,1)*a1+b1;
%             bound3 = obj.Nvs(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_nvs = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_nvs = (x-b2)/a2;
%             else 
%                 u_nvs = 0;
%             end
        end
        
        %inverse membership function PL
        function [u_pl] = PL(obj, x)
            a = (obj.Pl(1,2)-obj.Pl(2,2))/(obj.Pl(1,1)-obj.Pl(2,1));
            b = obj.Pl(1,2)-a*obj.Pl(1,1);

            bound1 = obj.Pl(1,1)*a+b;
            bound2 = obj.Pl(2,1)*a+b;
            if x>max(bound1,bound2)
                u_pl = max(bound1,bound2);

            elseif x>=min(bound1,bound2) && x<=max(bound1,bound2)
                u_pl = (x-b)/a;

            else 
                u_pl = 0;
            end
        end
        
        %inverse membership function PM
        function [u_pm] = PM(obj, x)
            u_pm = obj.Pm(2,1) + 0.5*(obj.Pm(1,1)-2*obj.Pm(2,1)+obj.Pm(3,1))*(1-x);
%             a1 = (obj.Pm(1,2)-obj.Pm(2,2))/(obj.Pm(1,1)-obj.Pm(2,1));
%             b1 = obj.Pm(1,2)-a1*obj.Pm(1,1);
% 
%             a2 = (obj.Pm(2,2)-obj.Pm(3,2))/(obj.Pm(2,1)-obj.Pm(3,1));
%             b2 = obj.Pm(3,2)-a2*obj.Pm(3,1);
% 
%             bound1 = obj.Pm(1,1)*a1+b1;
%             bound2 = obj.Pm(2,1)*a1+b1;
%             bound3 = obj.Pm(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_pm = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_pm = (x-b2)/a2;
%             else 
%                 u_pm = 0;
%             end
        end
        
        %inverse membership function PS
        function [u_ps] = PS(obj, x)
            u_ps = obj.Ps(2,1) + 0.5*(obj.Ps(1,1)-2*obj.Ps(2,1)+obj.Ps(3,1))*(1-x);
%             a1 = (obj.Ps(1,2)-obj.Ps(2,2))/(obj.Ps(1,1)-obj.Ps(2,1));
%             b1 = obj.Ps(1,2)-a1*obj.Ps(1,1);
% 
%             a2 = (obj.Ps(2,2)-obj.Ps(3,2))/(obj.Ps(2,1)-obj.Ps(3,1));
%             b2 = obj.Ps(3,2)-a2*obj.Ps(3,1);
% 
%             bound1 = obj.Ps(1,1)*a1+b1;
%             bound2 = obj.Ps(2,1)*a1+b1;
%             bound3 = obj.Ps(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_ps = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_ps = (x-b2)/a2;
%             else 
%                 u_ps = 0;
%             end
        end
        
        %inverse membership function PVS
        function [u_pvs] = PVS(obj, x)
            u_pvs = obj.Pvs(2,1) + 0.5*(obj.Pvs(1,1)-2*obj.Pvs(2,1)+obj.Pvs(3,1))*(1-x);
%             a1 = (obj.Pvs(1,2)-obj.Pvs(2,2))/(obj.Pvs(1,1)-obj.Pvs(2,1));
%             b1 = obj.Pvs(1,2)-a1*obj.Pvs(1,1);
% 
%             a2 = (obj.Pvs(2,2)-obj.Pvs(3,2))/(obj.Pvs(2,1)-obj.Pvs(3,1));
%             b2 = obj.Pvs(3,2)-a2*obj.Pvs(3,1);
% 
%             bound1 = obj.Pvs(1,1)*a1+b1;
%             bound2 = obj.Pvs(2,1)*a1+b1;
%             bound3 = obj.Pvs(3,1)*a2+b2;
% 
%             if x>=min(bound1,bound2) && x<=max(bound1, bound2)
%                 u_pvs = (x-b1)/a1;
% 
%             elseif x>min(bound2,bound3) && x<max(bound2,bound3)
%                 u_pvs = (x-b2)/a2;
%             else 
%                 u_pvs = 0;
%             end
        end
        
        %inverse membership function PVS
        function [u_ze] = ZE(obj, x)
            u_ze = obj.Ze(2,1) + 0.5*(obj.Ze(1,1)-2*obj.Ze(2,1)+obj.Ze(3,1))*(1-x);
%             a1 = (obj.Ze(1,2)-obj.Ze(2,2))/(obj.Ze(1,1)-obj.Ze(2,1));
%             b1 = obj.Ze(1,2)-a1*obj.Ze(1,1);
% 
%             a2 = (obj.Ze(2,2)-obj.Ze(3,2))/(obj.Ze(2,1)-obj.Ze(3,1));
%             b2 = obj.Ze(3,2)-a2*obj.Ze(3,1);
% 
%             bound1 = obj.Ze(1,1)*a1+b1;
%             bound2 = obj.Ze(2,1)*a1+b1;
%             bound3 = obj.Ze(3,1)*a2+b2;
% 
%             if x >= min(bound1,bound2) &&  x<= max(bound1, bound2)
%                 u_ze = (x-b1)/a1; 
% 
%             elseif x > min(bound2,bound3) && x < max(bound2,bound3)
%                 u_ze = (x-b2)/a2;
%             else 
%                 u_ze = 0;
%             end
        end
    end
end

