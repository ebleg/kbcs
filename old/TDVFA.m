classdef TDVFA < handle
    % Temporal Differences with Value Function Approximation
    properties
        gamma, alpha, lambda, epsilon, maxForce, qHat, A, x1, w;
    end
    methods
        function obj = TDVFA()
            obj.gamma = 0.992; % late reward contribution
            obj.alpha = 0.07; % learning rate
            obj.lambda = 0; % eligibility decay
            obj.epsilon = 0; % amount of randomness/greediness
            obj.maxForce = -10;
            obj.w = zeros(4,2);
        end
        
        function F = getControllerOutput(obj, x)
            % Reward and Eligibility for taking a step
            obj.x1 = x;
            obj.A = obj.x1'*obj.w(:,2) > obj.x1'*obj.w(:,1);
            obj.qHat = obj.x1'*obj.w(:,obj.A+1);
            F = ((obj.A*2)-3)*obj.maxForce;
        end
        
        function fail = reward(obj, x)
            if (abs(x(3)) > 12*pi/180 || abs(x(1)) > 2.4)
                R = -1;
                obj.w(:,obj.A+1) = obj.w(:, obj.A+1) + obj.alpha.*(R - obj.qHat).*obj.x1;
                fail = true;
            else
                Anew = x'*obj.w(:,2) > x'*obj.w(:,1);
                fail = false;
                
                % APPROX value function
                qHatNew = x'*obj.w(:,Anew+1);
                R = 0;
                
                obj.w(:,obj.A+1) = obj.w(:,obj.A+1) + obj.alpha.*(R + obj.gamma.*qHatNew - obj.qHat).*obj.x1;
                obj.qHat = qHatNew;
            end
        end
    end
end