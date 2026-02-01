
params.alpha1 = 0.06;   % Mutation rate due to INH
params.d1 = 0.35;       % Death rate due to INH
params.alpha2 = 0.02;   % Mutation rate due to ZPA
params.d2 = 0.15;       % Death rate due to ZPA

s = 0.8; %sensitive bacteria
r = 0.1; %resistant bacteria
b = 0.5; %immune cells
a1 = 1;  % INH
a2 = 1;  % ZPA



y0 = [s, r, b, a1, a2];  

tspan = [0 90]; 

[t, y] = ode45(@(t,y) model(t, y, params), tspan, y0);




%  s and r 
bacteria_table = table(t, y(:,1), y(:,2), ...
    'VariableNames', {'Time', 'SensitiveBacteria', 'ResistantBacteria'});


disp(bacteria_table)

