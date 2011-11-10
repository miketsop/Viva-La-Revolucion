
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

nearbySoldiers = findAgents(x,y,'soldier',AttackGrid)

if ~isempty(nearbySoldiers)
    
    victimindex = randi([1 length(nearbySoldiers)],1,'uint32');
    
    victim = nearbySoldiers(victimindex);
    
    Civilians(player).attack = 1;
    
    world(x,y,1) = 6;
    
    %displayWorld();   
    
    response = rand;
    
    if response <= Soldiers(victim).sensitivity  % then . . . ATTACK!
        
        display(' A T T A C K !');
        fprintf('\n Insurgent in position (%d,%d) is being attacked !\n',x,y);
        
        kill = randn;
        
        if kill <= Soldiers(victim).effectiveness
         
            Civilians(player) = [];
            world(x,y,1) = 1;           % R.I.P
            world(x,y,2) = 0;
            noc = noc -1;               % Or REPLACEMENT !!! !!!!!! !!!!
                        
            tempWorld = world(:,:,2);
            tempWorld(tempWorld > player) = tempWorld(tempWorld > player)-1;
            world(:,:,2) = tempWorld;
                        
        end

        nearbyCivilians = findAgents(x,y,'civilian',CollateralGrid)
        
        damage = 0;
        
        nearbyCivilians(2,:) = 0;       % Here we store if the civilian was injured by the attack
        
        for k = 1:size(nearbyCivilians,2)
            
            injury = rand;
            
            if injury < 1 - Soldiers(victim).accuracy
                
                display('Civilian Injured');
                damage = damage+1;
                nearbyCivilians(2,k) = 1;
                
            end
                  
                
        end
        
        % UPDATE INJURED CIVILIANS AND SPECTATORS
        
        for k = 1:size(nearbyCivilians,2)
         
            updateCivilian(nearbyCivilians(:,k),damage);
            
        end
        
        updateWorld();
        
    end
    
end

end

        
 
