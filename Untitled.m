%%  What to add:

%   - Neighbouring insurgents can cooperate (for defense).
%   - Insurgents can do more actions than simply attacking soldiers.
%       - Attempt to recruit -> chance for a civilian to become a latent
%       insurgent.
%       - Propaganda - Public speaches etc -> increase anger level and
%       decrease fear level.
%       - Attack -> roll for escape -> soldiers turn
%       - Can move aroung the map? When escaping for example.
%   - Civilians: change the categories to:
%               -Supporting the regime(anger<fear).
%               -Neutral.
%               -Sympathy towards the insurgents.(anger>fear) 
%               -Latent insurgent.
%               -Active insurgent.
%               Civilians who show sympathy towards the rebels can help them escape.
%   - Soldiers can attack even when not attacked!
%   - Add terrain modifiers! better accuracy but lower effectiveness in
%   forests, whilst the opposite in cities for eg.
%   - Add public media to spread news of an attack. (maybe increase fear
%   lvls?)

%%  Soldiers
%   Global Variables
%   effectiveness = (probability to kill an insurgent)
%   accuracy => (1-accuracy = chance to injure neighbouring civilians)
%   100 total soldiers

%%  Civilians
%   Individual characteristics, ranging between 0 and 1:
%   1. Anger(0 = not angry at all,1 = maximum anger).
%   2. Fear(0 = not afraid, 1 = maximum fear).
%   3. Violence Threshold(0 =  low threshold, easy to turn to violence, 1 =
%   nearly impossible to become an insurgent).
%   LATENT INSURGENT = (Anger > Fear && Anger>Violence Threshold).
%   500 total civilians.
%   Initial values are drawn from a normal distribution.
%                           Mean    Standard Deviation
%   Anger                   0.25        0.125
%   Fear                    0.5         0.25
%   Violence Threshold      0.5         0.25

%%  Map
%   2D, with edges. Only neighbours can interact (3 cells distance).
%   50x50.
%%  Map Display
%   Soldiers = blue.
%   Civilians {green, yellow, orange, red}.
%       green = anger<fear && anger<violence threshold.
%       yellow = anger>fear && anger<violence threshold.
