%% Excersize 3

%% ==============================================================
%  Arnoldi Ritz Value Visualization Script
%  --------------------------------------------------------------
%  This script generates a complex test matrix A, computes its
%  Ritz values using the Arnoldi method for increasing subspace
%  dimensions m, and visualizes them using eigplot().
%  ==============================================================

clc; clear; close all;

%% -----------------------
%  PARAMETERS & SETUP
% ------------------------
k = input('Choose the dimension of the problem (greater than 10):'); % Problem size parameter
assert(k>=10 && mod(k,1) == 0);
m_values = 10:10:k;               % Krylov subspace dimensions
num_tests = numel(m_values);

[A, true_eigs] = Matrix_ex_3(k);

%% -----------------------
%  INITIAL VECTOR
% ------------------------
x0 = rand(2*k, 1);   % Random initial vector

%% -----------------------
%  ARNOLDI LOOP
% ------------------------
for i = 1:num_tests
    m = m_values(i);
    
    % --- Arnoldi iteration ---
    [lam, res] = arnoldi(A, x0, m);
    
    % --- Plot results ---
    clf;                           % Clear current figure
    eigplot(true_eigs, lam, res);  % Compare Ritz vs true eigenvalues
    title(sprintf('Arnoldi Ritz values (m = %d)', m));
    xlabel('Re(\lambda)');
    ylabel('Im(\lambda)');
    grid on;
    drawnow;
    
    pause(1); % Wait briefly before next plot
end
