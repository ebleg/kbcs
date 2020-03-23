function [] = visualize(X, U, par)
% 
    X = X(:,~isnan(X(1,:)));
    figure;
    hold on;
    axis equal;
    xlim([-2.4 2.4]);
    ylim([-0.2, 2*par.sys.l]);
    sampleRate = 1; % With respect to h
    nsteps = size(X, 2);
    grid on; grid minor;
    
    % Real time simulation
    for i=1:sampleRate:nsteps
        cla;
        xtip = X(1,i) + sin(X(3,i))*par.sys.l;
        ytip = cos(X(3,i))*par.sys.l;
        line([X(1,i) xtip], [0, ytip]);

        quiver(X(1,i) - U(i), 0, U(i), 0)
        pause(sampleRate*par.sim.h); 
    end
end

