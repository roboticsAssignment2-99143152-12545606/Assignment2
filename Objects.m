 classdef Objects < handle % class to handle setting up of the static body
    properties
        model;
        plyData;
        workspace;
        location;
        rot;
        radi;
        faceNormals;
		faces;
		points;
        % Joystick variables
        joyObj;
        joy;
        NOJOY;
        axes;
        buttons;
        povs;
        homeJoints;
    end
    
    methods
        function self = Objects(ModelName, ModelNum, workspace, location, rot, radi)
            % setup object paramas for later use if unused will default
            if ~exist('rot')
                self.rot = 0;
            else 
                self.rot = rot;
            end
            if ~exist('radi')
                self.radi = 0;
            else 
                self.radi = radi;
            end
            
            % init object as one link robot
            self.plotAndColour(workspace, ModelName, ModelNum, location);
        end
        
        function [pose] = getPose(self)
            pose = self.model.fkine(self.model.getpos);
        end
		
		function [points,faces,faceNormals] = getPLYData(self)
			Pose = self.getPose;
			points = cell2mat(self.model.points) + Pose(1:3,4)';
			self.points = points;
			faces = cell2mat(self.model.faces);
            self.faces = faces;
			% Added to generate the faceNormals for each link
            % - Taken from the tutorial files (RectangularPrism)
%             self.faceNormals{linkIndex + 1} = zeros(size(faceData,1),3);
            self.faceNormals{1} = zeros(size(faces,1),3);
            for faceIndex = 1:size(faces,1)
                v1 = points(faces(faceIndex,1)',:);
                v2 = points(faces(faceIndex,2)',:);
                v3 = points(faces(faceIndex,3)',:);
%                 self.faceNormals{linkIndex + 1}(faceIndex,:) = unit(cross(v2-v1,v3-v1));
                self.faceNormals{1}(faceIndex,:) = unit(cross(v2-v1,v3-v1));
            end
			faceNormals = cell2mat(self.faceNormals);
            faceNormals = faceNormals(:,1:3);
		end
               
        function plotAndColour(self, workspace, ModelName, ModelNum, location)

            
            for linkIndex = 0:1
                [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['Objects/PLY/',ModelName,'.ply'],'tri');
                % Added cell2mat function for isCollision
                self.model.faces{linkIndex + 1} = faceData;
                self.model.points{linkIndex + 1} = vertexData;
            end
            self.faces = self.model.faces;
			self.model.points = self.points;
            % Added to generate the faceNormals for each link
            % - Taken from the tutorial files (RectangularPrism)
            self.faceNormals{linkIndex + 1} = zeros(size(faceData,1),3);
            for faceIndex = 1:size(faceData,1)
                v1 = vertexData(faceData(faceIndex,1)',:);
                v2 = vertexData(faceData(faceIndex,2)',:);
                v3 = vertexData(faceData(faceIndex,3)',:);
                self.faceNormals{linkIndex + 1}(faceIndex,:) = unit(cross(v2-v1,v3-v1));
            end
            
            L1 = Link('alpha',0,'a',0,'d',0,'offset',0);
            self.model = SerialLink(L1, 'name' , [ModelName,'_', num2str(ModelNum)]);
            % 1 link robot used to simulate bodys for simplicity
            self.model.faces = {faceData,[]};
            self.model.points = {vertexData,[]};
            
            % Display body
            self.model.base = location;
            self.model.plot3d(0, 'workspace', workspace);
            
            self.model.delay = 0;
            
            for linkIndex = 0:self.model.n
                handles = findobj('Tag', self.model.name);
                h = get(handles,'UserData');
                try
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                        , plyData{linkIndex+1}.vertex.green ...
                        , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'interp';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end
        end
        
        %% Joystick functionality (Per Robot Arm)
        function setJoy(self, joyObj, joy, NOJOY)
            self.joyObj = joyObj;
            self.joy = joy;
            self.NOJOY = NOJOY;
        end
        
        function [value] = checkJoy(self)
            [self.axes, self.buttons, self.povs] = self.joyObj.JoystickRead(self.joy);
            % buttons (1,2) corresponds to RED B button on LOGITECH
            % controller
            if self.buttons(1,2) == 0
                value = 0;
            else
                value = 1;
            end
        end
        
        function [newModelBase] = joggingLoop(self, increments, debug)
            % Each time this jogging function is run, it will obtain the
            % end effector position, and apply a slight offset to it.
            % 
            % Run this in a while loop
            %   Check stop > Run joggingLoop > Apply transform
            [self.axes, self.buttons, self.povs] = self.joyObj.JoystickRead(self.joy);
            currentModelBase = self.model.base;
            
            % For each button state, apply a certain offset to the current
            % end effector transform, and calculate the joint positions
            % from that
            
            newModelBase = currentModelBase;
            
            if (self.axes(2) > 0.5)
                newModelBase = currentModelBase * transl([-increments, 0, 0]);
                if debug == 1
                    disp(newModelBase)
                end
            end
            
            if (self.axes(2) < -0.5)
                newModelBase = currentModelBase * transl([increments, 0, 0]);
                if debug == 1
                    disp(newModelBase)
                end
            end
            
            if (self.axes(1) > 0.5)
                newModelBase = currentModelBase * transl([0, -increments, 0]);
                if debug == 1
                    disp(newModelBase)
                end
            end
            
            if (self.axes(1) < -0.5)
                newModelBase = currentModelBase * transl([0, increments, 0]);
                if debug == 1
                    disp(newModelBase)
                end
            end
            
            self.model.base = newModelBase;
            self.model.animate(0);
        end
    end
 end
