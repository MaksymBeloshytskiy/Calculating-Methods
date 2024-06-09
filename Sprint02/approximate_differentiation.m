function F = approximate_differentiation(x, f, X)
    n = length(x);
    m = length(X);
    F = zeros(1, m);
    
    % Check if x is uniformly spaced
    if any(diff(x) ~= x(2) - x(1))
        error('x must be uniformly spaced');
    end

    h = x(2) - x(1); % Step size, assuming uniform spacing
    
    for k = 1:m
        % Find the index of the closest node to X(k)
        [~, idx] = min(abs(x - X(k)));
        
        % Adjust index to ensure it's not too close to the edges
        if idx < 3
            idx = 3;
        elseif idx > n - 2
            idx = n - 2;
        end
        
        % Select five nodes around the closest index
        nodes = idx-2:idx+2;
        xx = x(nodes);
        ff = f(nodes);
        
        % Fit a polynomial of degree 4 to the selected nodes
        poly = polyfit(xx, ff, 4);
        
        % Differentiate the polynomial
        dpoly = polyder(poly);
        
        % Evaluate the derivative at X(k)
        F(k) = polyval(dpoly, X(k));
    end
end
