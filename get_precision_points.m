function precision_points = get_precision_points(lower_limit, upper_limit, no_of_points)
    precision_points = zeros(1,no_of_points);
    for val = 1:no_of_points
        precision_points(val) = (0.5 * (lower_limit + upper_limit)) - (0.5 * (upper_limit - lower_limit) * cos((pi * (2 * val - 1)) / (2 * no_of_points)));
    end
end