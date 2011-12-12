
function [] = afterLife(player,belief)

%AFTERLIFE  function that performs the necessarry steps after a civilian's death
%
%   Input:  if belief == 0, There is no life after death
%           if belief == 1, we believe in reincarnation

global world
global gridSize
global Civilians
global noc

tempWorld = world(:,:,2);


x = Civilians(player).x;
y = Civilians(player).y;

world(x,y,1) = 1;           % R.I.P
world(x,y,2) = 0;

if belief == 0
    
    Civilians(player) = [];
    
    noc = noc - 1;     
    
    tempWorld(tempWorld > player) = tempWorld(tempWorld > player)-1;
    world(:,:,2) = tempWorld;
    
    world(x,y,1) = 1;       % added on 12/11/2011
    
elseif belief == 1
    
    while 1
        
        pos       = randi(gridSize*gridSize);
        [row col] = ind2sub(size(tempWorld), pos);
        
        if tempWorld(row,col) == 0
            
            break   % Exit the loop when the random place of regeneration is empty
            
        end
        
    end
    
    Civilians(player) = civilian(row,col);  % generate civilian with new characteristics somewhere else
    
    world(row,col,2)  = player;
    
    % Follows part of the function updateWorld but just for one civilian
    
    updateWorld(player)
 
end


end

