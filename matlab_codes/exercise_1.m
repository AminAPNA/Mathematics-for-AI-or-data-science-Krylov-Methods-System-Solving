%% Exercise 1

clear all
clc
close all

load("delaunay_n15.mat");

A = Problem.A;

[n,~] = size(A);

%% Point A: Check Property of A
%Sparsity of A 
figure(1)
spy(A)
title('Sparsity of A')

% A is symmetric:
assert (norm(A-A','fro') < eps)
fprintf("\n norm(A-A')= %e\n", norm(A-A','fro'));

% Non zeros elements
nnzA = nnz(A); 

fprintf("\n A has %d", nnzA);
fprintf(" non zeros elements \n")

%% Point B: 
% ============================================================
%  Comparison between Lanczos and Arnoldi methods
%  Metrics: runtime, orthogonality, and residuals
% =============================================================
v0 = randn(n, 1);               % random starting vector
v0 = v0 / norm(v0);             % normalization

% --- Initialize result arrays ---
m_values = [5,10,30,50,100,250,300];
num_tests = numel(m_values);

time_l = zeros(num_tests, 1);
time_a = zeros(num_tests, 1);
err_l  = zeros(num_tests, 1);
err_a  = zeros(num_tests, 1);
res_l  = zeros(num_tests, 1);
res_a  = zeros(num_tests, 1);

%% --- Loop over different subspace sizes m ---
for i = 1:num_tests
    m = m_values(i);

    %% ---- Lanczos Method ----
    tic
    [lam_l, res, X_l, U_l] = lanczos(A, v0, m);
    time_l(i) = toc;

    % Orthogonality error: ||U'U - I||
    err_l(i) = norm(U_l' * U_l - eye(size(U_l,2)), 'fro');
    
    %Residual norm : 
    res_l(i) = norm(res);

    %% ---- Arnoldi Method ----
    tic
    [lam_a, res, X_a, V_a] = arnoldi(A, v0, m);
    time_a(i) = toc;

    % Orthogonality error: ||V'V - I||
    err_a(i) = norm(V_a' * V_a - eye(size(V_a,2)), 'fro');

    % Residual norm
    res_a(i) = norm(res);
end

% %% --- Print results table ---
% fprintf('\nComparison: Lanczos vs Arnoldi\n');
% fprintf('---------------------------------------------------------------\n');
% fprintf(' m    |  time_L  |  time_A  |   err_L   |   err_A   |   res_L   |   res_A\n');
% fprintf('---------------------------------------------------------------\n');
% for i = 1:num_tests
%     fprintf('%3d   | %7.4f | %7.4f | %9.2e | %9.2e | %9.2e | %9.2e\n', ...
%         m_values(i), time_l(i), time_a(i), err_l(i), err_a(i), res_l(i), res_a(i));
% end

%% --- Optional: comparison plots ---
figure;

subplot(1,3,1);
plot(m_values, time_l, '-or', m_values, time_a, '-sb');
xlabel('m'); ylabel('Time (s)');
legend('Lanczos', 'Arnoldi', 'Location', 'northwest');
title('Execution time');

subplot(1,3,2);
semilogy(m_values, res_l, '-or', m_values, res_a, '-sb');
xlabel('m'); ylabel('Residual norm (log scale)');
legend('Lanczos', 'Arnoldi', 'Location', 'northeast');
title('Residual comparison');


subplot(1,3,3);
semilogy(m_values, err_l, '-or', m_values, err_a, '-sb');
xlabel('m'); ylabel("||V'V - I||)");
legend('Lanczos', 'Arnoldi', 'Location', 'northeast');
title('Orthogonality comparison');


%% Point C: 
% ============================================================
%  Comparison between Lanczos and Arnoldi methods with reorthogonalization
%  Metrics: runtime, orthogonality, and residuals
% =============================================================

time_l_reorth = zeros(num_tests, 1);
time_a_reorth = zeros(num_tests, 1);
err_l_reorth  = zeros(num_tests, 1);
err_a_reorth  = zeros(num_tests, 1);
res_l_reorth  = zeros(num_tests, 1);
res_a_reorth  = zeros(num_tests, 1);

%% --- Loop over different subspace sizes m ---
for i = 1:num_tests
    m = m_values(i);

    %% ---- Lanczos Method ----
    tic
    [lam_l, res, X_l, U_l] = lanczos_reorth(A, v0, m);
    time_l_reorth(i) = toc;

    % Orthogonality error: ||U'U - I||
    err_l_reorth(i) = norm(U_l' * U_l - eye(size(U_l,2)), 'fro');
    
    %Residual norm : 
    res_l_reorth(i) = norm(res);

    %% ---- Arnoldi Method ----
    tic
    [lam_a, res, X_a, V_a] = arnoldi_reorth(A, v0, m);
    time_a_reorth(i) = toc;

    % Orthogonality error: ||V'V - I||
    err_a_reorth(i) = norm(V_a' * V_a - eye(size(V_a,2)), 'fro');

    % Residual norm
    res_a_reorth(i) = norm(res);
end

%% --- Optional: comparison plots ---
figure;

subplot(1,3,1);
plot(m_values, time_l, '-or', m_values, time_a, '-sb',m_values, time_l_reorth, '--or', m_values, time_a_reorth, '--sb');
xlabel('m'); ylabel('Time (s)');
legend('Lanczos', 'Arnoldi','Lanczos_reorth', 'Arnoldi reorth', 'Location', 'northwest');
title('Execution time');

subplot(1,3,2);
semilogy(m_values, res_l, '-or', m_values, res_a, '-sb',m_values, res_l_reorth, '--or', m_values, res_a_reorth, '--sb');
xlabel('m'); ylabel('Residual norm (log scale)');
legend('Lanczos', 'Arnoldi','Lanczos reorth', 'Arnoldi reorth', 'Location', 'northeast');
title('Residual comparison');


subplot(1,3,3);
semilogy(m_values, err_l, '-or', m_values, err_a, '-sb', m_values, err_l_reorth, '--or', m_values, err_a_reorth, '--sb');
xlabel('m'); ylabel("||V'V - I||");
legend('Lanczos', 'Arnoldi','Lanczos reorth', 'Arnoldi reorth', 'Location', 'northeast');
title('Orthogonality comparison');

