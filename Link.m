classdef Link
    properties
        Mass
        MassLocation % Vector3D
        Forces % Vector3D
        Torques % Vector3D
        Acceleration % Vector3D
        Angular_Acceleration % Vector3D
        Moment_Inertia % numeric
    end

    methods
        function obj = Link(mass, massLocation, Acceleration, Angular_Acceleration, Moment_Inertia)
            % Constructor
            % this is bad nested logic can be simplified
            if nargin > 0
                obj.Mass = mass;
                obj.MassLocation = massLocation;
                if nargin > 2
                    obj.Acceleration = Acceleration;
                    obj.Angular_Acceleration = Angular_Acceleration;
                    obj.Moment_Inertia = Moment_Inertia;
                else
                    obj.Acceleration = Vector3D.from_zero();
                    obj.Angular_Acceleration = Vector3D.from_zero();
                    obj.Moment_Inertia = 0;
                end
            else
                obj.Acceleration = Vector3D.from_zero();
                obj.Angular_Acceleration = Vector3D.from_zero();
            end
            obj.Forces = struct('Location', {}, 'Force', {});
            obj.Torques = struct('Torque', {});
        end

        function obj = addForce(obj, location, force)
            % Add a force at a specific location
            newForce.Location = location; % Vector3D
            newForce.Force = force; % Vector3D
            obj.Forces(end+1) = newForce;
        end

        function obj = addTorque(obj, torque)
            % Add a torque
            newTorque.Torque = torque; % Vector3D
            obj.Torques(end+1) = newTorque;
        end

        function display(obj)
            % Display Link properties
            fprintf('Link Mass: %s\n', string(obj.Mass));
            fprintf('Mass Location: ');
            obj.MassLocation.disp;
            fprintf('Forces:\n');
            for i = 1:length(obj.Forces)
                fprintf('  Force %d:\n', i);
                fprintf('    Location: ');
                obj.Forces(i).Location.disp;
                fprintf('    Force: ');
                if isnumeric(obj.Forces(i).Force)
                    disp(obj.Forces(i).Force);
                elseif isa(obj.Forces(i).Force, 'sym')
                    disp(obj.Forces(i).Force);
                else
                    obj.Forces(i).Force.disp;
                end
            end

            fprintf('Torques:\n');
            for i = 1:length(obj.Torques)
                fprintf('  Torque %d:\n', i);
                obj.Torques(i).Torque.disp;
            end
        end
        function [sumForces, sumTorques] = force_balance(obj)
            % Initialize sums
            sumForces = Vector3D.from_zero();
            sumTorques = Vector3D.from_zero();

            % Sum of forces in x and y directions
            for i = 1:length(obj.Forces)
                sumForces = sumForces + obj.Forces(i).Force;

                r = obj.Forces(i).Location;
                F = obj.Forces(i).Force;
                sumTorques = sumTorques + r*F;
            end

            % Add external torques
            for i = 1:length(obj.Torques)
                sumTorques = sumTorques + obj.Torques(i).Torque; 
            end
            force_right = obj.Acceleration*obj.Mass;
            sumForces = Vector3D(sumForces.x == force_right.x, sumForces.y == force_right.y, sumForces.z == force_right.z);
            
            torque_right = obj.Acceleration*obj.MassLocation*obj.Mass + obj.Angular_Acceleration*obj.Moment_Inertia;
            sumTorques = Vector3D(sumTorques.x == torque_right.x, sumTorques.y == torque_right.y, sumTorques.z == torque_right.z);
        end
    end
end
