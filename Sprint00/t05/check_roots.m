function flag = check_roots(method)
    % Prompt user for input
    A = input('Enter the coefficient matrix A: ');
    B = input('Enter the column vector of free terms B: ');

    % Constants
    tolerance = 1e-9; % Tolerance for convergence

    % Call the specified method to obtain roots
    switch method
        case 'cramer'
            X = cramer_method(A, B);
        case 'gauss'
            X = gauss_method(A, B);
        case 'seidel'
            X = seidel_method(A, B, tolerance, 1000); % Maximum iterations set to 1000
        case 'jacobi'
            X = jacobi_method(A, B, tolerance, 1000); % Maximum iterations set to 1000
        case 'gauss_jordan'
            X = gauss_jordan_method(A, B);
        otherwise
            error('Invalid method specified');
    end

    % Check if A is square
    [n, m] = size(A);
    if n ~= m
        error('Coefficient matrix must be square');
    end
    
    % Check if number of equations matches length of B
    if n ~= length(B)
        error('Number of equations must match the length of the vector of free terms');
    end
    
    % Calculate residual vector
    residual = A * X - B;
    
    % Check if residuals are within tolerance
    flag = all(abs(residual) < tolerance);
end
