function [Civilians,Soldiers,Leaders] = populateWorld()

% POPULATE WORLD    Locates civilians and soldiers in first layer of world
%                   matrix and creates their structures. Furthermore, the
%                   function saves the identity of each structure in a
%                   second layer of the world matrix. With this method, it
%                   is very easy to find which civilian or soldier is
%                   situated in each block.
global world
global param

if param.allowLeaders == 0
    
    Leaders = [];
    
end

worldLayer = world(:,:,1);    

%   Find all points of the map, where civilians are supposed to be.
c = find(worldLayer == 3);

%   Create the civilians
for i=1:length(c)
    
    [row col]    = ind2sub(size(worldLayer), c(i));
    
    Civilians(i) = civilian(row,col);
    
    world(row,col,2) = i;
end

%   Find all points of the map, where soldiers are supposed to be.
s = find(worldLayer == 2);

%   Create the soldiers.
for i=1:length(s)
    
    [row col]   = ind2sub(size(worldLayer), s(i));
    Soldiers(i) = soldier(row,col);
    
    world(row,col,2) = i;
    
end

if param.allowLeaders==1

    %   Find all points of the map, where leaders are supposed to be.
    l = find(worldLayer == 7);
    
    %   Create the leaders.
    for i=1:length(l)
        
        [row col]   = ind2sub(size(worldLayer), l(i));
        Leaders(i) = leader(row,col);
        
        world(row,col,2) = i;
        
    end
    
end

end
