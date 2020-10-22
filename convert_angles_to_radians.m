function new_angles = convert_angles_to_radians(angles)
    new_angles  = zeros(1, length(angles));
    j = 1;
    for i = angles
        new_angles(j) = deg2rad(i);
        j = j + 1;
    end
end