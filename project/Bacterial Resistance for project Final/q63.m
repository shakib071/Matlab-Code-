% Parameters — Case I
params = struct( ...
    'beta_S',  0.8,  'beta_R',  0.4,  ...
    'eta',     0.3,  'k',       0.6,  ...
    'alpha1',  0.02, 'd1',      0.15, 'mu1', 0.06, ...
    'alpha2',  0.06, 'd2',      0.35, 'mu2', 0.03  ...
);

% Initial conditions
y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Solve
[t, y] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

s  = y(:,1);  r  = y(:,2);  b  = y(:,3);
a1 = y(:,4);  a2 = y(:,5);

% ── Plot 1: All 5 variables ───────────────────────────────────────────────────
figure;
hold on; grid on; box on;
plot(t, s,  'b',  'LineWidth', 2);
plot(t, r,  'r',  'LineWidth', 2);
plot(t, b,  'g',  'LineWidth', 2);
plot(t, a1, 'c',  'LineWidth', 2);
plot(t, a2, 'm',  'LineWidth', 2);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Normalized Concentration', 'FontSize', 12);
title('Case I (A<B): Time-Dependent Changes of All Variables', 'FontSize', 13);
legend('Sensitive (s)','Resistant (r)','Immune (b)','INH (a1)','PZA (a2)', ...
       'Location','best');
ylim([-0.05 1.1]); xlim([0 90]);

% ── Plot 2: Bacteria vs Immune Cells ─────────────────────────────────────────
figure;
hold on; grid on; box on;
plot(t, s+r, 'b', 'LineWidth', 2);
plot(t, b,   'g', 'LineWidth', 2);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Normalized Population', 'FontSize', 12);
title('Case I (A<B): Total Bacteria vs Immune Cells', 'FontSize', 13);
legend('Total Bacteria (s+r)','Immune Cells (b)','Location','best');
grid on;

% ── Plot 3: Antibiotic Concentrations ────────────────────────────────────────
figure;
hold on; grid on; box on;
plot(t, a1, 'c', 'LineWidth', 2);
plot(t, a2, 'm', 'LineWidth', 2);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Normalized Concentration', 'FontSize', 12);
title('Case I (A<B): Antibiotic Concentrations Over Time', 'FontSize', 13);
legend('INH (a1)','PZA (a2)','Location','best');
ylim([0 1.1]); grid on;


% Extract values at t = 0, 10, 20, 30, 40, 50, 60, 70, 80, 90
idx = [1, 11, 21, 31, 41, 51, 61, 71, 81, 91];

T_table = table( ...
    [0;10;20;30;40;50;60;70;80;90], ...
    round(s(idx),  4), ...
    round(r(idx),  4), ...
    round(s(idx)+r(idx), 4), ...
    round(b(idx),  4), ...
    round(a1(idx), 4), ...
    round(a2(idx), 4), ...
    'VariableNames', ...
    {'Time','Sensitive','Resistant','TotalBacteria','ImmuneCells','INH','PZA'});

disp(T_table)