function outOfRangeFlag = outOfRange

%outOfRange Returns true if no insurgent can perform an attack on a soldier
%           or false otherwise.

global param
global Civilians

AttackGrid = param.AttackGrid;
outOfRangeFlag = true;

for i=1:length(Civilians)
    
    if Civilians(i).threat == 1
        
        nearbySoldiers = findAgents(Civilians(i).x,Civilians(i).y,'soldier',AttackGrid);
        
        if ~isempty(nearbySoldiers)
            outOfRangeFlag = false;
            break
            
        end
    end
    
end

end
