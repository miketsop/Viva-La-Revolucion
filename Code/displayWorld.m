function displayWorld(ind,inj)

%   displayWorld    This function will simply display the current state of
%                   the world. If no arguments are given for inputs, then
%                   it simply displays all the agents in the map. Giving
%                   at least two arguments is done for presentation
%                   purposes only (when param.example=1). 
%
%   INPUTS:         -ind:   ind(1) stores the index of the insurgent
%                           performing an attack, whereas ind(2) stores the index of the soldier
%                           counter attacking.
%                   -inj:   stores the indices of the civilians injured by
%                           a soldier's counter attack.
global param
global noc
global Civilians Soldiers Leaders 

nos             = param.nos;
nol             = param.nol;
gridSize        = param.gridSize;
CollateralGrid  = param.CollateralGrid;

for i=1:nos
    
    plot(Soldiers(i).x,Soldiers(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Soldiers(i).Colour);
    hold on
    
end

for i=1:noc
    
    plot(Civilians(i).x,Civilians(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Civilians(i).Colour);
    hold on
    
end

for i=1:nol
    
    plot(Leaders(i).x,Leaders(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Leaders(i).Colour);
    hold on
    
end

if nargin>=1
    
    plot(Civilians(ind(1)).x,Civilians(ind(1)).y, ...
        'Marker','s', 'MarkerSize',15, ...
        'Color',[1 0 0]);
    hold on
    
    plot(Soldiers(ind(2)).x,Soldiers(ind(2)).y, ...
        'Marker','s', 'MarkerSize',15, ...
        'Color',[0 0 0]);
    hold on
    
    for i=1:length(inj)
        if inj(2,i)==1
            plot(Civilians(inj(1,i)).x,Civilians(inj(1,i)).y, ...
                'Marker','d', 'MarkerSize',15, ...
                'Color',[1 0 1]);
            hold on
        end
    end
    rectangle('Position',[Civilians(ind(1)).x-floor(CollateralGrid/2),Civilians(ind(1)).y-floor(CollateralGrid/2),2*floor(CollateralGrid/2),2*floor(CollateralGrid/2)])
end
axis([-1 gridSize+1 -1 gridSize+1 ]);
