
function [] = simulate()

%SIMULATE   Summary of this function goes here
%           Detailed explanation goes here

global noc
global nos
global Civilians
global Soldiers
global AttackGrid
global CollateralGrid
global InfluenceGrid

global gridSize
global world

player = randi([1 noc],1,'uint32');

while Civilians(player).threat == 0          % Continue searching for a civilian
    % that could make an attack.
    player = randi([1 noc],1,'uint32');
    
end

x = Civilians(player).x;
y = Civilians(player).y;

nearbySoldiers = findAgents(x,y,'soldier',AttackGrid);

if ~isempty(nearbySoldiers)
    
    victimindex = randi([1 length(nearbySoldiers)],1,'uint32');
    
    victim = nearbySoldiers(victimindex);
    
    Civilians(player).attack = 1;
    
    world(x,y,1) = 6;
    
    %displayWorld();
    
    response = rand;
    
    if response <= Soldiers(victim).sensitivity  % then . . . ATTACK!
        
        %         display(' A T T A C K !');
        %         fprintf('\n Insurgent in position (%d,%d) is being attacked !\n',x,y);
        
        kill = randn;
        
        if kill <= Soldiers(victim).effectiveness
            
            afterLife(player,1); % REGENERATION OR NOT
            
        end
        
        nearbyCivilians = findAgents(x,y,'civilian',CollateralGrid)
        
        damage = 0;
        
        if ~isempty(nearbyCivilians)
            nearbyCivilians(2,:) = 0;
        end
        
        % Here we store if the civilian was injured by the attack
        size(nearbyCivilians,2)
        for k = 1:size(nearbyCivilians,2)
            injury = rand;
            
            if injury < 1 - Soldiers(victim).accuracy
                
                display('Civilian Injured');
                damage = damage+1;
                nearbyCivilians(2,k) = 1;
                
            end
            
            
        end
        
        % UPDATE INJURED CIVILIANS AND SPECTATORS
        influencedCivilians = findAgents(x,y,'civilian',InfluenceGrid);
        
        if ~isempty(influencedCivilians)
            nearbyCivilians
            influencedCivilians(2,:) = 0;
            for i=1:size(nearbyCivilians,2)
                
                if nearbyCivilians(2,i)==1
                    influencedCivilians(2,influencedCivilians(1,:)==nearbyCivilians(1,i)) = 1;
                end
            end
            
            for k = 1:size(nearbyCivilians,2)
                
                updateCivilian(nearbyCivilians(:,k),damage);
                
            end
        end
        updateWorld();
        
    end
    
end

end



