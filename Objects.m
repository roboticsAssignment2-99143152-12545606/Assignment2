classdef Objects < handle % class to handle setting up of the static body
    properties
        model;
        plyData;
        workspace;
        location;
        rot;
        radi;
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
               
        function plotAndColour(self, workspace, ModelName, ModelNum, location)

            
            for linkIndex = 0:1
                [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['Objects/PLY/',ModelName,'.ply'],'tri');
                self.model.faces{linkIndex + 1} = faceData;
                self.model.points{linkIndex + 1} = vertexData;
            end
            
            L1 = Link('alpha',0,'a',0,'d',0,'offset',0);
            self.model = SerialLink(L1, 'name' , [ModelName,'_', num2str(ModelNum)]);
            % 1 link robot used to simulate bodys for simplicity
            self.model.faces = {faceData,[]};
            self.model.points = {vertexData,[]};
            
            % Display body
            self.model.base = location;
            self.model.plot3d(0, 'workspace', workspace);
            
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
    end
end