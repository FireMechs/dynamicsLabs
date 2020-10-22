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