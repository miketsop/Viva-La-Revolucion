function f1 = displayResults(Results)

%   displayResults:
%               This function is used at the end of a simulation to display
%               the main results. 
global param
global noc
global Soldiers
global Civilians
global Leaders

nos = param.nos;
nol = param.nol;
allowLeaders = param.allowLeaders;
gridSize = param.gridSize;
CollateralGrid = param.CollateralGrid;
AttackGrid = param.AttackGrid;
InfluenceGrid = param.InfluenceGrid;
afterlife = param.afterlife;

ASPECT_RATIO = 1680/850;

if (exist('CURRENTFIGURE','var')==0)
    % get screen resolution
    scr=get(0,'ScreenSize');
    % and force a 16:9 display port, so the plots will look the same on
    % all computer systems and screens. optimized for: win seven
    % X/Y of bottomleft-corner, width, height of figure
    if (floor(scr(3)/ASPECT_RATIO)>scr(4)-160)
        FIGUREPOS = [10; 60; floor((scr(4)-160)*ASPECT_RATIO); scr(4)-180];
    else
        FIGUREPOS = [10; 60; scr(3)-20; floor((scr(3)-20)/ASPECT_RATIO) ];
    end
    CURRENTFIGURE = 1;
    % converts action-radius to pixel
    GRAPHSCALING = FIGUREPOS(3)/1680 * 20;
    clear scr;
end

f1 = figure('position', FIGUREPOS, ...
    'CurrentObject',CURRENTFIGURE, ...
    'Name','Graphical Output of Insurgency Evolution', ...
    'NumberTitle', 'off', ... % removes "figure 1:"
    'Color',[1 1 1]); % background color: white


% get the positions of the world map, depending on world size
if (exist('worldplot','var')==0)
    
    maxwidth = 0.42;
    maxheight = maxwidth*ASPECT_RATIO;
    width = maxwidth;
    height = maxheight;
    worldplot = [0.46-width 0.925-height width height];
    clear width height maxwidth maxheight;
    
end

axes1 = axes('Parent',f1, 'Position',worldplot, ...
    'Color',[1 1 1]);
box(axes1,'on'); % draw a black border around the plot
hold(axes1,'all');
axis(axes1, [-1 gridSize+1 -1 gridSize+1]);

for i=1:nos
    
    plot(Soldiers(i).x,Soldiers(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Soldiers(i).Colour);
    hold on
    
end

for i=1:noc
    
    plot(Civilians(i).x,Civilians(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Civilians(i).Colour);
    hold on
    
end

for i=1:nol
    
    plot(Leaders(i).x,Leaders(i).y, ...
        'Marker','.', 'MarkerSize',15, ...
        'Color',Leaders(i).Colour);
    hold on
    
end

title({'Agents World'},'FontWeight','bold');

%% Plot Graphs
active    = Results.active;
timeSteps = Results.timeSteps;
latent    = Results.latent;
attacks   = Results.attacks;
deaths    = Results.deaths;
civilians = Results.civilians;
recruits  = Results.recruits;

Evolution = [   worldplot(1)+worldplot(3)+0.08, ...
    worldplot(2)+worldplot(4)-0.4, ...
    1-worldplot(1)-worldplot(3)-0.1 , 0.4];

axes2 = axes(   'Parent',f1, 'Position',Evolution, ...
    'Color',[0.94 0.94 0.94]);

box(axes2,'on');

plot(1:timeSteps,active(1:timeSteps),'r',1:timeSteps,latent(1:timeSteps),'c',...
    1:timeSteps,attacks(1:timeSteps),'b',1:timeSteps,deaths(1:timeSteps),'m',...
    1:timeSteps,civilians(1:timeSteps),'y','LineWidth',3);
legend('# of active insurgents','# of latent insurgents','# of attacks','# of deaths','# of civilians')
hold on
if allowLeaders == 1
    plot(1:timeSteps,recruits(1:timeSteps)','g');
    legend('# of active insurgents','# of latent insurgents','# of attacks','# of deaths','# of civilians','# of recruitments')
end
xlabel('Time Steps')
title('Evolution of Insurgency','FontWeight','bold')

%% Display Simulation Parameters
par=[ Evolution(1) worldplot(2) 0.4 Evolution(2)-worldplot(2)-0.15];
% Create textbox
annotation(f1,'textbox',...
    [par(1)-(Evolution(1)-(worldplot(1)+worldplot(3))) par(4) par(3) par(4)-0.07],...
    'String',{'Important Parameters'},...
    'FontWeight','bold',...
    'HorizontalAlignment','center',...
    'LineStyle','none');

annotation(f1,'textbox',...
    [par(1)+0.05 par(2)+0.14 par(3)-0.25 par(4)-0.05],...
    'String',{'Civilians Start:','Civilians End:','World Size:',...
    'Attack Radius:','Collateral Radius:','Influence Radius:','Time Steps:','Replacement:',...
    'Allow Leaders:','Leaders:'},...
    'FitBoxToText','off');

annotation(f1,'textbox',...
    [par(1)+0.12 par(2)+0.01 par(3) par(4)+0.08],...
    'String',{num2str(500),num2str(noc),...
    [num2str(gridSize) 'x' num2str(gridSize)],...
    num2str(AttackGrid),...
    num2str(CollateralGrid),...
    num2str(InfluenceGrid),...
    num2str(timeSteps),...
    num2str(afterlife),...
    num2str(allowLeaders),...
    num2str(nol)},...
    'FitBoxToText','on',...
    'EdgeColor','none');


end

