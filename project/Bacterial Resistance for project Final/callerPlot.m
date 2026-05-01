% ── CASE 1: B < A  (all variables) ───────────────────────────────────────────
params = struct('beta_S',0.8,'beta_R',0.4,'eta',0.3,'k',0.6, ...
                'alpha1',0.06,'d1',0.35,'mu1',0.06, ...
                'alpha2',0.02,'d2',0.15,'mu2',0.03);

y0    = [0.8, 0.07, 0.05, 0.05, 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

[t1, y1] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

plotModel(t1, y1, 'all', struct( ...
    'title', 'B < A: Time-Dependent Changes of All Variables', ...
    'ylim',  [-0.2 1.05], ...
    'xlim',  [0 90]));

% ── CASE 2: A < B  (bacteria vs immune) ──────────────────────────────────────
params.alpha1 = 0.02;  params.d1 = 0.15;
params.alpha2 = 0.06;  params.d2 = 0.35;

y0 = [0.8, 0.05, 0.05, 0.05, 0.02];

[t2, y2] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

plotModel(t2, y2, 'bacteria', struct( ...
    'title', 'A < B: Bacteria vs Immune Cells'));

% ── CASE 3: Phase portrait ────────────────────────────────────────────────────
params.alpha1 = 0.06;  params.d1 = 0.35;
params.alpha2 = 0.02;  params.d2 = 0.15;

y0 = [0.8, 0.1, 0.5, 1.0, 1.0];

[t3, y3] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

plotModel(t3, y3, 'phase');