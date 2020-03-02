classdef ARIC
    % ARIC class defines a controller object

    properties
        A, b, c, D, e, f
    end
    
    methods
        function obj = ARIC(n, h, param) % Input methods here
            % ARIC Construct an instance of this class
            % n = number of states + 1 (5 in the cart pole example)
            % h = number of rules (13 in the cart pole example)
            
            % Action-state Evaluation Method weights
            obj.A = rand(n, n);
            obj.b = rand(1, n);
            obj.c = rand(1, n);
            
            % Action Selection Network
            obj.D = rand(h, n);
            obj.e = rand(1, n);
            obj.f = rand(1, h);   
            
            obj.param = param;
        end
        
        %% Master loop
        function controlForce = master(obj, state)
            u = obj.fuzzyInference(state);
            p = obj.confidenceComputation(state);
            s = obj.stochasticActionModifier(u, p);
  
        end
        
        %% Action-State Evaluation
        function rhat = internalReinforcement(obj, x)
           %%%% MAXIME FUNCTION 1 %%%%
           rhat = 0; 
        end
        
        function updateWeights(obj)
            %%%% MAXIME FUNCTION 2 %%%%
            
        end

        %% Action Selection Network methods     
        function u = fuzzyInference(obj, x)
            % Fuzzy inference, part of ASN
            
            w = fuzzifier(x, obj.D);
            m = defuzzifier(w);
            
            utop=0;
            ubot=0;
            for i= 1:length(w)
                utop = utop + obj.f(i)*m(i)*w(i);
                ubot = ubot + w(i)*obj.f(i);
            end
            
            u = utop/ubot;
        end
        
        function p = confidenceComputation(obj, x)
            
            %%%% BRITT FUNCTION %%%%%
            p = 0;

        end
        
        function s = stochasticActionModifier(u, p)
           % Implementation of functions o and s in the paper
           %%%% STOCHASTIC ACTION MODIFIER %%%%
           
           q = (p + 1)/2;
           u_modified = q*u - (1-q)*u; % Still slightly unclear
           
           if sign(u_modified) ~= sign(u)
               s = 1 - p;
           else
               s = -p;
           end
           
        end

       
    end
end

