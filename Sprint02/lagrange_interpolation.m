function F = lagrange_interpolation(x, f, X)
    n = length(x);
    m = length(X);
    F = zeros(1, m);
    for k = 1:m
        L = ones(1, n);
        for i = 1:n
            for j = 1:n
                if j ~= i
                    L(i) = L(i) * (X(k) - x(j)) / (x(i) - x(j));
                end
            end
        end
        F(k) = sum(f .* L);
    end
end
