function [A, true_eigs] = Matrix_ex_3(k)
%% -----------------------
%  MATRIX CONSTRUCTION
% ------------------------
% Define spectral components (complex eigenvalues)
add = 1:2:(2*k);
es = exp(-1i * pi * (1:4:(4*k)) / k) .* add;

% Random orthogonal matrix Q
[Q, ~] = qr(randn(2*k));

% Define diagonal and block structure
A_diag = diag(es);
b = [0, 0; 0, 1];
v = eye(2) - b;

% Build structured block matrix
B = kron(b, A_diag);

% Define another spectral part and combine
es2 = exp(1i * pi * (1:4:(4*k)) / k);
A_core = diag(es2 *floor(11*k/8)) + floor(k/3)* eye(k);
A_core = kron(v, A_core);
A = A_core + B;

% Apply similarity transform to mix eigenbasis
A = Q' * A * Q;

% Compute true eigenvalues for comparison
true_eigs = eig(A);
end