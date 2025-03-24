classdef Vector3D
    properties
        x
        y
        z
        Name
    end
    methods (Static)
        function obj = from_zero(varargin)
            obj = Vector3D(0, 0, 0, varargin{:});
        end
        function obj = from_scalar_x(scalar, varargin)
            if isa(scalar, 'sym')
                obj = Vector3D(scalar, 0, 0, char(scalar));
            else
                obj = Vector3D(scalar, 0, 0, varargin{:});
            end
        end
        function obj = from_scalar_y(scalar, varargin)
            if isa(scalar, 'sym')
                obj = Vector3D(0, scalar, 0, char(scalar));
            else
                obj = Vector3D(0, scalar, 0, varargin{:});
            end
        end
        function obj = from_scalar_z(scalar, varargin)
            if isa(scalar, 'sym')
                obj = Vector3D(0, 0, scalar, char(scalar));
            else
                obj = Vector3D(0, 0, scalar, varargin{:});
            end
        end
        function obj = from_symbolic(symbol, varargin)
            [x, y, z] = sym_to_xyz(symbol);
            obj = Vector3D(x, y, z, symbol);
        end
        function obj = from_angle_2D(magnitude, angle, varargin)
            obj = Vector3D(cos(angle)*magnitude, sin(angle)*magnitude, 0, varargin{:});
        end
    end
    methods
        function obj = Vector3D(x, y, z, varargin)
            if nargin > 0
                obj.x = x;
                obj.y = y;
                obj.z = z;
                if nargin > 3
                obj.Name = varargin{1};
                else
                    obj.Name = '';
        end
            else
                obj.x = 0;
                obj.y = 0.0;
                obj.z = 0;
                obj.Name = '';
            end
        end
        function norm = getNorm(obj)
            norm = sqrt(obj.x^2 + obj.y^2 + obj.z^2);
        end
         function magnitude = getMagnitude(obj)
            magnitude = sqrt(obj.x^2 + obj.y^2 + obj.z^2);
        end
        function symVar = getSymbolicVariable(obj)
            if ~isempty(obj.Name)
                symVar = sym(obj.Name);
            else
                error('Name is empty. Cannot create symbolic variable.');
            end
        end
         function disp(obj)
            if ~isempty(obj.Name)
                fprintf('Vector3D: %s: ', obj.Name);
            else
                fprintf('Vector3D: anonymouse: ');
            end
                fprintf('x: %s, y: %s, z: %s\n', string(obj.x), string(obj.y), string(obj.z));
        end
        function crossProduct = cross(obj1, obj2)
            x = obj1.y * obj2.z - obj1.z * obj2.y;
            y = obj1.z * obj2.x - obj1.x * obj2.z;
            z = obj1.x * obj2.y - obj1.y * obj2.x;
            crossProduct = Vector3D(x, y, z);
        end
        function result = mtimes(obj1, obj2)
            if isa(obj1, 'Vector3D') && isa(obj2, 'Vector3D')
                result = cross(obj1, obj2);
            elseif isa(obj1, 'Vector3D') && isnumeric(obj2)
                result = obj1.linear_times(obj2);
            elseif isnumeric(obj1) && isa(obj2, 'Vector3D')
                result = obj2.linear_times(obj1);

            elseif isa(obj1, 'Vector3D') && isa(obj2, 'sym')
                result = obj1.linear_times(obj2);
            elseif isa(obj1, 'sym') && isa(obj2, 'Vector3D')
                result = obj2.linear_times(obj1);

            else
                error('Unsupported operation.');
            end
        end
        function result = linear_times(obj1, obj2)
            if isa(obj1, 'Vector3D') && isa(obj2, 'Vector3D')
                result = Vector3D(obj1.x * obj2.x, obj1.y * obj2.y, obj1.z * obj2.z)
            elseif isa(obj1, 'Vector3D') && isnumeric(obj2)
                obj = obj1;
                scalar = obj2;
                result = Vector3D(obj.x .* scalar, obj.y .* scalar, obj.z .* scalar);
            elseif isnumeric(obj1) && isa(obj2, 'Vector3D')
                obj = obj2;
                scalar = obj1;
                result = Vector3D(obj.x .* scalar, obj.y .* scalar, obj.z .* scalar);

            elseif isa(obj1, 'Vector3D') && isa(obj2, 'sym')
                obj = obj1;
                scalar = obj2;
                result = Vector3D(obj.x .* scalar, obj.y .* scalar, obj.z .* scalar);
            elseif isa(obj1, 'sym') && isa(obj2, 'Vector3D')
                obj = obj2;
                scalar = obj1;
                result = Vector3D(obj.x .* scalar, obj.y .* scalar, obj.z .* scalar);


            else
                error('Unsupported operation.');
            end

        end
        function addition = plus(obj1, obj2)
            x = obj1.x + obj2.x;
            y = obj1.y + obj2.y;
            z = obj1.z + obj2.z;
            addition = Vector3D(x, y, z);
        end
        function addition = minus(obj1, obj2)
            x = obj1.x - obj2.x;
            y = obj1.y - obj2.y;
            z = obj1.z - obj2.z;
            addition = Vector3D(x, y, z);
        end
    end
end