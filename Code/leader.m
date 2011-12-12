function L = leader(x,y)

%Leader     This function creates an agent of type 'leader'. These are
%           special types of agents that do not fight, but have some special roles,
%           such as recruiting and helping spread the insurgency.


%   influenceChance: probability that this leader will perform a
%   propaganda action.
%   influenceRange: range of all civilians affected by the propaganda
%   action.
%   influenceRate: impact that this propaganda will have an all
%   affected civilians.
%   recruitChance: probability that this leader will succesfully recruit a
%   civilian.

global gridSize

influenceChance_mean = 0.2;
influenceChance_std  = 0.001;

recruitChance_mean     = 0.05;
recruitChance_std      = 0.001;

influenceRange_mean = 20;
influenceRange_std  =  2;

influenceRate_mean  = 0.05;
influenceRate_std   = 0.001;

L.influenceChance = gsample(influenceChance_mean,influenceChance_std,1);
L.recruitChance   = gsample(recruitChance_mean,recruitChance_std,1);
L.influenceRange  = round(gsample(influenceRange_mean,influenceRange_std,1));
L.influenceRate   = gsample(influenceRate_mean,influenceRate_std,1);

if L.influenceRate>1
    
    L.influenceRate = 1;
    
elseif L.influenceRate<0
    
    L.influenceRate = 0;
    
end

if L.influenceRange>gridSize
    
    L.influenceRange = gridSize;
    
elseif L.influenceRange<0
    
    L.influenceRange = 0;
    
end

if L.influenceChance>1
    
    L.influenceChance = 1;
    
elseif L.influenceChance<0
    
    L.influenceChance = 0;
    
end

if L.recruitChance>1
    
    L.recruitChance = 1;
    
elseif L.recruitChance<0
    
    L.recruitChance = 0;
    
end

L.x = x;
L.y = y;
L.Colour = [1 0 1];

end