function I = trapezoidal_integration(f, a, b, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize integral value
    I = 0;
    
    % Evaluate function at endpoints
    f_a = f(a);
    f_b = f(b);
    
    % Iterate over each step
    for i = 1:(N-1)
        % Calculate x value for current step
        x_i = a + i * h;
        
        % Evaluate function value at x_i
        f_i = f(x_i);
        
        % Add area of trapezoid to integral
        I = I + f_i;
    end
    
    % Add contributions from endpoints
    I = h * (0.5 * (f_a + f_b) + I);
end
