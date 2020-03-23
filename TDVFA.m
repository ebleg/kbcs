classdef TDVFA < handle
    % Temporal Differences with Value Function Approximation
    properties
       w, 
    end
    methods
        function obj = TDVFA(param)
            w = rand(4,1);
        end
        function F = getControllerOutput(obj, x) 
        end   
    end
end

