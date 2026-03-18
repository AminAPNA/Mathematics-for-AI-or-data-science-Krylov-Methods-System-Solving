clear;

% Parameters
tol = 1e-6;

% Load matrix from file
Adata = load('bcsstk09.mat');
A = Adata.Problem.A;
n = size(A, 1);
maxit = n;

% Right-hand side and initial guess
b = rand(n, 1);
x0 = zeros(n, 1);

% --- Run MINRES with ICHOL preconditioning ---
% Note: For MINRES, the preconditioner should be symmetric positive definite
[~, ~, ~, ~, resvec] = minres(A, b, tol, maxit, [], [], x0);

% --- Plot residual history ---
nr = resvec;
l = length(nr)

figure('Color','w','Position',[300 300 800 500]);

% Plot MINRES residuals with thick line and circular markers
plot(1:l, log10(nr), 'b-', 'LineWidth', 1.8, 'Marker', 'o', ...
     'MarkerFaceColor', 'b', 'MarkerSize', 5);

% Grid and minor grid
grid on; grid minor;

% Axis labels and title
xlabel('Iteration $j$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\log_{10}(\|r_j\|)$', 'Interpreter', 'latex', 'FontSize', 14);
title('MINRES Convergence (No Preconditioning)', ...
      'Interpreter', 'latex', 'FontSize', 16);

% Customize axes
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;
ax.Box = 'on';
ax.XColor = [0.2 0.2 0.2];
ax.YColor = [0.2 0.2 0.2];

% Legend
legend({'MINRES (No Preconditioner)'}, 'Location', 'southwest', 'FontSize', 12, 'Box', 'off');

% Dynamic annotation for final residual
yl = ylim;
text(l*0.6, yl(1) + 0.8*(yl(2)-yl(1)), ...
    sprintf('Final residual: %.2e', nr(end)), ...
    'FontSize', 11, 'Color', 'k', 'Interpreter', 'latex');

% Save high-resolution figure
exportgraphics(gcf, 'minres_no_precond.png', 'Resolution', 300);