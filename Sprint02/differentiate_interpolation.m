function F = differentiate_interpolation(x, f, X)
    n = length(x);
    m = length(X);
    F = zeros(1, m);
    for k = 1:m
        idx = find_nearest_index(x, X(k));
        nodes = max(1, idx - 2):min(n, idx + 2);
        coefficients = lagrange_coefficients(x(nodes), f(nodes));
        F(k) = differentiate_polynomial(x(nodes), coefficients, X(k));
    end
end

function idx = find_nearest_index(x, val)
    [~, idx] = min(abs(x - val));
end

function coefficients = lagrange_coefficients(x, f)
    n = length(x);
    coefficients = zeros(1, n);
    for i = 1:n
        denominator = 1;
        for j = 1:n
            if j ~= i
                denominator = denominator * (x(i) - x(j));
            end
        end
        coefficients(i) = f(i) / denominator;
    end
end

function F = differentiate_polynomial(x, coefficients, X)
    n = length(x);
    F = 0;
    for i = 1:n
        L_prime = 0;
        for j = 1:n
            if j ~= i
                prod = 1 / (x(i) - x(j));
                for k = 1:n
                    if k ~= i && k ~= j
                        prod = prod * (X - x(k));
                    end
                end
                L_prime = L_prime + prod;
            end
        end
        F = F + coefficients(i) * L_prime;
    end
end
