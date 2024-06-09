try
    % Prompt the user to input the coefficient matrix A
    disp('Enter the coefficient matrix A (each row separated by semicolon):');
    A = input('A = ');

    % Validate input matrix A
    validateattributes(A, {'numeric'}, {'2d', 'nonempty'}, 'solve_linear_system_script', 'A');

    % Prompt the user to input the vector of free terms B
    disp('Enter the vector of free terms B (each element separated by space or comma):');
    B = input('B = ');

    % Validate input vector B
    validateattributes(B, {'numeric'}, {'vector', 'numel', size(A, 1)}, 'solve_linear_system_script', 'B');

    % Call cramer_method to solve the system
    X = cramer_method(A, B);
    
    % Display the solution
    disp('Solution:');
    disp(X);
catch ME
    % Display error message
    disp('Error occurred:');
    disp(ME.message);
end
