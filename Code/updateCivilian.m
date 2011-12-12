function [] = updateCivilian(data,damage) % (index of civilian, how many people were injured)

%UPDATECIVILIAN     This function updates the fear and anger levels of all
%civilians located in the Influence Grid, around the insurgent.

global Civilians

fearBaseModifierV  = 0.1;
fearBaseModifierS  = 0.1;
angerBaseModifierV = 0.03;
angerBaseModifierS = 0.03;

fearModifierRich    = 1.1;
fearModifierMiddle  = 1;
fearModifierPoor    = 0.9;

angerModifierRich       = 0.8;
angerModifierMiddle     = 1;
angerModifierPoor       = 1.2;

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

