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
% 2D, with edges.
% Only neighbours can interact.
% gridSize x gridSize (typically 50x50)

%% Map Display
%
% Soldiers = blue.
% Civilians {green, yellow, orange, red}.
%
%    green  = anger<fear && anger<violence threshold.
%    yellow = anger>fear && anger<violence threshold.
%    orange =
%    red    =

%% Start

clear all
close all
clc

global Civilians
global Leaders
global Soldiers
global noc
global param

%   Initialize the values of the parameters.
param = parameters();

%%  Perform single simulation
if ~param.batch
    
    Results = completeSimulation();
    Results.status
    figure1 = displayResults(Results);
    save('parameters','param');
    save('results','Results');
    
else
    
    %% Perform repetitive simulations
    
    [X,Y] = meshgrid((1:10)'/10,(0:10)'/10);
    
    simulations = zeros(size(X));
    count       = 0;
    
    %   Do multiple simulations for all combinations of effectiveness and
    %   accuracy, with/without switchPosition.
    
    for afterlife = 0:1
        
        param.afterlife = afterlife;
        
        for switchPosition=0:1
            
            param.switchPosition = switchPosition;
            
            for eff = 1:10
                
                effectiveness = eff/10;
                
                for acc = 0:10
                    
                    accuracy = acc/10;
                    SumOfTimeSteps = 0;
                    
                    for i = 1:param.runs
                        
                        nos = param.nos;
                        noc = param.noc;
                        
                        param.effectiveness = effectiveness;
                        param.accuracy      = accuracy;
                        
                        Result = completeSimulation();
                        
                        %   Collect results for this simulation.
                        Results(eff,acc+1,i) = Result;
                        
                        SumOfTimeSteps = SumOfTimeSteps + Result.timeSteps;
                        
                    end
                    
                    timeSteps = SumOfTimeSteps/param.runs;
                    
                    position = (X == eff/10).*(Y == acc/10);
                    index    = find(position == 1);
                    [r c]    = ind2sub(size(X),index);
                    
                    simulations(r,c) = timeSteps;
                    
                    count = count + 1;
                    fprintf('Simulation number:%d has ended in %d steps\n',count,timeSteps)
                    
                end
                
            end
            
            %   Plot averaged duration of insurgencies for different
            %   combinations of effectiveness and accuracy.
            
            %         figure
            %         surf(X,Y,simulations);
            %         title('Afterlife, 9, 9,15')
            %         xlabel('Effectiveness')
            %         ylabel('Accuracy')
            %         zlabel('Time Steps')
            save(sprintf('Results_Afterlife=%d_switch=%d',afterlife,switchPosition),'Results')
            save(sprintf('param_Afterlife=%d_switch=%d',afterlife,switchPosition),'param')
            %   Store the results
            %         if switchPosition==0
            %
            %             save('Results','Results')
            %             save('param','param')
            %         else
            %
            %             save('Results1','Results')
            %             save('param1','param')
            %         end
            
        end
    end
    
end