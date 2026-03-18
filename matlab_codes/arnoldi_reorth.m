function  [lam, res, X, V, H] = arnoldi_reorth(A, x0, m)
% ARNOLDI  Arnoldi iteration for Hessenberg reduction and Ritz analysis with full reorthogonalitation.
%
%   [lam, res, X, V, H] = arnoldi(A, x0, m)
%
%   Builds an orthonormal basis V for the Krylov subspace:
%       K_m(A, x0) = span{x0, A*x0, A^2*x0, ..., A^(m-1)*x0}
%   and the corresponding (m+1)-by-m upper Hessenberg matrix H.
%   Then computes the Ritz values (approximate eigenvalues of A),
%   their residuals, and the corresponding Ritz vectors.
%
%   INPUT:
%       A  - square matrix (n x n)
%       x0 - initial vector (n x 1)
%       m  - number of Arnoldi steps (dimension of the Krylov subspace)
%
%   OUTPUT:
%       lam - vector (m x 1) of Ritz values (eigenvalues of H(1:m,1:m))
%       res - vector (m x 1) of residual norms for each Ritz pair
%       X   - matrix (n x m) of Ritz vectors (approximate eigenvectors)
%       V   - matrix (n x (m+1)) of Arnoldi basis vectors
%       H   - (m+1 x m) upper Hessenberg matrix
%
%   Notes:
%   - Uses the *classical Gram–Schmidt* orthogonalization process.
%   - If H(j+1,j) = 0, the process terminates early ("lucky breakdown").
%   - The residuals are computed as:
%         res(i) = abs(H(m+1,m)) * |y_i(m)|
%     where y_i is the i-th eigenvector of H(1:m,1:m).

    n = length(x0);
    V = zeros(n, m+1);
    H = zeros(m+1, m);

    % Step 1: Normalize the initial vector
    V(:,1) = x0 / norm(x0);

    % Step 2: Arnoldi iteration
    for j = 1:m
        % Apply A to the current basis vector
        w = A * V(:,j);

         % --- Full reorthogonalization (two passes) ---
        % First Gram–Schmidt pass
        for i = 1:j
            H(i,j) = V(:,i)' * w;
            w = w - H(i,j) * V(:,i);
        end
        % Second pass (to remove any remaining numerical components)
        for i = 1:j
            h_corr = V(:,i)' * w;
            w = w - h_corr * V(:,i);
            H(i,j) = H(i,j) + h_corr;
        end
        % ------------------------------------------------------------
        % Compute the norm of the residual vector
        H(j+1,j) = norm(w);

        % Check for lucky breakdown
        if H(j+1,j) == 0
            fprintf('Arnoldi terminated early at step %d (lucky breakdown)\n', j);
            V = V(:, 1:j);
            H = H(1:j, 1:j-1);
            break;
        end

        % Normalize and add the new basis vector
        V(:,j+1) = w / H(j+1,j);
    end

    % If the process completed m steps, take the leading m×m block
    Hm = H(1:m, 1:m);

    % Step 3: Compute eigen-decomposition of Hm (Ritz pairs)
    [S, Lambda] = eig(Hm);
    lam = diag(Lambda);      % Ritz values

    % Step 4: Compute Ritz vectors in the full space
    X = V(:,1:m) * S;

    % Step 5: Compute residual norms for each Ritz pair
    % res_i = |H(m+1,m)| * |y_i(m)|
    beta = H(m+1,m);
    res = abs(beta * S(end,:)).';  % residual norms as column vector
end
