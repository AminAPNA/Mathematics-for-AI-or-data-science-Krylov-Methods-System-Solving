function [lam, res, X, V, T] = lanczos(A, x0, m)
% LANCZOS  Lanczos iteration for symmetric matrices and Ritz analysis.
%
%   [lam, res, X, V, T] = lanczos(A, x0, m)
%
%   Performs m iterations of the Lanczos algorithm on a symmetric matrix A
%   with initial vector x0, returning the tridiagonal matrix T, the basis V,
%   and the Ritz values/vectors and their residuals.
%
%   INPUT:
%       A  - symmetric matrix (n x n)
%       x0 - initial vector (n x 1)
%       m  - number of Lanczos iterations
%
%   OUTPUT:
%       lam - Ritz values (approximate eigenvalues of A)
%       res - residual norms for each Ritz pair
%       X   - Ritz vectors (approximate eigenvectors of A)
%       V   - orthonormal Lanczos basis (n x m)
%       T   - tridiagonal matrix (m x m)
%
%   Notes:
%   - A must be symmetric (A = A').
%   - If beta becomes zero, the process terminates early.
%   - Residuals are computed as:
%         res(i) = |beta_m| * |y_i(m)|
%     where y_i is the i-th eigenvector of T.


    n = size(A, 1);
    V = zeros(n, m);
    T = zeros(m, m);

    % --- Step 1: Normalize the initial vector ---
    v0 = x0 / norm(x0);
    V(:,1) = v0;

    % --- Step 2: Initialize ---
    w = A * v0;
    alpha = v0' * w;
    w = w - alpha * v0;

    T(1,1) = alpha;

    % --- Step 3: Main Lanczos iteration ---
    for j = 2:m
        beta = norm(w);

        if beta < eps
            % Krylov subspace exhausted
            fprintf('Lanczos terminated early at step %d\n', j-1);
            T = T(1:j-1, 1:j-1);
            V = V(:, 1:j-1);
            break;
        end

        v = w / beta;
        V(:,j) = v;

        w = A * v - beta * V(:,j-1);
        alpha = v' * w;
        w = w - alpha * v;

        % Fill tridiagonal entries
        T(j,j)   = alpha;
        T(j-1,j) = beta;
        T(j,j-1) = beta;
    end

    % --- Step 4: Compute Ritz decomposition ---
    [S, Lambda] = eig(T);
    lam = diag(Lambda);     % Ritz values (approx eigenvalues)

    % --- Step 5: Compute Ritz vectors in full space ---
    X = V * S;             % Ritz vectors (approx eigenvectors of A)

    % --- Step 6: Compute residual norms ---
    % res_i = |beta_m| * |y_i(m)|
    if size(T,1) == m
        beta = norm(w); % Last beta after m-th step
        res = abs(beta * S(end,:)).'; % column vector
    else
        % Process stopped early, set residuals to zero
        res = zeros(size(lam));
    end
end
