
tspan = 0:5:90;   % Output every 5 days: t = 0, 5, 10, ..., 90

s0  = 0.8;  r0 = 0.05;  b0 = 0.05;
a10 = 0.05; a20 = 0.02;

% params.beta_S  = 0.8;
% params.beta_R  = 0.4;
% params.eta     = 0.3;
% params.k       = 0.6;
% params.alpha1  = 0.02;   params.d1 = 0.15;
% params.alpha2  = 0.06;   params.d2 = 0.35;
% params.mu1     = 0.06;
% params.mu2     = 0.03;

params = struct( ...
    'beta_S',  0.8,  ...
    'beta_R',  0.4,  ...
    'eta',     0.3,  ...
    'k',       0.6,  ...
    'alpha1',  0.02, 'd1', 0.15, 'mu1', 0.06, ...
    'alpha2',  0.06, 'd2', 0.35, 'mu2', 0.03  ...
);

y0 = [s0; r0; b0; a10; a20];
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

[t, y] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);


T = makeResultsTable(t, y);
disp(T)