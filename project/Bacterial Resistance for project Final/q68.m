y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% ── INH only — weak treatment, A < B barely ──────────────────────────────────
% A = (0.8 - 0.02 - 0.10) / (0.8+0.3) = 0.6182
% B = 0.4/0.7 = 0.5714  →  A > B  →  E3 (coexistence, bad)
p_INH = struct( ...
    'beta_S',0.8, 'beta_R',0.4, ...
    'eta',0.3,    'k',0.6,      ...
    'alpha1',0.02,'d1',0.10,    'mu1',0.06, ...
    'alpha2',0,   'd2',0,       'mu2',0.03);

% A_INH = (0.8 - (0.02+0.10) - 0) / (0.8+0.3)
%       = (0.8 - 0.12) / 1.1
%       = 0.68 / 1.1
%       = 0.6182  >  B=0.5714  →  E3

% ── PZA only — moderate treatment, A < B barely ──────────────────────────────
p_PZA = struct( ...
    'beta_S',0.8, 'beta_R',0.4, ...
    'eta',0.3,    'k',0.6,      ...
    'alpha1',0,   'd1',0,       'mu1',0.06, ...
    'alpha2',0.06,'d2',0.20,    'mu2',0.03);

% A_PZA = (0.8 - 0 - (0.06+0.20)) / 1.1
%       = (0.8 - 0.26) / 1.1
%       = 0.54 / 1.1
%       = 0.4909  <  B=0.5714  →  E2 (resistant dominates)

% ── Combination — strong treatment, A << B ───────────────────────────────────
p_both = struct( ...
    'beta_S',0.8, 'beta_R',0.4, ...
    'eta',0.3,    'k',0.6,      ...
    'alpha1',0.02,'d1',0.10,    'mu1',0.06, ...
    'alpha2',0.06,'d2',0.20,    'mu2',0.03);

% A_both = (0.8 - (0.02+0.10) - (0.06+0.20)) / 1.1
%        = (0.8 - 0.12 - 0.26) / 1.1
%        = 0.42 / 1.1
%        = 0.3818  <  B=0.5714  →  E2 (resistant dominates but lower)

[t1,y1] = ode45(@(t,y) model(t,y,p_INH),  tspan, y0, opts);
[t2,y2] = ode45(@(t,y) model(t,y,p_PZA),  tspan, y0, opts);
[t3,y3] = ode45(@(t,y) model(t,y,p_both), tspan, y0, opts);

% ── Compute A values for title annotation ─────────────────────────────────────
A_INH  = (0.8 - 0.12 - 0)    / 1.1;   % 0.6182
A_PZA  = (0.8 - 0    - 0.26) / 1.1;   % 0.4909
A_both = (0.8 - 0.12 - 0.26) / 1.1;   % 0.3818
B_val  = 0.4 / 0.7;                    % 0.5714

figure;
hold on; grid on; box on;

plot(t1, y1(:,1)+y1(:,2), 'r',  'LineWidth', 2);
plot(t2, y2(:,1)+y2(:,2), 'b',  'LineWidth', 2);
plot(t3, y3(:,1)+y3(:,2), 'g',  'LineWidth', 2);

% Mark equilibrium line
yline(B_val, 'k--', 'LineWidth', 1.2);

xlabel('Time (days)',        'FontSize', 12);
ylabel('Total Bacteria (s+r)','FontSize', 12);
title('Single vs Combination Antibiotic Therapy', 'FontSize', 13);
legend( ...
    sprintf('INH only      (A=%.4f > B → coexistence)', A_INH),  ...
    sprintf('PZA only      (A=%.4f < B → E2)',           A_PZA),  ...
    sprintf('INH+PZA combo (A=%.4f < B → E2)',           A_both), ...
    sprintf('Equilibrium B = %.4f', B_val), ...
    'Location','best');
ylim([0 1.1]); xlim([0 90]);

figure;
hold on; grid on; box on;

% Show SENSITIVE bacteria only — this is where the difference is clear
plot(t1, y1(:,1), 'r', 'LineWidth', 2);   % INH only
plot(t2, y2(:,1), 'b', 'LineWidth', 2);   % PZA only
plot(t3, y3(:,1), 'g', 'LineWidth', 2);   % Combination

xlabel('Time (days)',          'FontSize', 12);
ylabel('Sensitive Bacteria (s)','FontSize', 12);
title('Single vs Combination Antibiotic Therapy', ...
       'FontSize', 13);
legend( ...
    sprintf('INH only      (A=%.4f > B → coexistence)', A_INH), ...
    sprintf('PZA only      (A=%.4f < B → E2)',           A_PZA), ...
    sprintf('INH+PZA combo (A=%.4f < B → E2)',           A_both),...
    'Location', 'best');
ylim([0 1.1]); xlim([0 90]);
grid on; box on;