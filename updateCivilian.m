function [] = updateCivilian(data,damage) % (index of civilian, how many people were injured)

%UPDATECIVILIAN     Summary of this function goes here
%                   Detailed explanation goes here

global Civilians

% fearIncrementV   = 0.1;
% angerIncrementV  = 0.05;
% fearIncrementS   = 0.1;
% angerIncrementS  = 0.05;

fearBaseModifierV  = 0.1;
fearBaseModifierS  = 0.1;
angerBaseModifierV = 0.05;
angerBaseModifierS = 0.05;

%% added by Mike on 12/11/2011 !
fearModifierRich    = 1;%1.1;
fearModifierMiddle  = 1;%1;
fearModifierPoor    = 1;%0.9;

angerModifierRich       = 1;%0.8;
angerModifierMiddle     = 1;%1;
angerModifierPoor       = 1;%1.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
civ     = data(1);
injured = data(2);

fear  = Civilians(civ).fear;
anger = Civilians(civ).anger;

if strcmp(Civilians(civ).wealth,'Rich')
    fearIncrement   = fearModifierRich;
    angerIncrement  = angerModifierRich;
elseif strcmp(Civilians(civ).wealth,'Middle')
    fearIncrement   = fearModifierMiddle;
    angerIncrement  = angerModifierMiddle;
else
    fearIncrement   = fearModifierPoor;
    angerIncrement  = angerModifierPoor;
end

if injured == 1
    
    Civilians(civ).fear  = fear+fearIncrement*fearBaseModifierV*(1-fear);
    Civilians(civ).anger = anger+angerIncrement*angerBaseModifierV*damage*(1-anger);

elseif injured == 0
    
    Civilians(civ).fear  = fear+fearIncrement*fearBaseModifierS*(1-fear);
    Civilians(civ).anger = anger+angerIncrement*angerBaseModifierS*damage*(1-anger);
    
end

if Civilians(civ).fear > 1 
    
    Civilians(civ).fear = 1;
    
elseif Civilians(civ).fear < 0
    
    Civilians(civ).fear = 0;
    
end
  
if Civilians(civ).anger > 1
    
    Civilians(civ).anger = 1;
    
elseif Civilians(civ).anger < 0
    
    Civilians(civ).anger = 0;
    
end
    
   
end

