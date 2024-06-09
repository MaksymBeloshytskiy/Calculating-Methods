function I = simpsons_integration(f, a, b, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize integral value
    I = 0;
    
    % Evaluate function at endpoints
    f_a = f(a);
    f_b = f(b);
    
    % Add contributions from endpoints
    I = I + f_a + f_b;
    
    % Iterate over each step
    for i = 1:(N-1)
        % Calculate x value for current step
        x_i = a + i * h;
        
        % Evaluate function value at x_i
        f_i = f(x_i);
        
        % Add contribution from current step
        if mod(i,2) == 0
            % If i is even
            I = I + 2 * f_i;
        else
            % If i is odd
            I = I + 4 * f_i;
        end
    end
    
    % Multiply by h/3
    I = (h / 3) * I;
end
