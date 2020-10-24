%------------------------main--------------------------%
function lab1
    %----------- Quiz (a) ---------
    theta2 = get_precision_angles(15,165,3);
    %----------- Quiz (b) ---------
    %theta2  = get_precision_angles(15,165,5);
    theta2 = arrayfun(@(val) rad2deg(val), theta2);
    theta4 = get_theta_4(theta2);
    link_ratios = get_link_ratios(theta2, theta4);
    [a,b,c,d] = get_link_lengths(link_ratios);
    disp(["Crank: ",a]);
    disp(["Coupler: ",b]);
    disp(["Follower: ",c]);
    disp(["Fixed Link: ",d]);
    transmission_angles = get_transmission_angles(a,b,c,d,15,165,5);
    % commenting  on the transmission angles
    if (all(transmission_angles >= 40)) || (all(transmission_angles <= 140))
        disp("All the transmission angles guarantee a smooth rotation");
    else
        disp("Some transmission angles do not guarantee a smooth rotation");
    end
    input_angles = 15:5:165;
    figure;
    plot(input_angles,transmission_angles,'r');
    xlabel("Input  angles");
    ylabel("Transmission angles");
    title("Input  angles vs transmission angles");
end
%------------Body------------------%
function precision_angles = get_precision_angles(l_limit, u_limit, n_angles)
    % uses chebyshev's spacing to find the precision angles
    
    l_limit = deg2rad(l_limit);
    u_limit = deg2rad(u_limit);
    precision_angles = zeros(1, n_angles);
    for i = 1:n_angles
        precision_angles(i) = ((1/2)*(l_limit + u_limit))-((1/2)*(u_limit-l_limit)*cos((pi * (2*i - 1))/(2*n_angles)));
    end
end
function theta_4 = get_theta_4(theta_2)
    % using the given output function, this function computes the output
    % angles from the given input angles
    theta_4 = zeros(1,length(theta_2));
    j = 1;
    for angle2 = theta_2
        theta_4(j) = 65 + 0.43*angle2;
        j = j + 1;
    end
end
function link_ratios  = get_link_ratios(theta2, theta4)
   % using the freudensteins method, this method computes the link ratios
   if(length(theta4) ~= length(theta2))
       disp("Matrices' lengths not equal");
       quit(1);
   end
   A = [];
   b = [];
   for i = 1:length(theta2)
       temp1 = [(cosd(theta4(i))) (-1 * (cosd(theta2(i)))) (1)];
       temp2 = cosd(theta2(i)-theta4(i));
       A = [A; temp1];
       b = [b; temp2];
   end
   disp(A);
   disp("------------");
   disp(b);
   link_ratios = A\b;% backstroke uses the least squares method
end
function [a,b,c,d] = get_link_lengths(link_ratios)
    d = 410;
    a = d/link_ratios(1);
    c = d/link_ratios(2);
    b = sqrt(a^2  + c^2 + d^2 -(link_ratios(3) * 2 * a * c));
end
function transmission_angles = get_transmission_angles(a,b,c,d,lower_limit, upper_limit, steps)
    transmission_angles = zeros(1, ((165-15)/5));
    j = 1;
    for i = lower_limit:steps:upper_limit
        m = acosd(((b^2 + c^2) - (a^2 + d^2) + (2 * a * d * cosd(i))) / (2 * b * c));
        transmission_angles(j) = m;
        j = j + 1;
    end
end


