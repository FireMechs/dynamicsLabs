% get the precision points using chebyshev's spacing.
function precision_points = get_precision_points(lower_limit, upper_limit, no_of_points)
    precision_points = zeros(1,no_of_points);
    for val = 1:no_of_points
        precision_points(val) = (0.5 * (lower_limit + upper_limit)) - (0.5 * (upper_limit - lower_limit) * cos((pi * (2 * val - 1)) / (2 * no_of_points)));
    end
end
% get theta4 from theta2
function theta_4 = get_theta_4(theta_2)
    theta_4 = zeros(1, length(theta_2));
    j = 1;
    for i = theta_2
        theta_4(j) = 65 * (0.43 * i);
        j = j + 1;
    end
end
% convert the angles
function new_angles = convert_angles_to_radians(angles)
    new_angles  = zeros(1, length(angles));
    j = 1;
    for i = angles
        new_angles(j) = deg2rad(i);
        j = j + 1;
    end
end
% compute freudenstein's constants
function constants  = compute_freudensteins_constants(input_angles, output_angles)
    input_angles = convert_angles_to_radians(input_angles);
    output_angles = convert_angles_to_radians(output_angles);
    A = [(cos(output_angles(1))) (-1 * cos(input_angles(1))) (1);
         (cos(output_angles(2))) (-1 * cos(input_angles(2))) (1);
         (cos(output_angles(3))) (-1 * cos(input_angles(3))) (1)];
    B = [
        cos(input_angles(1) - output_angles(1));
        cos(input_angles(2) - output_angles(2));
        cos(input_angles(3) - output_angles(3))];
    constants = A\B;
end
% get transmission angles
function transmission_angles = get_transmission_angles(a,b,c,d,lower_limit, upper_limit, steps)
    transmission_angles = zeros(1, ((165-15)/5));
    j = 1;
    for i = lower_limit:steps:upper_limit
        m = acos(((b * b + c * c) - (a * a + d * d) + (2 * a * d * cos(deg2rad(i)))) / (2 * b * c));
        transmission_angles(j) = m;
        j = j + 1;
    end
end
% get link lengths
function  [a,b,c,d] = lengths_of_links(constants)
    d = 410;
    a = d / constants(1);
    c = d / constants(2);
    b = sqrt((a * a) + (c * c) + (d * d) - (2 * a * c * constants(3)));
end
%---------Main-------------
theta2 = get_precision_points(15,165,3);
theta4 = get_theta_4(theta2);
constants = compute_freudensteins_constants(theta2, theta4);
disp(["The constants are k1: ", constants(1)," k2: ", constants(2)," k3: ", constants(3)]);
[a,b,c,d] = lengths_of_links(constants);
disp(["The lengths of the links are crank:", a,"  coupler: ", b, " follower ", c, "fixed ", d]);
transmission_angles = get_transmission_angles(a,b,c,d,15,165, 5);
disp(["Transmission angles: ", transmission_angles]);
%plotting
figure;
input_angles = 15:5:165;
plot(input_angles, transmission_angles, 'r');
xlabel("Input angles");
ylabel("Output angles");
title("Input angles vs transmission angles");
