function displayWorld()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global world

persistent cmap

if isempty(cmap)
    cmap = [0 0 0;0 0 1; 0.5 1 0.5; 1 1 0; 1 0.5 0; 1 0 0]; 
end

colormap(cmap);

image(world(:,:,1))

end

