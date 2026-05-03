% Parameters — Case II
params = struct( ...
    'beta_S',  0.8,  'beta_R',  0.1,  ...
    'eta',     0.3,  'k',       0.6,  ...
    'alpha1',  0.02, 'd1',      0.30, 'mu1', 0.06, ...
    'alpha2',  0.06, 'd2',      0.05, 'mu2', 0.03  ...
);

% Initial conditions
y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:240;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Solve
[t, y] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

s  = y(:,1);  r  = y(:,2);  b  = y(:,3);
a1 = y(:,4);  a2 = y(:,5);

% Compute A and B to confirm A > B
A = (params.beta_S - sum([(params.alpha1+params.d1), (params.alpha2+params.d2)])) ...
    / (params.beta_S + params.eta);
B = params.beta_R / (params.beta_R + params.eta);
fprintf('Case II — A = %.4f, B = %.4f  (A > B: %d)\n', A, B, A > B);

% ── Plot 1: All 5 Variables ───────────────────────────────────────────────────
figure;
hold on; grid on; box on;
plot(t, s,  'b',  'LineWidth', 2);
plot(t, r,  'r',  'LineWidth', 2);
plot(t, b,  'g',  'LineWidth', 2);
plot(t, a1, 'c',  'LineWidth', 2);
plot(t, a2, 'm',  'LineWidth', 2);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Normalized Concentration', 'FontSize', 12);
title('Case II (A>B): Time-Dependent Changes of All Variables', 'FontSize', 13);
legend('Sensitive (s)','Resistant (r)','Immune (b)','INH (a1)','PZA (a2)', ...
       'Location','best');
ylim([-0.05 1.1]); xlim([0 90]);

% ── Plot 2: Phase Portrait s vs r ────────────────────────────────────────────
figure;
hold on; grid on; box on;
plot(s, r, 'b', 'LineWidth', 2);
plot(s(1),   r(1),   'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot(s(end), r(end), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
xlabel('Sensitive Bacteria (s)', 'FontSize', 12);
ylabel('Resistant Bacteria (r)', 'FontSize', 12);
title('Case II (A>B): Phase Portrait — s vs r', 'FontSize', 13);
legend('Trajectory','Start','End ','Location','best');

figure;
hold on; grid on; box on;

plot(s, r, 'b', 'LineWidth', 2);

% Markers
plot(s(1),   r(1),   'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot(s(end), r(end), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

% Annotate start point
text(s(1)+0.02, r(1), ...
    sprintf('s=%.2f, r=%.2f', s(1), r(1)), ...
     'FontSize', 10, 'FontWeight', 'bold');

% Annotate end point
text(s(end)+0.02, r(end), ...
    sprintf('s=%.2f, r=%.2f', s(end), r(end)), ...
     'FontSize', 10, 'FontWeight', 'bold');

xlabel('Sensitive Bacteria (s)', 'FontSize', 12);
ylabel('Resistant Bacteria (r)', 'FontSize', 12);
title('Case II (A>B): Phase Portrait — s vs r', 'FontSize', 13);
xlim([-0.05  1.0]);
ylim([0  0.25]);
grid on; box on;

% ── Plot 3: Bacteria and Immune Coexistence ───────────────────────────────────
figure;
hold on; grid on; box on;
plot(t, s,   'b',  'LineWidth', 2);
plot(t, r,   'r',  'LineWidth', 2);
plot(t, b,   'g',  'LineWidth', 2);
plot(t, s+r, 'k--','LineWidth', 1.5);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Normalized Population', 'FontSize', 12);
title('Case II (A>B): Bacteria and Immune Cell Coexistence', 'FontSize', 13);
legend('Sensitive (s)','Resistant (r)','Immune (b)','Total (s+r)','Location','best');
ylim([-0.05 1.1]);

% ── Table: Key values at t = 0, 30, 60, 90 ───────────────────────────────────
idx = [1, 21, 41, 61, 81, 101,  121,  141,  161, 181, 201, 221, 241];
T_table = table( ...
    [0;20;40;60;80;100;120;140;160;180;200;220;240], ...
    round(s(idx),  4), ...
    round(r(idx),  4), ...
    round(s(idx)+r(idx), 4), ...
    round(b(idx),  4), ...
    round(a1(idx), 4), ...
    round(a2(idx), 4), ...
    'VariableNames', ...
    {'Time','Sensitive','Resistant','TotalBacteria','ImmuneCells','INH','PZA'});

disp(T_table)