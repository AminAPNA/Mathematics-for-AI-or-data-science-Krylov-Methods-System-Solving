A = load('orani678.mat');
A = A.Problem.A;
n = size(A,1);

tol = 1e-6;
b = rand(n,1);
x0 = zeros(n,1);

% --- ILU Preconditioner ---
setup = struct();        % create a fresh empty struct
setup.type   = 'ilutp';  % ILU with threshold and pivoting
setup.droptol = 1e-3;    % Drop tolerance
setup.udiag = 1;         % Ensure unit diagonal

% Call ILU
[L, U] = ilu(A, setup);

% --- GMRES with ILU preconditioning ---
[~, ~, ~, ~, resvec] = gmres(A, b, [], tol, n, L, U, x0);

nr = resvec;
l = length(nr)

% --- Plot residual history ---
figure('Color', 'w', 'Position', [100 100 700 500]);

% Plot residuals with a line and circle markers
semilogy(1:l, nr, '-o', 'Color', [0 0.4470 0.7410], ...
    'LineWidth', 1.5, 'MarkerSize', 6, 'MarkerFaceColor', [0 0.4470 0.7410]);

grid on;                        % Add grid
box on;                         % Add box around the plot
xlabel('Iteration $j$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('Residual $||r_j||$', 'Interpreter', 'Latex', 'FontSize', 14);
title('GMRES Convergence with ILU Preconditioning', 'FontSize', 16, 'FontWeight', 'bold');

legend('GMRES with ILU', 'Location', 'southwest', 'FontSize', 12);
set(gca, 'FontSize', 12);       % Set axis font size

% Save figure as high-resolution PNG
saveas(gcf, 'gmres_ilu_beautiful.png');

%norm(A - L*U, 'fro') / norm(A, 'fro')
%cond(L*U\A)