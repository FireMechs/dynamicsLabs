function theta_4 = get_theta_4(theta_2)
    theta_4 = zeros(1, length(theta_2));
    j = 1;
    for i = theta_2
        theta_4(j) = 65 * (0.43 * i);
        j = j + 1;
    end
end