function I = left_rectangles_integration(f, a, b, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize integral value
    I = 0;
    
    % Iterate over each step
    for i = 1:N
        % Calculate x value for the left endpoint of the rectangle
        x_i = a + (i - 1) * h;
        
        % Evaluate function value at x_i
        f_i = f(x_i);
        
        % Add area of rectangle to integral
        I = I + f_i * h;
    end
end
