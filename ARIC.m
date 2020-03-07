classdef ARIC < handle
    %% ARIC - Neuro-fuzzy controller class
    
    %%
    % *ARIC properties*
    properties % Weights
        A, b, c, D, e, f
    end
    
    properties % AEN outputs
        vOld, xOld, yOld, s, z;
    end
    
    properties % Parameters
        n, h, rho, rhoh, beta, betah, gamma;
    end
    
    methods
    
    %%
    % *Class construction*
    % Input argument 'param' contains the settings the learning process.
            function obj = ARIC(param)
            % ARIC Construct an instance of this class
            % n = number of states + 1 (4 in the cart pole example)
            % h = number of rules (13 in the cart pole example)
            a = -0.1; % From Anderson [13]
            b = 0.1;
            rand_int = @(dim1, dim2) a + (b-a).*rand(dim1, dim2);
            
            obj.n = param.aric.n;
            obj.h = param.aric.h;        

            obj.rho = param.aric.rho;
            obj.rhoh = param.aric.rhoh;
            obj.beta = param.aric.beta;
            obj.betah = param.aric.betah;
            obj.gamma = param.aric.gamma;        
        
            % Action-state Evaluation Method weights
            obj.A = rand_int(obj.n, obj.n); % SQUARE MATRIX
            obj.b = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N
            obj.c = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N
            
            % Action Selection Network
            obj.D = rand_int(obj.h, obj.n); % HxN MATRIX
            obj.e = rand_int(1, obj.n); % ROW VECTOR WITH LENGTH N
            obj.f = rand_int(1, obj.h); % ROW VECTOR WITH LENGTH H
            
            obj.vOld = 0; % SCALAR
            obj.s = 0; % SCALAR
            obj.z = zeros(obj.h, 1); % COLUMN VECTOR WITH LENGHT H  
            obj.yOld = zeros(obj.n, 1);
            obj.xOld = zeros(obj.n, 1);
            end
        
        %%
        % *Master loop*
        % This function is called by main in order to compute the 
        % control force based on the states
        function [F] = getControllerOutput(obj, x)
            % Action selection network
            obj.xOld = [x' 1]';
            u = obj.fuzzyInference(obj.xOld); % Compute u based on fuzzy rules
            p = obj.confidenceComputation(obj.xOld); % Compute confidence p
            F = obj.stochasticActionModifier(u, p); % Compute Stochastic Object Modifier F
        end
        
        % Adapting the ARIC based on a new state
        function flag = updateWeights(obj, x)
            % Compute necessary values from AEN
            xNew = [x' 1]';
            flag = obj.checkForFailure(xNew);
            [yNew, vNew] = obj.stateEvaluation(xNew);
            rhat = obj.internalReinforcement(vNew, flag);
            
            % Update AEN weights
            obj.b = obj.b + (obj.beta*rhat*obj.xOld)'; % b is stored as a row vector
            obj.c = obj.c + (obj.beta*rhat*obj.yOld)'; % c is stored as a row vector
            obj.A = obj.A + (obj.betah*rhat).*sign(obj.c)'.*obj.yOld.*(1 - obj.yOld)*obj.xOld';
            
            % Update ASN weights
            obj.e = obj.e + (obj.rho*rhat*obj.s*obj.xOld)';
            obj.f = obj.f + (obj.rho*rhat*obj.s*obj.z)';
            obj.D = obj.D + obj.rhoh*rhat*obj.z.*(1 - obj.z).*sign(obj.f)'*obj.s*obj.xOld';
            
            % Update v, y, x
            obj.vOld = vNew;
            obj.yOld = yNew;
            obj.xOld = xNew;
        end
        
        %%
        % *Action-State Evaluation*
        function [y, v] = stateEvaluation(obj, x)
            % Implementation of Maxime's AEN1 - neural network of AEN
            y = obj.sigmoid(obj.A*x);  % Neural network
            v = obj.b*x + obj.c*y;
        end
        
        function rhat = internalReinforcement(obj, vNew, flag)
           % Implementation of Maxime's AEN2 - Computation of the internal reinforcement r_hat 
           if flag  %[m]
               rhat = -1 - obj.vOld;
           else
               rhat = obj.gamma*vNew - obj.vOld;
           end
        end
        
        %%
        % *Action Selection Network methods*
        function u = fuzzyInference(obj, x)
            % Based on Bart's FuzzyInference
            w = fuzzifier(x, obj.D);
            m = defuzzifier(w);
            u = sum(obj.f.*m.*w)/sum(w.*obj.f);
        end
        
        function p = confidenceComputation(obj, x)
            obj.z = obj.sigmoid(obj.D*x);
            p = obj.e*x + obj.f*obj.z;
        end
        
        function u_mod = stochasticActionModifier(obj, u, p)
           % _Implementation of functions o and s in the paper_
           q = (p + 1)/2;
           if u > 0
              u_mod = q;
           else
               u_mod = 1 - q;
           end
           
           if sign(u_mod) ~= sign(u)
               obj.s = 1 - p;
           else
               obj.s = -p;
           end         
        end
    end
    
    methods (Static)
        function flag = checkForFailure(x)
            if abs(x(1)) > 2.4 || abs(x(3)) > pi/15
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

