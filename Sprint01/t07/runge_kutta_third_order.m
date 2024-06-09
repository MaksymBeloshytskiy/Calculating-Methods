function [x, y] = runge_kutta_third_order(f, a, b, y0, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize arrays to store x and y values
    x = zeros(1, N+1);
    y = zeros(1, N+1);
    
    % Set initial values
    x(1) = a;
    y(1) = y0;
    
    % Perform Runge-Kutta third order method
    for i = 1:N
        k1 = h * f(x(i), y(i));
        k2 = h * f(x(i) + h/2, y(i) + k1/2);
        k3 = h * f(x(i) + h, y(i) - k1 + 2*k2);
        
        y(i+1) = y(i) + (k1 + 4*k2 + k3) / 6;
        x(i+1) = x(i) + h;
    end
end
