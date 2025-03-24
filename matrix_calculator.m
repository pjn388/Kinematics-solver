clc; clear;

% define links, have put the origin at the mass centre as this is what the question asks but user another origin works. U can even mix and match ;)
syms r_1 f_13 f_12
f_31 = -f_13;

link1 = Link(0, Vector3D.from_zero("ground"));
link1 = link1.addForce(Vector3D.from_zero(), Vector3D.from_symbolic(-f_12));
link1 = link1.addForce(Vector3D.from_angle_2D(r_1, 0), Vector3D.from_symbolic(f_31));

syms m_2 r_2 t_12 theta_2 a_G2 alpha_2 I_2 f_32
f_23 = -f_32;

link2 = Link(m_2, Vector3D.from_zero(), Vector3D.from_symbolic(a_G2), Vector3D.from_scalar_z(alpha_2), I_2);
link2 = link2.addForce(Vector3D.from_zero(), Vector3D.from_symbolic(f_12));
link2 = link2.addForce(Vector3D.from_angle_2D(r_2, theta_2), Vector3D.from_symbolic(f_32));
link2 = link2.addTorque(Vector3D.from_scalar_z(t_12));

syms m_3 r_3 r_3G theta_3 a_G3 alpha_3 I_3

link3 = Link(m_3, Vector3D.from_zero(), Vector3D.from_symbolic(a_G3), Vector3D.from_scalar_z(alpha_3), I_3);
link3 = link3.addForce(Vector3D.from_angle_2D(-r_3G, -theta_3), Vector3D.from_symbolic(f_13));
link3 = link3.addForce(Vector3D.from_angle_2D(-r_3G+r_3, -theta_3), Vector3D.from_symbolic(f_23));


% do force and torque sums
[sumForces1, sumTorques1] = link1.force_balance();
link1.display();
[sumForces2, sumTorques2] = link2.force_balance();
link2.display();
[sumForces3, sumTorques3] = link3.force_balance();
link3.display();


% collect relevent sums
% x_force_sums = [sumForces1.x, sumForces2.x, sumForces3.x];
% y_force_sums = [sumForces1.y, sumForces2.y, sumForces3.y];
x_force_sums = [sumForces2.x, sumForces3.x];
y_force_sums = [sumForces2.y, sumForces3.y];
% z_force_sums = [sumForces1.z, sumForces2.z, sumForces3.z];

% x_torque_sums = [sumTorques1.x, sumTorques2.x, sumTorques3.x];
% y_torque_sums = [sumTorques1.y, sumTorques2.y, sumTorques3.y];
% z_torque_sums = [sumTorques1.z, sumTorques2.z, sumTorques3.z];
z_torque_sums = [sumTorques2.z, sumTorques3.z];

% get the relevent equations
equations = [x_force_sums, y_force_sums, z_torque_sums]
syms f_12x f_12y f_32x f_32y f_13x f_13y
variables = [f_12x, f_12y, f_32x, f_32y, f_13x, f_13y, t_12]

[A, B] = equationsToMatrix(equations, variables)

% sub in the known parameters
% Define values for the symbolic variables
syms omega_3
omega_3_val = 0.1455;
r_1_val = 5.7;
r_2_val = 3.3;
r_3_val = (Vector3D.from_angle_2D(r_2, theta_2) - Vector3D.from_scalar_x(r_1));
r_3_val = r_3_val.getMagnitude();

r_3G_val = 7.6;

theta_2_val = deg2rad(58);
theta_3_val = deg2rad(144.69);

m_2_val = 3.9;
m_3_val = 5.4;

I_2_val = 0.2;
I_3_val = 0.95;

a_G2y_val = 0;
a_G2x_val = 0;

alpha_2_val = 0;
alpha_3_val = 8.5822;

% define subs
syms a_G2x a_G2y% we know these are zero since the mass is at the pivot
vars = {a_G2x, a_G2y, r_1, r_2, theta_2, r_3, r_3G, theta_3, m_2, m_3, I_2, alpha_2, I_3, omega_3, alpha_3};
values = {a_G2y_val, a_G2x_val, r_1_val, r_2_val, theta_2_val, r_3_val, r_3G_val, theta_3_val, m_2_val, m_3_val, I_2_val, alpha_2_val, I_3_val, omega_3_val, alpha_3_val};

% substitude values into unknown parameters
r_3_val = double(subs(r_3_val, vars, values));
a_G3x_val = double(subs(-r_3G*cos(theta_3)*omega_3^2 - r_3G*sin(theta_3)*alpha_3, vars, values));
a_G3y_val = double(subs(-r_3G*sin(theta_3)*omega_3^2 + r_3G*cos(theta_3)*alpha_3, vars, values));

syms r_3 a_G3x a_G3y
vars = [vars, {r_3, a_G3x, a_G3y}];
values = [values, {r_3_val, a_G3x_val, a_G3y_val}];

% Substitute the values into the matrices
A_evaluated = subs(A, vars, values);
B_evaluated = subs(B, vars, values);

% Display the evaluated matrices
disp('Evaluated Matrix A:');
disp(double(A_evaluated));
disp('Evaluated Matrix B:');
disp(double(B_evaluated));




