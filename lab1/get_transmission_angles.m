function transmission_angles = get_transmission_angles(a,b,c,d,lower_limit, upper_limit, steps)
    transmission_angles = zeros(1, ((165-15)/5));
    j = 1;
    for i = lower_limit:steps:upper_limit
        m = acos(((b * b + c * c) - (a * a + d * d) + (2 * a * d * cos(deg2rad(i)))) / (2 * b * c));
        transmission_angles(j) = m;
        j = j + 1;
    end
end