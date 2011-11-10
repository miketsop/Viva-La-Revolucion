function [w] = createWorld()

global gridSize
global nos
global noc

world = ones(gridSize*gridSize,1);

world(1:nos) = 2;
world(nos+1:nos+noc) = 3;

tmp = randperm(gridSize*gridSize);

world  = world(tmp);
world2 = zeros(gridSize,gridSize);

for i=1:gridSize
    world2(:,i) = world((i-1)*gridSize+1:i*gridSize)';
end

w = zeros(gridSize,gridSize,2);
w(:,:,1) = world2;

end