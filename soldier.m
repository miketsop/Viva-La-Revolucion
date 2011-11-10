function [S] = soldier(x,y)

%SOLDIER    Summary of this function goes here
%           Detailed explanation goes here

%% Parameters of gaussian distributions:

global effectiveness
global accuracy
global sensitivity

stde = 0.05;
stda = 0.05;

S.effectiveness = gsample(effectiveness, stde, 1);
S.accuracy      = gsample(accuracy,      stda, 1);

S.effectiveness(S.effectiveness < 0) = 0;
S.accuracy(S.accuracy < 0) = 0;
S.effectiveness(S.effectiveness > 1) = 1;
S.accuracy(S.accuracy >1) = 1;

S.sensitivity = sensitivity;

S.x = x;
S.y = y;
end

