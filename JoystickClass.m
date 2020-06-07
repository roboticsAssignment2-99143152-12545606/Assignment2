classdef JoystickClass
    
    properties
        axes;
        buttons;
        povs;
    end
    
    methods
        function [self, joy, joy_info] = JoystickClass()
            id = 1; % NOTE: may need to change if multiple joysticks present

            joy = vrjoystick(id);
            joy_info = caps(joy); % print joystick information
        end
        
        function [axes, buttons, povs] = JoystickRead(self, joy)
            [axes, buttons, povs] = read(joy);
        end
    end
end

