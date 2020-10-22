function  [a,b,c,d] = lengths_of_links(constants)
    d = 410;
    a = d / constants(1);
    c = d / constants(2);
    b = sqrt((a * a) + (c * c) + (d * d) - (2 * a * c * constants(3)));
end