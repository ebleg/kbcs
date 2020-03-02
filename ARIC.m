classdef ARIC
    % ARIC class defines a controller object

    properties
        A, b, c, D, e, f
    end
    
    methods
        function obj = ARIC(n, h) % Input methods here
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

            
        end
        
        %% Action-State Evaluation
        

        %% Action Selection Network methods
        function controlForce = actionSelectionNetwork(obj, state)
            % Action Selection Network
            % Determine control force based on the state
            
            %%% 
            
            
            controlForce = obj.Property1 + inputArg;
        end
        
        function u = fuzzyInference(obj, state)
            % Fuzzy inference, part of ASN
            
        end
       
    end
end

