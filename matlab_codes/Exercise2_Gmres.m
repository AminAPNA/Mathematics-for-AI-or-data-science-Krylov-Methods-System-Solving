 A = load('orani678.mat');
 A=A.Problem.A;
n=size(A,1);

tol=1e-6;

b = rand(n,1);

x0=zeros(n,1);


 [~, ~, ~, ~, resvec] = gmres(A, b, [], tol, n, [], [], x0);

nr=resvec; 
l=length(nr)


 
% [nr]=GMRESA(A,b,x0,tol);
% l=length(nr)


figure('Color','w','Position',[300 300 800 500]);

% Plot GMRES residuals with thick line and circular markers
plot(1:l, log10(nr), 'b-', 'LineWidth', 1.8, 'Marker', 'o', ...
     'MarkerFaceColor', 'b', 'MarkerSize', 5);

% Grid and minor grid
grid on; grid minor;

% Axis labels and title
xlabel('Iteration $j$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\log_{10}(\|r_j\|)$', 'Interpreter', 'latex', 'FontSize', 14);
title('GMRES Convergence', 'Interpreter', 'latex', 'FontSize', 16);

% Customize axes
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;
ax.Box = 'on';
ax.XColor = [0.2 0.2 0.2];
ax.YColor = [0.2 0.2 0.2];

% Legend
legend({'GMRES approach'}, 'Location', 'southwest', 'FontSize', 12, 'Box', 'off');

% Optional annotation: final residual
text(l*0.6, log10(nr(end))*1.05, ...
    sprintf('Final residual: %.2e', nr(end)), ...
    'FontSize', 11, 'Color', 'k', 'Interpreter', 'latex');

% Save figure with high resolution
exportgraphics(gcf, 'exm.png', 'Resolution', 300);

