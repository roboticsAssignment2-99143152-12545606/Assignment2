classdef JoystickClass
    
    properties
        axes;
        buttons;
        povs;
    end
    
    methods
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
        
        function [axes, buttons, povs] = JoystickRead(self, joy)
            [axes, buttons, povs] = read(joy);
        end
    end
end

