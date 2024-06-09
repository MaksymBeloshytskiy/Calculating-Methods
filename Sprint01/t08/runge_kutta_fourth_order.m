function [x_values, y_values] = runge_kutta_fourth_order(f, a, b, y0, N)
    % Step size
    h = (b - a) / N;
    
    % Initialize arrays to store x and y values
    x_values = zeros(1, N+1);
    y_values = zeros(1, N+1);
    
    % Set initial values
    x_values(1) = a;
    y_values(1) = y0;
    
    % Perform fourth-order Runge-Kutta method
    for i = 1:N
        k1 = h * f(x_values(i), y_values(i));
        k2 = h * f(x_values(i) + h/2, y_values(i) + k1/2);
        k3 = h * f(x_values(i) + h/2, y_values(i) + k2/2);
        k4 = h * f(x_values(i) + h, y_values(i) + k3);
        
        y_values(i+1) = y_values(i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
        x_values(i+1) = x_values(i) + h;
    end
end
