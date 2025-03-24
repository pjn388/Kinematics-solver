function [x, y, z] = sym_to_xyz(base_sym)
    base_str = string(base_sym);
    is_negative = false;

    if startsWith(base_str, '-')
        is_negative = true;
        base_str = extractAfter(base_str, '-');
    end

    x_name = char(strcat(base_str, "x"));
    y_name = char(strcat(base_str, "y"));
    z_name = char(strcat(base_str, "z"));

    syms(x_name);
    x = eval(x_name);

    syms(y_name);
    y = eval(y_name);

    syms(z_name);
    z = eval(z_name);

    if is_negative
        x = -x;
        y = -y;
        z = -z;
    end
end
