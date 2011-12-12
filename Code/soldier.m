function [S] = soldier(x,y)

%SOLDIER    Generates an agent of type 'soldier' and returns its struct.

%% Parameters of gaussian distributions:
global param

effectiveness = param.effectiveness;
accuracy      = param.accuracy;
sensitivity   = param.sensitivity;

% stde = 0.05^2;
% stda = 0.05^2;

stde = 0;
stda = 0;

S.effectiveness = gsample(effectiveness, stde, 1);
S.accuracy      = gsample(accuracy,      stda, 1);

S.effectiveness(S.effectiveness < 0) = 0;
S.accuracy(S.accuracy < 0) = 0;
S.effectiveness(S.effectiveness > 1) = 1;
S.accuracy(S.accuracy >1) = 1;

S.sensitivity = sensitivity;

S.x = x;
S.y = y;
S.Colour = [0 0 1];

end

