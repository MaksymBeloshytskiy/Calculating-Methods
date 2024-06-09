function F = newton_interpolation(x, f, X)
    n = length(x);
    divided_diff = zeros(n, n);
    divided_diff(:, 1) = f(:);
    for j = 2:n
        for i = 1:(n-j+1)
            divided_diff(i, j) = (divided_diff(i+1, j-1) - divided_diff(i, j-1)) / (x(i+j-1) - x(i));
        end
    end
    
    coefficients = divided_diff(1, :);
    m = length(X);
    F = zeros(1, m);
    for k = 1:m
        P = coefficients(n);
        for j = (n-1):-1:1
            P = coefficients(j) + (X(k) - x(j)) * P;
        end
        F(k) = P;
    end
end
