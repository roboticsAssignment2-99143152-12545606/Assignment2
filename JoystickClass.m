classdef JoystickClass
    %% Description
    % Class will initialise an instance of Joystick, and allow the
    % reading of the joystick
    properties
        axes;
        buttons;
        povs;
    end
    
    methods
        %% Declare joystick
        % Returns joystick class, joy item and info associated with
        % joystick
        %
        % Also checks for errors, and will return a message if joystick is
        % not connected (so program does not break)
        function [self, joy, joy_info, NOJOY] = JoystickClass()
            id = 1; % NOTE: may need to change if multiple joysticks present
            try
                joy = vrjoystick(id);
                NOJOY = false;
            catch
                warning('Joystick is not connected');
                joy = 0;
                joy_info = 0;
                NOJOY = true;
            end
            
            if NOJOY ~= true
                joy_info = caps(joy); % print joystick information
            end
        end
        
        %% Read joystick
        % Returns all joystick buttons in their current state when run
        function [axes, buttons, povs] = JoystickRead(self, joy)
            [axes, buttons, povs] = read(joy);
        end
    end
end

