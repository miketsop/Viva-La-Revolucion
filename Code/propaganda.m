function propaganda( civ,influence )
%propaganda This function implements the propaganda action of a leader.
%           Inputs :
%                   - civ:  a vector with the indices of civilians in the
%                           influence range of the leader.
%                   - influence: how much the leader affects the civilians.
global Civilians

for i=1:length(civ)
    
    Civilians(civ(i)).anger = Civilians(civ(i)).anger + influence*(1-Civilians(civ(i)).anger);
    Civilians(civ(i)).fear  = Civilians(civ(i)).fear  - influence*(1-Civilians(civ(i)).fear);
    
    if Civilians(civ(i)).fear > 1
        
        Civilians(civ(i)).fear = 1;
        
    elseif Civilians(civ(i)).fear < 0
        
        Civilians(civ(i)).fear = 0;
        
    end
    
    if Civilians(civ(i)).anger > 1
        
        Civilians(civ(i)).anger = 1;
        
    elseif Civilians(civ(i)).anger < 0
        
        Civilians(civ(i)).anger = 0;
        
    end
    
end


end

