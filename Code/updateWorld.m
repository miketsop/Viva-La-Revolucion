function [] = updateWorld(index)

%UPDATEWORLD    Updates maps values and agents colours (for displaying purposes)
%               according to the state of each civilian.
%               If input index is specified, only the corresponding civilians 
%               will be updated.

global noc
global world
global Civilians

if nargin<1
    
    for i = 1:noc

        anger = Civilians(i).anger;
        fear  = Civilians(i).fear;
        thres = Civilians(i).thres;

        if anger < fear

            value = 3;      % Green
            Civilians(i).Colour = [0.5 1 0.5];

        elseif (anger >= fear) && (anger <= thres)

            value = 4;      % Yellow 
            Civilians(i).Colour = [ 1 1 0];
            
        elseif (anger >= fear) && (anger >= thres) && (Civilians(i).attack == 0)

            value = 5;      % Orange (Latent insurgent)
            Civilians(i).Colour = [ 1 0.5 0];
            
        elseif (anger >= fear) && (anger >= thres) && (Civilians(i).attack == 1)

            value = 6;      % Red (Active insurgent)
            Civilians(i).Colour = [ 1 0 0];

        end

        world(Civilians(i).x,Civilians(i).y,1) = value;

        if value == 5 || value == 6

            Civilians(i).threat = 1;

        end

    end
    
else
    
    for i = 1:length(index)
        
        anger = Civilians(index(i)).anger;
        fear  = Civilians(index(i)).fear;
        thres = Civilians(index(i)).thres;

        if anger < fear

            value = 3;      % Green
            Civilians(i).Colour = [0.5 1 0.5];

        elseif (anger >= fear) && (anger <= thres)

            value = 4;      % Yellow 
            Civilians(i).Colour = [ 1 1 0];

        elseif (anger >= fear) && (anger >= thres) && (Civilians(index(i)).attack == 0)

            value = 5;      % Orange (Latent insurgent)
            Civilians(i).Colour = [ 1 0.5 0];

        elseif (anger >= fear) && (anger >= thres) && (Civilians(index(i)).attack == 1)

            value = 6;      % Red (Active insurgent)
            Civilians(i).Colour = [1 0 0];

        end

        world(Civilians(index(i)).x,Civilians(index(i)).y,1) = value;

        if value == 5 || value == 6

            Civilians(index(i)).threat = 1;

        end
        
    end
    
end       

end

