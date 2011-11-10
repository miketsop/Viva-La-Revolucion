function [Civilians,Soldiers] = populateWorld()

global world

worldLayer = world(:,:,1);      % Find command would not work in 3D matrices

c = find(worldLayer == 3);

for i=1:length(c)
    
    [row col]    = ind2sub(size(worldLayer), c(i));
    Civilians(i) = civilian(row,col);
    
    world(row,col,2) = i;
end

s = find(worldLayer == 2);

for i=1:length(s)
    
    [row col]   = ind2sub(size(worldLayer), s(i));
    Soldiers(i) = soldier(row,col);
    
    world(row,col,2) = i;

end

end
