function [C] = civilian(x,y)

%CIVILAN    Summary of this function goes here
%           

%%  Parameters of gaussian distributions:
%   WARNING:  changed std1x to accurately reflect STD

%   Rich

mean1a = 0.15;
std1a  = 0.125^2;
mean1f = 0.7;
std1f  = 0.25^2;
mean1t = 0.8;
std1t  = 0.25^2;

% Middle

mean2a = 0.25;
std2a  = 0.125^2;       
mean2f = 0.5;
std2f  = 0.25^2;
mean2t = 0.5;
std2t  = 0.25^2;

% Poor

mean3a = 0.45;
std3a  = 0.125^2;
mean3f = 0.2;
std3f  = 0.25^2;
mean3t = 0.4;
std3t  = 0.25^2;

%% Creating civilian

dice = 100*rand(1);

if dice > 85
    
    C.wealth = 'Rich';
    C.anger  = gsample(mean1a,std1a,1);
    C.fear   = gsample(mean1f,std1f,1);
    C.thres  = gsample(mean1t,std1t,1);
    
elseif dice > 20
    
    C.wealth = 'Middle';
    C.anger  = gsample(mean2a,std2a,1);
    C.fear   = gsample(mean2f,std2f,1);
    C.thres  = gsample(mean2t,std2t,1);

    
else
    
    C.wealth = 'Poor';
    C.anger  = gsample(mean3a,std3a,1);
    C.fear   = gsample(mean3f,std3f,1);
    C.thres  = gsample(mean3t,std3t,1);

    
end

C.x = x;
C.y = y;

%% Limits [0,1]

C.anger(C.anger < 0) = 0;
C.fear(C.fear   < 0) = 0;
C.thres(C.thres < 0) = 0;

C.anger(C.anger > 1) = 1;
C.fear(C.fear   > 1) = 1;
C.thres(C.thres > 1) = 1;

C.attack = 0;               %   attack = 1 => civilian has made an attack.
C.threat = 0;               %   threat = 1 => civilian is at least latent.
end

