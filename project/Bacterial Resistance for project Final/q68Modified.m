%% ═══════════════════════════════════════════════════════════════════
%  Single vs Combination Antibiotic Therapy
%  Compares: INH only | PZA only | INH+PZA combination
% ═══════════════════════════════════════════════════════════════════

clear; clc; close all;

%% ── Initial Conditions ──────────────────────────────────────────────
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Separate initial conditions — no drug at t=0 for unused antibiotic
y0_INH  = [0.80; 0.05; 0.05; 0.05; 0.00];  % no PZA
y0_PZA  = [0.80; 0.05; 0.05; 0.00; 0.02];  % no INH
y0_both = [0.80; 0.05; 0.05; 0.05; 0.02];  % both antibiotics

%% ── Parameters ──────────────────────────────────────────────────────

% INH only
% A = (0.8 - (0.02+0.20) - 0) / (0.8+0.3)
%   = (0.8 - 0.22) / 1.1
%   = 0.5273  <  B=0.5714  →  E2 (resistant dominates)
p_INH = struct( ...
    'beta_S', 0.8,  'beta_R', 0.4,  ...
    'eta',    0.3,  'k',      0.6,  ...
    'alpha1', 0.02, 'd1',     0.20, 'mu1', 0.06, ...
    'alpha2', 0.00, 'd2',     0.00, 'mu2', 0.01);

% PZA only
% A = (0.8 - 0 - (0.06+0.20)) / (0.8+0.3)
%   = (0.8 - 0.26) / 1.1
%   = 0.4909  <  B=0.5714  →  E2 (resistant dominates)
p_PZA = struct( ...
    'beta_S', 0.8,  'beta_R', 0.4,  ...
    'eta',    0.3,  'k',      0.6,  ...
    'alpha1', 0.00, 'd1',     0.00, 'mu1', 0.01, ...
    'alpha2', 0.06, 'd2',     0.20, 'mu2', 0.03);

% Combination INH + PZA
% A = (0.8 - (0.02+0.10) - (0.06+0.20)) / (0.8+0.3)
%   = (0.8 - 0.12 - 0.26) / 1.1
%   = 0.3818  <<  B=0.5714  →  E2 (fastest clearance)
p_both = struct( ...
    'beta_S', 0.8,  'beta_R', 0.4,  ...
    'eta',    0.3,  'k',      0.6,  ...
    'alpha1', 0.02, 'd1',     0.10, 'mu1', 0.06, ...
    'alpha2', 0.06, 'd2',     0.20, 'mu2', 0.03);

%% ── Compute Threshold Values ─────────────────────────────────────────
B_val  = p_both.beta_R / (p_both.beta_R + p_both.eta);   % 0.5714

A_INH  = (p_INH.beta_S  - (p_INH.alpha1  + p_INH.d1)  ...
                         - (p_INH.alpha2  + p_INH.d2))  ...
         / (p_INH.beta_S  + p_INH.eta);                  % 0.5273

A_PZA  = (p_PZA.beta_S  - (p_PZA.alpha1  + p_PZA.d1)  ...
                         - (p_PZA.alpha2  + p_PZA.d2))  ...
         / (p_PZA.beta_S  + p_PZA.eta);                  % 0.4909

A_both = (p_both.beta_S - (p_both.alpha1 + p_both.d1)  ...
                        - (p_both.alpha2 + p_both.d2))  ...
         / (p_both.beta_S + p_both.eta);                 % 0.3818

fprintf('B     = %.4f\n', B_val);
fprintf('A_INH = %.4f  →  %s\n', A_INH,  condition(A_INH,  B_val));
fprintf('A_PZA = %.4f  →  %s\n', A_PZA,  condition(A_PZA,  B_val));
fprintf('A_both= %.4f  →  %s\n', A_both, condition(A_both, B_val));

%% ── Solve ODEs ───────────────────────────────────────────────────────
[t1, y1] = ode45(@(t,y) model(t,y,p_INH),  tspan, y0_INH,  opts);
[t2, y2] = ode45(@(t,y) model(t,y,p_PZA),  tspan, y0_PZA,  opts);
[t3, y3] = ode45(@(t,y) model(t,y,p_both), tspan, y0_both, opts);

%% ── Figure 1: Total Bacterial Load ──────────────────────────────────
figure('Position',[100 100 750 480]);
hold on; grid on; box on;

