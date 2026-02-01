tspan = [0 90];

s = 0.8; r = 0.05; b = 0.05; a1 = 0.05; a2 = 0.02;

params.alpha1 = 0.02; params.d1 = 0.15;
params.alpha2 = 0.06; params.d2 = 0.35;

y0 = [s r b a1 a2];


[t,y] = ode45(@(t,y) model(t,y,params), tspan, y0);

s  = y(:,1);
r  = y(:,2);
b  = y(:,3);
a1 = y(:,4);
a2 = y(:,5);


%  TABLE

results = table(t, s, r, b, a1, a2, ...
    'VariableNames', {'Time','SensitiveBacteria','ResistantBacteria','ImmuneCells','INH','ZPA'});


disp(results)
