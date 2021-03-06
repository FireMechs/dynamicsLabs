%	Reg					Name
%	___					____
%	ENM221-0068/2017	Kipng'eno Erick Koech		
%	ENM221-0091/2017	Osodo Rodney David	
%	ENM221-0058/2017	Karimi Kelvin Gitu
%	ENM221-0273/2017	Kimani Claudio

%------------------------main--------------------------%

% [INFO]Arrays are initialized before assigning to boost the performance of the
% program.
function lab1
    [idx, sl] = listdlg('ListSize',[150,150],'PromptString',{'Select question'},'SelectionMode','single','ListString',{'a','b','c'});
    if(sl == 1)
        if (idx == 1)
                %----------- Quiz (a) ---------
                % least squares disabled
            question_a();% calls the get results function with 3 precision points
        end
        if (idx == 2)
                %----------- Quiz (b) ---------
                % least squares enabled
             question_b();
        end 
        if (idx == 3)
            question_c();
        end
    else
        quit(1);
    end
end
%------------Body------------------%
function question_a()
            theta2 = get_precision_angles(15,165,3);
            theta2 = arrayfun(@(val) rad2deg(val), theta2);% Changes the angles to degrees for the rest of the computation.
            theta4 = get_theta_4(theta2);% Obtain O4 from O2 from above.
            link_ratios = compute_freudensteins_constants(theta2, theta4);% uses freudeinsten equation to compute the link length ratios
            [a,b,c,d] = get_link_lengths(link_ratios);% using the link ratios from above the respective link lengths are obtained
            msgl = msgbox(sprintf("Crank: %f mm\n\n Coupler: %f mm\n\n Follower: %f mm\n\n Fixed: %f mm",a,b,c,d));
            set(msgl, 'Position',[730,400,100,120]);
            transmission_angles = get_transmission_angles(a,b,c,d,15,165,5);% transmission angles are then calculated
            % commenting  on the quality of the transmission angles
            if (all(transmission_angles >= 40)) || (all(transmission_angles <= 140))
                msg = msgbox(sprintf("All the transmission angles guarantee a smooth rotation"));
                set(msg, 'Position',[730,200,220,50]);
            else
                msg = msgbox(sprintf("Some transmission angles do not guarantee a smooth rotation"));
                set(msg, 'Position',[730,363,220,50])
            end
              % Plotting the input angles against the transmission angles.
            input_angles = 15:5:165;
             figure;
            plot(input_angles,transmission_angles,'r');
            xlabel("Input  angles");
            ylabel("Transmission angles");
            title("Transmission angles Vs Input  angles");
end

function question_b()
            theta2 = get_precision_angles(15,165,5);
            theta2 = arrayfun(@(val) rad2deg(val), theta2);% Changes the angles to degrees for the rest of the computation.
            theta4 = get_theta_4(theta2);% Obtain O4 from O2 from above.
            link_ratios = get_link_ratio_least_square(theta2, theta4);% uses freudeinsten equation to compute the link length ratios
            [a,b,c,d] = get_link_lengths(link_ratios);% using the link ratios from above the respective link lengths are obtained
            msgl = msgbox(sprintf("Crank: %f mm\n\n Coupler: %f mm\n\n Follower: %f mm\n\n Fixed: %f mm",a,b,c,d));
            set(msgl, 'Position',[730,400,100,120]);
            transmission_angles = get_transmission_angles(a,b,c,d,15,165,5);% transmission angles are then calculated
            % commenting  on the quality of the transmission angles
            if (all(transmission_angles >= 40)) || (all(transmission_angles <= 140))
                msg = msgbox(sprintf("All the transmission angles guarantee a smooth rotation"));
                set(msg, 'Position',[730,200,220,50]);
            else
                msg = msgbox(sprintf("Some transmission angles do not guarantee a smooth rotation"));
                set(msg, 'Position',[730,363,220,50])
            end
              % Plotting the input angles against the transmission angles.
            input_angles = 15:5:165;
             figure;
            plot(input_angles,transmission_angles,'r');
            xlabel("Input  angles");
            ylabel("Transmission angles");
            title("Transmission angles Vs Input  angles");
end

function question_c()
    theta2 = get_precision_angles(15,165,3);
    theta2 = arrayfun(@(val) rad2deg(val), theta2);% Changes the angles to degrees for the rest of the computation.
    theta4 = get_theta_4(theta2);% Obtain O4 from O2 from above.
    link_ration_A = compute_freudensteins_constants(theta2, theta4);% uses freudeinsten equation to compute the link length ratios

    theta2 = get_precision_angles(15,165,5);
    theta2 = arrayfun(@(val) rad2deg(val), theta2);% Changes the angles to degrees for the rest of the computation.
    theta4 = get_theta_4(theta2);% Obtain O4 from O2 from above.
    link_ration_B = get_link_ratio_least_square(theta2, theta4);% uses freudeinsten equation to compute the link length ratios

    input_angles = 15:5:165;
        % get the corresponding output angles
    output_angles = get_theta_4(input_angles);
    structural_errors_A = get_structural_errors(input_angles, output_angles,link_ration_A);
    structural_errors_B = get_structural_errors(input_angles, output_angles,link_ration_B);
    figure;
    plot(input_angles, structural_errors_A,'r-',input_angles, structural_errors_B,'b-');
    xlabel("Input angles");
    ylabel("Structural Error");
    title("Structural Errors Vs Input  angles");
