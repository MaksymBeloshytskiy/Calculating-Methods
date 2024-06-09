function X = gauss_method()
    % Prompt user for input
    A = input('Enter the coefficient matrix A: ');
    B = input('Enter the column vector of free terms B: ');

    % Check if A is square
    [n, m] = size(A);
    if n ~= m
        error('Coefficient matrix must be square');
    end
    
    % Check if number of equations matches length of B
    if n ~= length(B)
        error('Number of equations must match the length of the vector of free terms');
    end
    
    % Augmented matrix
    AB = [A, B];
    
    % Forward elimination
    for k = 1:n-1
        for i = k+1:n
            factor = AB(i,k) / AB(k,k);
            AB(i,k:n+1) = AB(i,k:n+1) - factor * AB(k,k:n+1);
        end
    end
    
    % Back substitution
    X = zeros(n,1);
    X(n) = AB(n,n+1) / AB(n,n);
    for i = n-1:-1:1
        X(i) = (AB(i,n+1) - AB(i,i+1:n) * X(i+1:n)) / AB(i,i);
    end
    
    % Display result
    disp('The solution vector X is:');
    disp(X);
end
