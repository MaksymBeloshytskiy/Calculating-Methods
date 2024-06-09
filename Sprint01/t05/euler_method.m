function [x, y] = euler_method(f, a, b, y0, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize arrays to store x and y values
    x = zeros(1, N+1);
    y = zeros(1, N+1);
    
    % Set initial values
    x(1) = a;
    y(1) = y0;
    
    % Perform Euler's method
    for i = 1:N
        x(i+1) = x(i) + h;
        y(i+1) = y(i) + h * f(x(i), y(i));
    end
end
