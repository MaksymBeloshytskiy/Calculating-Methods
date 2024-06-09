function X = gauss_jordan_method()
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
    
    % Perform Gauss-Jordan elimination
    for i = 1:n
        % Find pivot row and swap rows if necessary
        [~, max_row] = max(abs(AB(i:n, i)));
        max_row = max_row + i - 1;
        if max_row ~= i
            AB([i max_row], :) = AB([max_row i], :);
        end
        
        % Normalize pivot row
        AB(i, :) = AB(i, :) / AB(i, i);
        
        % Eliminate non-zero elements below pivot
        for j = 1:n
            if j ~= i
                AB(j, :) = AB(j, :) - AB(j, i) * AB(i, :);
            end
        end
    end
    
    % Extract solution vector
    X = AB(:, end);
end
