clear;

% Load matrix
Adata = load('orani678.mat');
A = Adata.Problem.A;
n = size(A,1);

% Droptol values
droptols = logspace(-1, -16, 16);

% Initialize arrays
rel_error = zeros(size(droptols));


for k = 1:length(droptols)
    
    fprintf('Droptol = %.1e\n', droptols(k));
    
    % --- ILU setup ---
    setup = struct();
    setup.type   = 'ilutp';
    setup.droptol = droptols(k);
    setup.udiag = 1;
    
    % --- ILU factorization ---
    try
        [L,U] = ilu(A, setup);
    catch ME
        warning('ILU failed for droptol = %.1e: %s', droptols(k), ME.message);
        rel_error(k) = NaN;
     
        continue;
    end
    
    % --- Relative factorization error ---
    rel_error(k) = norm(A - L*U, 'fro') / norm(A, 'fro');
    
    % --- Condition number of preconditioned system ---
    % Solve (LU)\A and compute cond estimate
    M = L*U;
  
    
end

% --- Plot relative factorization error with reversed x-axis ---
figure('Color','w','Position',[300 300 800 500]);

loglog(droptols, rel_error, '-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
grid on; grid minor;
set(gca, 'FontSize', 12, 'XDir', 'reverse'); % Reverse x-axis

xlabel('Droptol', 'FontSize', 14);
ylabel('Relative Factorization Error ||A - LU||_F / ||A||_F', 'FontSize', 14);
title('ILU Relative Factorization Error vs. Droptol', 'FontSize', 16);
