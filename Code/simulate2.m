
function [attackFlag,deathFlag,recruitFlag] = simulate2()

%SIMULATE   This function performs one simulation step.

global param
global noc
global Civilians
global Soldiers
global Leaders
global world
global vidObj
global h
nol = param.nol;

AttackGrid      = param.AttackGrid;
CollateralGrid  = param.CollateralGrid;
InfluenceGrid   = param.InfluenceGrid;
afterlife       = param.afterlife;
allowLeaders    = param.allowLeaders;
example         = param.example;
video           = param.video;

attackFlag  = 0;                              % In order to count the number of attacks
deathFlag   = 0;
recruitFlag = 0;

%   If leaders are allowed..
if allowLeaders == 1
    
    %   pick a random leader
    leader = randi([1 nol],1,'uint32');
    
    influence_roll = rand;
    recruit_roll   = rand;
    
    %   If roll succesful, then perform a propaganda action.   
    if influence_roll < Leaders(leader).influenceChance
        
        civ = findAgents(Leaders(leader).x,Leaders(leader).y,'civilian',Leaders(leader).influenceRange);
        propaganda(civ,Leaders(leader).influenceRate)
        
    end
    
    %   If roll succesful, then perform a recruit action.
    if recruit_roll < Leaders(leader).recruitChance
        
        Civilians   = recruit(Civilians);
        recruitFlag = 1;
        
    end
    
end

player = randi([1 noc],1,'uint32');

% Continue searching for a civilian that can make an attack.
while Civilians(player).threat == 0      
    
    player = randi([1 noc],1,'uint32');
    
end

x = Civilians(player).x;
y = Civilians(player).y;

%   Find all soldiers near the civilian
nearbySoldiers = findAgents(x,y,'soldier',AttackGrid);

if ~isempty(nearbySoldiers)
    
    %   Pick a random soldier nearby
    victimindex = randi([1 length(nearbySoldiers)],1,'uint32');
    
    victim = nearbySoldiers(victimindex);
    
    Civilians(player).attack = 1;
    
    attackFlag = 1;
    
    world(x,y,1) = 6;
    
    response = rand;
    
    if response <= Soldiers(victim).sensitivity  % then . . . ATTACK!
        
        %         display(' A T T A C K !');
        %         fprintf('\n Insurgent in position (%d,%d) is being attacked !\n',x,y);
        
        %         kill = rand;
        %
        %         if kill < Soldiers(victim).effectiveness
        %
        %             deathFlag = 1;
        %             afterLife(player,afterlife); % REGENERATION OR NOT
        %
        %         end
        
        %   Counterattack... find civilians close to the insurgent who
        %   attacked.
        nearbyCivilians = findAgents(x,y,'civilian',CollateralGrid);
        
        damage = 0;
        
        if ~isempty(nearbyCivilians)
            nearbyCivilians(2,:) = 0;
        end
        
        % Here we store if the civilian was injured by the attack 
        for k = 1:size(nearbyCivilians,2)
            
            injury = rand;
            
            if injury < 1 - Soldiers(victim).accuracy
                
                damage = damage+1;
                nearbyCivilians(2,k) = 1;
                
            end
            
            
        end
        
        % UPDATE INJURED CIVILIANS AND SPECTATORS
        
        influencedCivilians = findAgents(x,y,'civilian',InfluenceGrid);
        
        
        if ~isempty(influencedCivilians)
            
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
        
        %   For displaying purposes only!!
        if example==1
            
            displayWorld([player victim], nearbyCivilians);
            pause
            
        end
        
        if video 
            
            clf(h,'reset')
            updateWorld();
            displayWorld();
            currFrame =getframe(h);
            writeVideo(vidObj,currFrame);
            
        end
        %   Roll for whether the insurgent who attacked, will die.
        kill = rand;
        
        if kill < Soldiers(victim).effectiveness
            
            deathFlag = 1;
            afterLife(player,afterlife); % REGENERATION OR NOT
            
        end
        
        updateWorld();
        
        if video
            
            clf(h,'reset')
            displayWorld
            currFrame =getframe(h);
            writeVideo(vidObj,currFrame);
            
        end
        
    end
    
end

end



