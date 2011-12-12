function [w] = createWorld()

% CREATEWORLD   function that creates the first layer of the world matrix.
%               This layer indicates the content(type of agent or empty terrain) of each block on the map.
global param

gridSize        = param.gridSize;
nos             = param.nos;
noc             = param.noc;
nol             = param.nol;
allowLeaders    = param.allowLeaders;
world           = ones(gridSize*gridSize,1);


world(1:nos)          = 2; %   soldiers
world(nos+1:nos+noc)  = 3; %   civilians

if allowLeaders==1

    world(nos+noc+1:nos+noc+nol) = 7; %   leaders

end

tmp = randperm(gridSize*gridSize);

world  = world(tmp);
world2 = zeros(gridSize,gridSize);

tmp =randperm(gridSize);

for i=1:gridSize
    j = tmp(i);
    world2(:,i) = world((j-1)*gridSize+1:j*gridSize)';
end

w = zeros(gridSize,gridSize,2);
w(:,:,1) = world2;

end