%   File initializing all parameters
function param = parameters()

% Miscellaneous parameters

switchPosition = 1;         %   allow insurgents to move around the map?
afterlife      = 0;         %   allow replacement of dead insurgents?

maxStep        = 5000;      %   maximum number of iterations
percent        = 2;%0.35;   %   threshold of total deaths required to end the simulation

% World parameters

nos          = 100;         %   # of soldiers
noc          = 500;         %   # of civilians
nol          =  10;         %   # of leaders
allowLeaders =   1;         %   allow leaders?
gridSize     =  50;         %   size of map

% Soldier parameters
% These values are not constant in our simulations
effectiveness = 0.8;    %   chance for a soldier to kill an attacking insurgent
accuracy      = 0.8;    %   1-accuracy is the chance to injure, nearby civilians during a counterattack
sensitivity   = 1;      %   chance of soldier to respond to an insurgent attack

% Interaction parameters 

AttackGrid     = 9;     %   attack area of insurgents
CollateralGrid = 9;     %   collateral damage area (when soldiers counterattack)
InfluenceGrid  = 9;     %   all civilians inside the influence grid, are affected by the counterattack

% Processing parameters
example = 0;            %   set to 1 for displaying the actions on each step... used for presentation
batch   = 0;            %   set to 1 for doing multiple simulations and averaging the results
runs    = 25;%10            %   simulations per model - for batch mode.  
video   = 0;            %   set to 1 for video recording of the map

param = struct('runs',runs,'switchPosition',switchPosition,'afterlife',afterlife,'maxStep',maxStep,...
    'percent',percent,'nos',nos,'noc',noc,'nol',nol,'allowLeaders',allowLeaders,'gridSize',...
    gridSize,'effectiveness',effectiveness,'accuracy',accuracy,'sensitivity',sensitivity,...
    'AttackGrid',AttackGrid,'CollateralGrid',CollateralGrid,'InfluenceGrid',InfluenceGrid,'example',example,'batch',batch,'video',video);