plot(t1, y1(:,1)+y1(:,2), 'r-',  'LineWidth', 2);
plot(t2, y2(:,1)+y2(:,2), 'b-',  'LineWidth', 2);
plot(t3, y3(:,1)+y3(:,2), 'g-',  'LineWidth', 2);
yline(B_val, 'k--', 'LineWidth', 1.5);

xlabel('Time (days)',         'FontSize', 12);
ylabel('Total Bacteria (s+r)','FontSize', 12);
title('Single vs Combination Antibiotic Therapy', 'FontSize', 13, 'FontWeight', 'bold');

legend('INH only', ...
       'PZA only', ...
       'INH+PZA (Combination)', ...
       sprintf('E_2 equilibrium (B = %.4f)', B_val), ...
       'Location', 'northeast', 'FontSize', 10);

ylim([0 1.0]); xlim([0 90]);

% % Annotate final values
% text(91, y1(end,1)+y1(end,2), sprintf('%.3f', y1(end,1)+y1(end,2)), ...
%     'FontSize',9, 'Color','r', 'Clipping','off');
% text(91, y2(end,1)+y2(end,2), sprintf('%.3f', y2(end,1)+y2(end,2)), ...
%     'FontSize',9, 'Color','b', 'Clipping','off');
% text(91, y3(end,1)+y3(end,2), sprintf('%.3f', y3(end,1)+y3(end,2)), ...
%     'FontSize',9, 'Color','g', 'Clipping','off');

%% ── Figure 2: Sensitive Bacteria Only ───────────────────────────────
figure('Position',[100 100 750 480]);
hold on; grid on; box on;

plot(t1, y1(:,1), 'r-', 'LineWidth', 2);
plot(t2, y2(:,1), 'b-', 'LineWidth', 2);
plot(t3, y3(:,1), 'g-', 'LineWidth', 2);

xlabel('Time (days)',           'FontSize', 12);
ylabel('Sensitive Bacteria (s)','FontSize', 12);
title('Single vs Combination Antibiotic Therapy', 'FontSize', 13, 'FontWeight', 'bold');

legend('INH only', ...
       'PZA only', ...
       'INH+PZA (Combination)', ...
       'Location', 'northeast', 'FontSize', 10);

ylim([0 1.0]); xlim([0 90]);

%% ── Numerical Results Table ──────────────────────────────────────────
fprintf('\n══════════════════════════════════════════════════════\n');
fprintf('  Day  |  INH only  |  PZA only  |  Combination\n');
fprintf('──────────────────────────────────────────────────────\n');
days = [0 10 20 30 40 50 60 70 80 90];
for i = 1:length(days)
    d = days(i) + 1;
    fprintf('  %3d  |   %.4f   |   %.4f   |   %.4f\n', ...
        days(i), ...
        y1(d,1)+y1(d,2), ...
        y2(d,1)+y2(d,2), ...
        y3(d,1)+y3(d,2));
end
fprintf('══════════════════════════════════════════════════════\n');

%% ── Model Function ───────────────────────────────────────────────────
% function dydt = model(~, y, p)
%     s  = y(1);
%     r  = y(2);
%     b  = y(3);
%     a1 = y(4);
%     a2 = y(5);

%     % Sensitive bacteria
%     ds = p.beta_S * s * (1 - s - r) ...
%        - p.eta * s * b ...
%        - s * ((p.alpha1 + p.d1)*a1 + (p.alpha2 + p.d2)*a2);

%     % Resistant bacteria
%     dr = p.beta_R * r * (1 - s - r) ...
%        - p.eta * r * b ...
%        + s * (p.alpha1*a1 + p.alpha2*a2);

%     % Immune cells
%     total = s + r;
%     if total > 1e-10
%         db = p.k * b * (1 - b / total);
%     else
%         db = -p.k * b;
%     end

%     % Antibiotic concentrations
%     da1 = p.mu1 * (1 - a1);
%     da2 = p.mu2 * (1 - a2);

%     dydt = [ds; dr; db; da1; da2];
% end

%% ── Helper Function ──────────────────────────────────────────────────
function str = condition(A, B)
    if A < B
        str = 'A < B  →  E2 (resistant dominates)';
    else
        str = 'A > B  →  E3 (coexistence)';
    end
end