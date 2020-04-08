function [] = visualize(X, U, par)
% 
    
    X = X(:,~isnan(X(1,:)));
    figure;
    hold on;
    axis equal;
    title('Cart-pole visualisation')
    xlim([-2.4 2.4]);
    ylim([-0.2, 2*par.sys.l]);
    sampleRate = 1; % With respect to h
    nsteps = size(X, 2);
    grid on; grid minor;
    F(numel(1:sampleRate:nsteps)) = struct('cdata',[],'colormap',[]);
    xlabel('x')
    % Real time simulation
    for i=1:sampleRate:nsteps
        cla;
        xtip = X(1,i) + sin(X(3,i))*par.sys.l;
        ytip = cos(X(3,i))*par.sys.l;
        line([X(1,i) xtip], [0, ytip]);

        quiver(X(1,i) - 0.01*U(i), 0, 0.01*U(i), 0)
        F(i) = getframe(gcf);
        pause(sampleRate*par.sim.h);
    end
end

