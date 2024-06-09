function X = cramer_method()
    % Prompt user for input
    A = input('Enter the coefficient matrix A: ');
    B = input('Enter the column vector of free terms B: ');

    % Check if A is square
    [n, m] = size(A);
    if n ~= m
        error('Coefficient matrix must be square');
    end
    
    % Check if A is singular
    if abs(det(A)) < eps
        error('Coefficient matrix is singular, system may not have a unique solution');
    end
    
    % Check if number of equations matches length of B
    if n ~= length(B)
        error('Number of equations must match the length of the vector of free terms');
    end
    
    % Solve system using Cramer's method
    X = zeros(n, 1);

    for i = 1:n
        % Replace the ith column of A with B
        Ai = A;
        Ai(:, i) = B;
        
        % Calculate the determinant of the modified matrix
        det_Ai = det(Ai);
        
        % Calculate Xi using Cramer's rule
        X(i) = det_Ai / det(A);
    end
    
    % Display result
    disp('The solution vector X is:');
    disp(X);
end
