function   Results = completeSimulation()

% COMPLETESIMULATION    This function performs a complete simulation. It
%                       will return all the information required for the
%                       post-processing.
%
% OUTPUTS:              active -> number of active insurgents at any given
%                       time step.
%
%                       latent -> number of latent insurgents at any given
%                       time step.
%
%                       civilians -> number of civilians at any given time
%                       step (use when replacement = 0).
%
%                       deaths -> number of civilian casualties at any
%                       given time step.
%
%                       attacks -> number of attacks carried out by the end
%                       of any given time step.
%
%                       timeSteps -> duration of the simulation
%
%                       status -> why simulation terminated?
%                                   -   defeated: no insurgents remain
%                                   -   undecided: no possibility of further attacks
%                                   -   expired: reached maxSteps

global world

global Civilians
global Soldiers
global Leaders

global param
global noc
global vidObj
global h

noc = param.noc;

%   Initialize the world. 
%   variable 'world' is a gridSize*gridSize*2 matrix. The 1st dimension
%   represents the environment, and stores information regarding the type
%   of agent in a particular grid (x,y). The 2nd dimension stores the
%   indices of each agent, so as to find them easily when searching the
%   map.
world = createWorld();

%   Populate the world, according to the initialization. Assign coordinates to human structures
[Civilians,Soldiers,Leaders] = populateWorld();  

updateWorld();

if ~param.batch 
    
    h = figure;
    displayWorld;
    title('World at the beginning of the simulation')

end

%   Initialize matrices to store important information regarding the
%   evolution of the insurgency.
maxStep = param.maxStep;

attacks = zeros(1,maxStep);     %   # of attacks that have occured
active = zeros(1,maxStep);      %   # of active insurgents
latent = zeros(1,maxStep);      %   # of latent insurgents
civilians = zeros(1,maxStep);   %   # of civilians alive
deaths = zeros(1,maxStep);      %   # of deaths      
recruits = [];                  %   # of succesful recruitments

if param.allowLeaders 
    
    recruits = zeros(1,maxStep);

end

active(1)           = length(find(world(:,:,1)==6));
latent(1)           = length(find(world(:,:,1)==5));
civilians(1)        = param.noc;

status = 'expired';

if param.video 

    vidObj = VideoWriter('video.avi');
    open(vidObj);
    
end

%   Repeat simulation step, until either a terminal condition has been
%   reached, or the maximum number of iterations has been attained.
for i=2:maxStep
    
    timeSteps = i; 
    
    %   Simulate
    [attackFlag,deathFlag,recruitFlag] = simulate2();
    
    %   Store the results for the i-th step
    active(i)       = length(find(world(:,:,1)==6));
    latent(i)       = length(find(world(:,:,1)==5));
    civilians(i) = noc;
    attacks(i)  = attacks(i-1)+attackFlag;
    deaths(i)   = deaths(i-1)+deathFlag;
    
    if param.allowLeaders == 1
        
        recruits(i) = recruits(i-1) + recruitFlag;
        
    end
    
    %   Check for terminal conditions.
    %   (a) All insurgents are dead.
    %   (b) A certain number of deaths has occured.
    %   (c) All insurgents are out of range of soldiers (and position
    %       switching is not allowed).
    
    if latent(i) == 0 && active(i) == 0
        
        status = 'defeated';
        break
        
    end
    
%     if deaths(i)> param.percent*param.noc
%         status = 'won';
%         break
%     end
    
    if outOfRange 
        
        switch param.switchPosition
            
            %   If no position switching is allowed, then if all insurgents
            %   are out of range, end the simulation.
            case 0
                
                status = 'undecided';
                break
            
            %   Else, choose a random insurgent and move him close to a
            %   soldier so that simulation can continue.
            case 1
                
                ind  = find(world(:,:,1)>=5);
                
                if param.allowLeaders == 1
                    
                    indLeaders = find(world(:,:,1)==7);
                    ind = setdiff(ind,indLeaders);
                    
                end
                
                [row col] = ind2sub(size(world(:,:,2)),ind);
                threats = [row col];
                pick = randi([1 size(threats,1)],1,'uint32');
                civilianToBeMoved = world(threats(pick,1),threats(pick,2),2);
                moveInsurgent(civilianToBeMoved);
                updateWorld();
                
            otherwise
                
        end
        
    end
    
    if param.video
        clf(h,'reset')
        displayWorld();
        currFrame =getframe(h);
        writeVideo(vidObj,currFrame);
        
    end
    
end

% 
% if ~param.batch
%     
%     displayWorld();
%     title('World at the end of simulation')
% end

%   Return the results of the simulation in a struct.
if ~param.video
    Results = struct('active',active,'latent',latent,'civilians',civilians,'deaths',deaths,'attacks',...
    attacks,'recruits',recruits,'timeSteps',timeSteps,'status',status);
else
    Results = struct('active',active,'latent',latent,'civilians',civilians,'deaths',deaths,'attacks',...
    attacks,'recruits',recruits,'timeSteps',timeSteps,'status',status,'video',vidObj);
    
end

