A = [
    1, 0, 1, 0, 0, 0, 0;
    0, 1, 0, 1, 0, 0, 0;
    0, 0, -2.0142, 1.945, 0, 0, 1;
    0, 0, -1, 0, 1, 0, 0;
    0, 0, 0, -1, 0, 1, 0;
    0, 0, -1.586, -2.1694, 3.6002, 4.9243, 0;
    0, 0, 1, -0.7311, 0, 0, 0
]
B = [
    0;
    0;
    0;
    -419.3368;
    -588.9551;
    18.7126;
    0
]


X = A \ B;

f_12x = X(1)
f_12y = X(2)
f_32x = X(3)
f_32y = X(4)
f_13x = X(5)
f_13y = X(6)
t_12 = X(7)

shaking_force_x = -f_12x-f_13x
shaking_force_y = -f_12y-f_13y
shaking_total = sqrt(shaking_force_x^2+shaking_force_y^2)

shaking_direction = rad2deg(atan2(shaking_force_y, shaking_force_x))


r_1 = 4.7
% Im not sure if this is the correct equation
shaking_moment = -t_12 - r_1*f_13y