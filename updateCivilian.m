function [] = updateCivilian(data,damage) % (index of civilian, how many people were injured)

%UPDATECIVILIAN     Summary of this function goes here
%                   Detailed explanation goes here

global Civilians

fearIncrementV   = 0.1;
angerIncrementV  = 0.05;
fearIncrementS   = 0.1;
angerIncrementS  = 0.05;

civ     = data(1);
injured = data(2);

fear  = Civilians(civ).fear;
anger = Civilians(civ).anger;

if injured == 1
   
    Civilians(civ).fear  = fear+fearIncrementV*(1-fear);
    Civilians(civ).anger = anger+angerIncrementV*damage*(1-anger);

elseif injured == 0
    
    Civilians(civ).fear  = fear+fearIncrementS*(1-fear);
    Civilians(civ).anger = anger+angerIncrementS*damage*(1-anger);
    
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

