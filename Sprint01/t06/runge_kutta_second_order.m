function [x, y] = runge_kutta_second_order(f, a, b, y0, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize arrays to store x and y values
    x = zeros(1, N+1);
    y = zeros(1, N+1);
    
    % Set initial values
    x(1) = a;
    y(1) = y0;
    
    % Perform Runge-Kutta second order method
    for i = 1:N
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h, y(i) + k1);
        
        y(i+1) = y(i) + 0.5 * (k1 + k2);
        x(i+1) = x(i) + h;
    end
end
