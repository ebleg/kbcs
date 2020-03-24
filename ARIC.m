classdef ARIC < handle
    %% ARIC - Neuro-fuzzy controller class
    % *ARIC properties*
    properties % Weights
        A, b, c, D, e, f, fuzzyRules
    end
    
    properties 
        s, z, x1;
    end
    
    properties % Parameters
        n, h, rho, rhoh, beta, betah, gamma;
    end
    
    methods
    %%
    % *Class construction*
    % Input argument 'param' contains the settings the learning process.
            function obj = ARIC(par)
            % ARIC Construct an instance of this class
            % n = number of states + 1 (4 in the cart pole example)
            % h = number of rules (13 in the cart pole example)
            a = -0.1; % From Anderson [13]
            b = 0.1;
            rand_int = @(dim1, dim2) a + (b-a).*rand(dim1, dim2);  % random numbers in [a,b]
            
            obj.n = par.aric.n;
            obj.h = par.aric.h;        

            obj.rho = par.aric.rho;
            obj.rhoh = par.aric.rhoh;
            obj.beta = par.aric.beta;
            obj.betah = par.aric.betah;
            obj.gamma = par.aric.gamma;        
        
            %Action-state Evaluation Method weights
            obj.A = rand_int(obj.n, obj.n); % SQUARE MATRIX
            obj.b = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N
            obj.c = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N

            %Action Selection Network
            obj.D = rand_int(obj.h, obj.n); % HxN MATRIX
            obj.e = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N
            obj.f = rand_int(1, obj.h); % ROW VECTOR WITH LENGTH H
            
            obj.s = 0; % SCALAR
            obj.z = zeros(obj.h, 1); % COLUMN VECTOR WITH LENGHT H  
            obj.x1 = zeros(obj.n, 1);
            end
        
        %%
        % *Master loop*
        % This function is called by main in order to compute the 
        % control force based on the states
        function [F] = getControllerOutput(obj, x)
            % Action selection network
            obj.x1 = [x' 1]';
            u = obj.fuzzyInference(obj.x1); % Compute u based on fuzzy rules
            p = obj.confidenceComputation(obj.x1); % Compute confidence p
            F = obj.stochasticActionModifier(u, p); % Compute Stochastic Object Modifier F            
        end
        
        % Adapting the ARIC based on a new state
        function flag = updateWeights(obj, x, reset)
            % Compute necessary values from AEN
            %x(3:4) = rad2deg(x(3:4));
            x2 = [x' 1]';
            
            flag = obj.checkForFailure(x2);
            
            y1 = obj.AENHiddenLayer(obj.x1); % y[t, t]
            y2 = obj.AENHiddenLayer(x2);     % y[t, t+1]
            
            v1 = obj.AENOutputLayer(obj.x1, y1);  % v[t, t]
            v2 = obj.AENOutputLayer(x2, y2);      % v[t, t+1]

            rhat = obj.internalReinforcement(v1, v2, flag, reset);
            
            % Update AEN weights
            obj.b = obj.b + (obj.beta*rhat*obj.x1)'; % b is stored as a row vector
            obj.c = obj.c + (obj.beta*rhat*y1)'; % c is stored as a row vector
            obj.A = obj.A + (obj.betah*rhat).*sign(obj.c)'.*y1.*(1 - y1)*obj.x1';
            
            % Update ASN weights
            obj.e = obj.e + (obj.rho*rhat*obj.s*obj.x1)';
            obj.f = obj.f + (obj.rho*rhat*obj.s*obj.z)';
            obj.D = obj.D + obj.rhoh*rhat*obj.z.*(1 - obj.z).*sign(obj.f)'*obj.s*obj.x1';
        end
        
        %%
        % *Action-State Evaluation*
        function y = AENHiddenLayer(obj, x)
            % Computation of y[t1, t2]
            y = obj.sigmoid(obj.A*x);  % Neural network
        end
        
        function v = AENOutputLayer(obj, x, y) 
            % Computation of v[t1, t2]
            v = obj.b*x + obj.c*y;
        end
        
        function rhat = internalReinforcement(obj, v1, v2, flag, reset)
           % Implementation of Maxime's AEN2 - Computation of the internal reinforcement r_hat 
           if flag  %[m]
               rhat = -1 - v1;
           elseif reset
               rhat = 0;
           else
               rhat = obj.gamma*v2 - v1;
           end
        end
        
        %%
        % *Action Selection Network methods*
        function u = fuzzyInference(obj, x)
            % Based on Bart's FuzzyInference
            %x(3:4) = rad2deg(x(3:4));
            w = fuzzifier(x, obj.D);
            m = defuzzifier(w);
            %filter = m ~= 0;
            %u = sum(obj.f(filter).*m(filter).*w(filter))/sum(w(filter).*obj.f(filter));
            u = sum(obj.f.*m.*w)/sum(w.*obj.f);
        end
        
        function p = confidenceComputation(obj, x)
            %x(3:4) = rad2deg(x(3:4));
            obj.z = obj.sigmoid(obj.D*x); % We'll need z later for the weight modification
            p = obj.e*x + obj.f*obj.z;
        end
        
        function u_mod = stochasticActionModifier(obj, u, p)
           % _Implementation of functions o and s in the paper_
           q = (p + 1)/2;
           if q > (1-q)
               u_mod = u;
           else
               u_mod = -u;
           end
           
           if sign(u_mod) ~= sign(u)
               obj.s = 1 - p; % We'll need s later for the weight modification
           else
               obj.s = -p;
           end
        end
    end
    
    methods (Static)
        function flag = checkForFailure(x)
            if abs(x(1)) > 2.4 || abs(x(3)) > 12 %pi/15
                flag = true;
            else
                flag = false;
            end
        end
        
        function g = sigmoid(s)
            g = 1./(1 + exp(-s));
        end
    end
end