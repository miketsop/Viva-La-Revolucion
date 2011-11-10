
function [agents] = findAgents(x,y,type,interactionGrid)

%FINDAGENTS     Summary of this function goes here
%
%   Inputs      x,y : coordinates of interest
%               type: kind of agents we are looking for ('soldiers','civilians')
%               interactionGrid: area of interaction
%
%   Output      agents: vector containing the indices to the agents

global world;
global gridSize;

% Find the limits of the grid to be scanned

x1 = x - floor(interactionGrid/2);
x2 = x + floor(interactionGrid/2);
y1 = y - floor(interactionGrid/2);
y2 = y + floor(interactionGrid/2);  

% Make corrections in case numbers are out of bounds

if x1<1 
    x1 = 1;
end
if x2>gridSize
    x2 = gridSize;
end
if y1<1
    y1 = 1;
end
if y2>gridSize
    y2 = gridSize;
end

% Find agents
agents = [];

for i=x1:x2
    for j=y1:y2
        
        if world(i,j,1)==2 && strcmp(type,'soldier')
            
            agents(end+1) = world(i,j,2);
            
        elseif world(i,j,1) > 2 && strcmp(type,'civilian')

            agents(end+1) = world(i,j,2);

        end
    end
end

end

