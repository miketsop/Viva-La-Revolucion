%% What to add:
%
% - Neighbouring insurgents can cooperate (for defense).
% - Insurgents can do more actions than simply attacking soldiers.
% - Attempt to recruit -> chance for a civilian to become a latent
% insurgent.
% - Propaganda - Public speaches etc -> increase anger level and
% decrease fear level.
% - Attack -> roll for escape -> soldiers turn
%     - Can move aroung the map? When escaping for example.
%     - Civilians: change the categories to:
%     -Supporting the regime(anger<fear).
%     -Neutral.
%     -Sympathy towards the insurgents.(anger>fear)
%     -Latent insurgent.
%     -Active insurgent.
%     Civilians who show sympathy towards the rebels can help them escape.
%     - Soldiers can attack even when not attacked!
%     - Add terrain modifiers! better accuracy but lower effectiveness in
%     forests, whilst the opposite in cities for eg.
%     - Add public media to spread news of an attack. (maybe increase fear levels?)

%% Soldiers
%
% Global Variables:
%
% effectiveness :=  (probability to kill an insurgent)
% accuracy      :=  (1-accuracy = chance to injure neighbouring civilians)
%
% 100 total soldiers

%% Civilians
%
% Individual characteristics, ranging between 0 and 1:
%
% 1. Anger(0 = not angry at all,1 = maximum anger).
% 2. Fear(0 = not afraid, 1 = maximum fear).
% 3. Violence Threshold(0 =  low threshold, easy to turn to violence, 1 = nearly impossible to become an insurgent).
%
% LATENT INSURGENT = (Anger > Fear && Anger>Violence Threshold).
% 500 total civilians.
% Initial values are drawn from a normal distribution.
%
%                         Mean        Standard Deviation
% Anger                   0.25        0.125
% Fear                    0.5         0.25
% Violence Threshold      0.5         0.25

%% Map
%
% 2D, with edges. Only neighbours can interact (3 cells distance).
% 50x50.

%% Map Display
%
% Soldiers = blue.
% Civilians {green, yellow, orange, red}.
%
%    green  = anger<fear && anger<violence threshold.
%    yellow = anger>fear && anger<violence threshold.


%% Start

clear all
close all
clc

global nos                  % Number of soldiers
global noc                  % Number of civilians
global gridSize             % Size   of map

global effectiveness
global accuracy
global sensitivity

global world
global Civilians
global Soldiers

global AttackGrid       % range insurgent attack
global CollateralGrid   % range of soldier counterattack
global InfluenceGrid    % range of spread of fear ana anger after counter attack.
global percent
global maxStep

global afterlife            % added global variable for replacement!!!!!
global switchPosition

%   Miscellaneous parameters
switchPosition = 0;
afterlife = 0;

maxStep = 5000;
percent = 0.35;

%   World parameters
nos = 100;
noc = 500;
gridSize = 50;

%   Soldier parameters
effectiveness = 0.8;    % This is not constant! The soldiers are not completely identical in our simulations
accuracy      = 0.1;
sensitivity   = 1;

%   Interaction Parameters(All grid sizes must be odd numbers)
AttackGrid     = 7;
CollateralGrid = 7;
InfluenceGrid  = 7;

[active,latent,civilians,deaths,attacks,timeSteps,status] = completeSimulation();

figure;
plot(1:timeSteps,active(1:timeSteps),'r',1:timeSteps,latent(1:timeSteps),'c',1:timeSteps,attacks(1:timeSteps),'b',1:timeSteps,deaths(1:timeSteps),'m');
hold on
if afterlife == 1
    legend('# of active insurgents','# of latent insurgents','# of attacks','# of deaths')
else
    plot(1:timeSteps,civilians(1:timeSteps),'y');
    legend('# of active insurgents','# of latent insurgents','# of attacks','# of deaths','# of civilians')
end

%% REPETITIVE SIMULATIONS
simulations = [];
for eff = 0.1:0.1:1
    
    effectiveness = eff
    
    for acc = 0:0.1:1
        
        acc
        accuracy = acc;
        nos = 100;
        noc = 500;
        [active,latent,civilians,deaths,attacks,timeSteps,status] = completeSimulation();
        simulations(end+1,:) = [timeSteps acc eff];
        
    end
    
end

[X,Y] = meshgrid(0.1:0.1:1,0:0.1:1);
tmp = zeros(11,10);
s = 1;
t = 11;
for i=1:10
    tmp(:,i) = simulations(s:t,1);
    s = t;
    t = i*11+1;
end



% 
% simulations = [];
% 
% for eff = 0:0.1:1
%     
%     effectiveness = eff;
%     
%     for acc = 0:0.1:1
%         
%         %         clear world;
%         %         clear Soldiers;
%         %         clear Civilians;
%         
%         NumberOfAttacks = zeros(1,maxStep);
%         
%         accuracy = acc;
%         
%         %%%%%%%
%         
%         nos = 100;
%         noc = 500;
%         
%         
%         world = createWorld();
%         
%         [Civilians,Soldiers] = populateWorld();
%         
%         updateWorld()
%         
%         fprintf('Simulation number:%d\n',10*(eff*10+1)+acc*10+1)
%         
%         for i = 1:maxStep
%             
%             [flag] = simulate2();
%             
%             Latent = length(find(world(:,:,1)==5))
%             i
%             % Conditions to end simulation earlier
%             
%             if flag == 1;
%                 NumberOfAttacks(i+1) = NumberOfAttacks(i)+1;
%             else
%                 NumberOfAttacks(i+1) = NumberOfAttacks(i);
%             end
%             
%             if mod(i,10) == 0 && i>10
%                 if NumberOfAttacks(i) == NumberOfAttacks(i-10);
%                     break
%                 end
%             end
%             
%             if Latent == 0
%                 break;
%             end
%             
%         end
%         
%         simulations(end+1,:) = [i acc eff];
%         
%         
%     end
%     
% end
% 
% 
