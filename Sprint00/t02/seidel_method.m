function X = seidel_method()
    % Prompt user for input
    A = input('Enter the coefficient matrix A: ');
    B = input('Enter the column vector of free terms B: ');

    % Constants for convergence criteria
    tolerance = 1e-9; % Tolerance for convergence
    max_iterations = 1000; % Maximum number of iterations
    
    % Check if A is square
    [n, m] = size(A);
    if n ~= m
        error('Coefficient matrix must be square');
    end
    
    % Check if number of equations matches length of B
    if n ~= length(B)
        error('Number of equations must match the length of the vector of free terms');
    end
    
    % Scale the system of equations to improve convergence
    scaling_factors = max(abs(A), [], 2);
    scaled_A = A ./ scaling_factors;
    scaled_B = B ./ scaling_factors;
    
    % Initialize solution vector
    X = zeros(n, 1);
    
    % Initialize iteration counter
    iterations = 0;
    
    % Main loop
    while true
        iterations = iterations + 1;
        
        % Store previous solution for convergence check
        X_old = X;
        
        % Update solution vector using Gauss-Seidel iteration
        for i = 1:n
            sigma = 0;
            for j = 1:n
                if j ~= i
                    sigma = sigma + scaled_A(i, j) * X(j);
                end
            end
            X(i) = (scaled_B(i) - sigma) / scaled_A(i, i);
        end
        
        % Check for convergence
        if norm(X - X_old, inf) < tolerance || iterations >= max_iterations
            break;
        end
    end
    
    % Check for convergence
    if iterations >= max_iterations
        warning('Seidel''s method did not converge within the specified maximum number of iterations');
    end
    
    % Undo scaling to obtain the final solution
    X = X ./ scaling_factors;
    
    % Display result
    disp('The solution vector X is:');
    disp(X);
end
