# Kinematics Solver Readme

This repository contains MATLAB scripts for solving kinematics problems, specifically for calculating shaking forces and moments in a mechanical system.

## Files

-   `matrix_calculator.m`: Main script for setting up the kinematic equations, defining links, and solving for unknown forces and torques.
-   `shaking_calculator.m`: Script that takes the outputs from the matrix calulator and calcualtes the shaking force, total shaking force, direction and moment.
-   `Link.m`: Class definition for a Link object, representing a rigid body with applied forces and torques.
-   `Vector3D.m`: Class definition for a 3D vector object, used for representing forces, positions, and other spatial quantities.

## Description

The `matrix_calculator.m` script uses symbolic math to derive the force and torque balance equations for a system of interconnected links. It defines `Link` objects, applies forces and torques to them, and then solves the resulting system of equations for the unknown forces and torques.

`shaking_calculator.m` computes the resulting shaking force and moment

## Usage

1.  Ensure you have MATLAB installed.
2.  Edit the variables/change the system linkage design as necessary
3.  Run `matrix_calculator.m` to solve for the unknown forces and torques in the system.
4.  Run 'shaking_calculator.m' to determine the shaking force and moment

## Donations

* monero:83B495T1N3sje9vXMqNShbSx99g1QjKyL8YKjvU6rt6hAkmwbVUrQ65QGEUsL3QxVPdtiK91GnCP7bG2oCz7h1PDKsoCPB1
* ![monero:83B495T1N3sje9vXMqNShbSx99g1QjKyL8YKjvU6rt6hAkmwbVUrQ65QGEUsL3QxVPdtiK91GnCP7bG2oCz7h1PDKsoCPB1](https://raw.githubusercontent.com/pjn388/Kinematics-solver/refs/heads/main/static/images/uni_recieve.png?raw=true)
