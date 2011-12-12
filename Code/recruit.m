function [Civilians] = recruit(Civilians)

%	RECRUIT : This function recruits a civilian among those who are angry
%	but not angry enough, and converts him into a latent insurgent.

global world


tempWorld  = world(:,:,2);

candidates = find(tempWorld == 4);                % find civilians with anger>fear but not latent

choose = randi([1 length(candidates)],1,'uint32');% pick a random one

chosen = candidates(choose);                      % pick a random one

[x y] = ind2sub(size(tempWorld),chosen);

chosen = tempWorld(x,y);

Civilians(chosen).anger = Civilians(chosen).thres + 10*eps ;

if Civilians(chosen).anger > 1
    
    Civilians(chosen).anger = 1;

end

updateWorld(chosen);

end

