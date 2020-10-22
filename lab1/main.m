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