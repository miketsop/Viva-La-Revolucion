%%  POST-PROCESSING
%   This script can be used for post-processing data of the simulations. 


clear all
close all
clc

load('Results1.mat')
undecided = 0;
defeated  = 0;
for i=1:10  %effectiveness
    
    for j=1:11  % accuracy
        
        timeSteps = 0;
        death = 0;
        for k=1:5
            
            if strcmp(Results(i,j,k).status,'defeated')
                defeated = defeated + 1;
            else
                undecided = undecided + 1;
            end
            death     = death + Results(i,j,k).deaths(Results(i,j,k).timeSteps);
            timeSteps = timeSteps+Results(i,j,k).timeSteps;
            
        end
        deaths(i,j) = death/5;
        time(i,j) = timeSteps/5;
        
    end
    
end

figure
X = (1:10)/10;
Y = (0:10)/10;
surf(X,Y,time')
xlabel('effectiveness','FontSize',12,'FontWeight','bold')
ylabel('accuracy','FontSize',12,'FontWeight','bold')
zlabel('Time steps','FontSize',12,'FontWeight','bold')
title('Average Simulation Time for combinations of effectiveness-accuracy.','FontSize',12,'FontWeight','bold')
% title('Average Simulation Time - No replacement, No change of position')

figure
surf(X,Y,deaths')
xlabel('effectiveness','FontSize',12,'FontWeight','bold')
ylabel('accuracy','FontSize',12,'FontWeight','bold')
zlabel('Deaths','FontSize',12,'FontWeight','bold')
title('Average deaths for combinations of effectiveness-accuracy.','FontSize',12,'FontWeight','bold')
% title('Average Simulation Time - No replacement, No change of position')