end

function link_ration = generateLinkRatios(precision, lsqrBool)
    theta2 = get_precision_angles(15,165,precision);
    theta2 = arrayfun(@(val) rad2deg(val), theta2);% Changes the angles to degrees for the rest of the computation.
    theta4 = get_theta_4(theta2);% Obtain O4 from O2 from above.
    link_ration = get_link_ratios(theta2, theta4,lsqrBool);% uses freudeinsten equation to compute the link length
end
function precision_angles = get_precision_angles(l_limit, u_limit, n_angles)
    % uses chebyshev's spacing to find the precision angles
    % l_limit: The lower limit for teh range
    % u_limit: The upper limit for the range
    % n_angles; The number of precision precision points
    % Using  angles in radians for chebyshev's spacing formula proved to be easy. 
    l_limit = deg2rad(l_limit);
    u_limit = deg2rad(u_limit);
    precision_angles = zeros(1, n_angles);
    % Obtain the precision points using the formula
    for i = 1:n_angles
        precision_angles(i) = ((1/2)*(l_limit + u_limit))-((1/2)*(u_limit-l_limit)*cos((pi * (2*i - 1))/(2*n_angles)));
    end
end
function theta_4 = get_theta_4(theta_2)
    % using the given output function, this function computes the output
    % angles from the given input angles
    % output_angle = 65 + (0.43 * input_angle)
    theta_4 = zeros(1,length(theta_2));% Initialize first before use to optimize performance.
    j = 1;
    for angle2 = theta_2
        theta_4(j) = 65 + 0.43*angle2;% output mechanism function
        j = j + 1;
    end
end

function link_ratios = compute_freudensteins_constants(theta2, theta4)
   % We will use the Freudenstein’s equation. It relate the input to output as a function
   % of the size of the linkages. For a given input φ we can use this equation to solve for the
   % output ψ
   % Equation: k1(cos ψ) − k2(cos φ) + k3 = cos(φ − ψ)
   % To form a complete and functional matrix the two 1D arrays  should be
   % of the same length. If not, this raises a compile time error.
   if(length(theta4) ~= length(theta2))
       disp("Matrices' lengths not equal");
       quit(1);
   end
   A = [];
   b = [];
   % rows in both the matrices are added in a loop with columns in each
   for i = 1:length(theta2)
       temp1 = [(cosd(theta4(i))) (-1 * (cosd(theta2(i)))) (1)];
       temp2 = cosd(theta2(i)-theta4(i));
       A = [A; temp1];
       b = [b; temp2];
   end
   link_ratios = linsolve(A,b);
end

function link_ratios  = get_link_ratio_least_square(theta2, theta4)
   % using the freudensteins method, this method computes the link ratios
   
   % To form a complete and functional matrix the two 1D arrays  should be
   % of the same length. If not, this raises a compile time error.
   if(length(theta4) ~= length(theta2))
       disp("Matrices' lengths not equal");
       quit(1);
   end
   A = [];
   b = [];
   % rows in both the matrices are added in a loop with columns in each
   for i = 1:length(theta2)
       temp1 = [(cosd(theta4(i))) (-1 * (cosd(theta2(i)))) (1)];
       temp2 = cosd(theta2(i)-theta4(i));
       A = [A; temp1];
       b = [b; temp2];
   end
   % Least squares method of solving a system of linear equations simple
   % augmenting the matrix formed by the equations and row reducing it.
   link_ratios = lsqr(A,b);
end
function [a,b,c,d] = get_link_lengths(link_ratios)
% get_link_lengths uses the link ratios and the fixed link to find the
% lengths of the other links.
% Lengths can be negatives therefore absolutes of the calculated values are
% sorted.
    d = 410;
    a = abs(d/link_ratios(1));
    c = abs(d/link_ratios(2));
    b = abs(sqrt(a^2  + c^2 + d^2 -(link_ratios(3) * 2 * a * c)));
end
function transmission_angles = get_transmission_angles(a,b,c,d,lower_limit, upper_limit, steps)
% Transmission anngles are calculated using the obtained link lengths and
% and the respective input angles 
    transmission_angles = zeros(1, ((165-15)/5));
    j = 1;
    for i = lower_limit:steps:upper_limit
        m = acosd(((b^2 + c^2) - (a^2 + d^2) + (2 * a * d * cosd(i))) / (2 * b * c));
        transmission_angles(j) = m;
        j = j + 1;
    end
end
function structuralErrors = get_structural_errors(theta2, theta4, link_ratios)
% Structural error is basically the difference between the left side of the
% freudeinsten's equation and the right side.
    structuralErrors = zeros(1,length(theta2));% theta4 can also be used since they are of the same length
    for i = 1:length(theta4)
        er1 = link_ratios(1)*cosd(theta4(i)) - link_ratios(2)*cosd(theta2(i)) + link_ratios(3) - cosd(theta2(i) - theta4(i));
        structuralErrors(i) = er1;
    end
end

