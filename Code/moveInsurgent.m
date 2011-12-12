function  moveInsurgent(civ)

%   moveInsurgent   This function attempts to find a new position for a latent or
%                   active insurgent, when it not already possible to make any
%                   attacks.

global world
global param
global Civilians

AttackGrid = param.AttackGrid;
gridSize   = param.gridSize;

tempWorld  = world(:,:,2);
foundPlace = 0;

while 1
    
    %   pick a random position on the map
    pos       = randi(gridSize*gridSize);
    [row col] = ind2sub(size(tempWorld), pos);
    
    %   check if is empty and there is a soldier close by
    if tempWorld(row,col) == 0 && ~isempty(findAgents(row,col,'soldier',AttackGrid))
        
        foundPlace = 1;
        break   % Exit the loop when the random place of regeneration is empty
        
    end
    
end


if foundPlace == 1
    
    x = Civilians(civ).x;
    y = Civilians(civ).y;
    %     fprintf('Insurgent at position (%d,%d) moves to (%d,%d).\n',x,y,row,col)
    world(row,col,1) = world(x,y,1);
    world(row,col,2) = civ;
    world(x,y,1) = 1;
    world(x,y,2) = 0;
    Civilians(civ).x = row;
    Civilians(civ).y = col;
    
end
end


