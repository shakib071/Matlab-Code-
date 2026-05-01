%% =========================================================
%  Logistic Population Model with Harvesting
%  Covers: (A) Constant Harvesting  (B) Periodic Harvesting
%
%  All parameters are set in the USER PARAMETERS section below.
%  Change any value there — no other part of the code needs editing.
%
%  Equations:
%    Constant : dP/dt = k*P*(1 - P/N) - a
%    Periodic : dP/dt = k*P*(1 - P/N) - a*(1 + sin(b*t))
%
%  Equilibria (constant case) solved via quadratic formula:
%    P^2 - N*P + (a*N/k) = 0
%    P1 = (N + sqrt(N^2 - 4*a*N/k)) / 2   (stable)
%    P2 = (N - sqrt(N^2 - 4*a*N/k)) / 2   (unstable)
%    MSY (Maximum Sustainable Yield) = k*N/4
% =========================================================

clc; clear; close all;

%% =========================================================
%  USER PARAMETERS  —  edit only this section
% =========================================================
k    = 0.20;   % intrinsic growth rate
N    = 5;      % carrying capacity
P0   = 4.0;    % initial population (used for single-trajectory plots)
a    = 0.21;   % harvesting rate  (a1 for moderate, try a2=0.25 for MSY)
b    = 1.0;    % angular frequency for periodic harvesting (seasons per time unit)
tspan = [0 30]; % time window for ODE integration
% =========================================================
%  END OF USER PARAMETERS
% =========================================================

%% --- Derived quantities ---
MSY   = k * N / 4;          % maximum sustainable yield
disc  = N^2 - 4*(a*N/k);    % discriminant for equilibrium quadratic

fprintf('========== Model Parameters ==========\n');
fprintf('  k = %.4f,  N = %.4f,  a = %.4f\n', k, N, a);
fprintf('  MSY = k*N/4 = %.4f\n', MSY);

if disc > 0
    P1_eq = (N + sqrt(disc)) / 2;
    P2_eq = (N - sqrt(disc)) / 2;
    fprintf('  Discriminant > 0 → two equilibria exist\n');
    fprintf('  P1 (stable)   = %.6f\n', P1_eq);
    fprintf('  P2 (unstable) = %.6f\n', P2_eq);
elseif disc == 0
    P1_eq = N / 2;
    P2_eq = N / 2;
    fprintf('  Discriminant = 0 → single (saddle-node) equilibrium at P = %.4f (MSY point)\n', P1_eq);
else
    P1_eq = NaN;
    P2_eq = NaN;
    fprintf('  Discriminant < 0 → NO real equilibria (a > MSY → extinction possible)\n');
end
fprintf('======================================\n\n');

%% =========================================================
%  ODE DEFINITIONS
% =========================================================
ode_const    = @(t, P) k*P*(1 - P/N) - a;
ode_periodic = @(t, P) k*P*(1 - P/N) - a*(1 + sin(b*t));

opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'NonNegative', 1);

%% =========================================================
%  FIGURE 1  —  Equilibrium Points P1 & P2 vs  harvesting rate a
% =========================================================
a_max   = MSY * 1.05;           % sweep a from 0 to just above MSY
a_sweep = linspace(0, a_max, 300);
P1_sweep = nan(size(a_sweep));
P2_sweep = nan(size(a_sweep));

for i = 1:numel(a_sweep)
    d = N^2 - 4*(a_sweep(i)*N/k);
    if d >= 0
        P1_sweep(i) = (N + sqrt(d)) / 2;
        P2_sweep(i) = (N - sqrt(d)) / 2;
    end
end

figure(1);
set(gcf, 'Name', 'Fig 1 – Equilibrium Map', 'Color', 'w', ...
         'Position', [60 540 580 380]);

plot(a_sweep, P1_sweep, 'b-', 'LineWidth', 2.5, 'DisplayName', 'P_1 (stable)');
hold on;
plot(a_sweep, P2_sweep, 'r-', 'LineWidth', 2.5, 'DisplayName', 'P_2 (unstable)');
plot(MSY, N/2, 'kp', 'MarkerSize', 14, 'MarkerFaceColor', [1 0.85 0], ...
     'DisplayName', sprintf('MSY  a = %.4f', MSY));

% Mark the chosen a on the map
if ~isnan(P1_eq)
    plot(a, P1_eq, 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b', ...
         'DisplayName', sprintf('P_1 at chosen a=%.2f', a));
    plot(a, P2_eq, 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r', ...
         'DisplayName', sprintf('P_2 at chosen a=%.2f', a));
end

xline(MSY, '--k', 'LineWidth', 1, 'Alpha', 0.4, 'HandleVisibility', 'off');
xlabel('Harvesting rate  a', 'FontSize', 13);
ylabel('Equilibrium population  P', 'FontSize', 13);
title('Equilibrium Points  P_1  and  P_2  vs  Harvesting Rate', ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 11);
xlim([0 a_max*1.02]);
ylim([0 N * 1.1]);
grid on;
box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 2  —  Phase portrait  dP/dt vs P  (constant harvesting)
% =========================================================
P_range = linspace(0, N * 1.3, 500);
dPdt_const = k .* P_range .* (1 - P_range ./ N) - a;

figure(2);
set(gcf, 'Name', 'Fig 2 – Phase Portrait (Constant)', 'Color', 'w', ...
         'Position', [60 100 580 340]);

fill([P_range, fliplr(P_range)], ...
     [max(dPdt_const, 0), zeros(1, numel(P_range))], ...
     [0.88 0.96 0.91], 'EdgeColor', 'none', 'DisplayName', 'Growth region');
hold on;
fill([P_range, fliplr(P_range)], ...
     [min(dPdt_const, 0), zeros(1, numel(P_range))], ...
     [0.98 0.91 0.89], 'EdgeColor', 'none', 'DisplayName', 'Decline region');

plot(P_range, dPdt_const, 'b-', 'LineWidth', 2.2, 'DisplayName', 'dP/dt');
yline(0, '--k', 'LineWidth', 1.2, 'Alpha', 0.5, 'HandleVisibility', 'off');

if ~isnan(P1_eq)
    xline(P1_eq, '-', 'Color', [0.05 0.45 0.25], 'LineWidth', 1.8, ...
          'Label', sprintf('P_1=%.3f (stable)', P1_eq), ...
          'LabelVerticalAlignment', 'bottom', 'FontSize', 10);
    xline(P2_eq, '-', 'Color', [0.65 0.22 0.12], 'LineWidth', 1.8, ...
          'Label', sprintf('P_2=%.3f (unstable)', P2_eq), ...
          'LabelVerticalAlignment', 'bottom', 'FontSize', 10);
end

xlabel('Population  P', 'FontSize', 13);
ylabel('dP/dt', 'FontSize', 13);
title(sprintf('Phase Portrait — Constant Harvesting\ndP/dt = %.2fP(1−P/%.1f) − %.2f', k, N, a), ...
      'FontSize', 12, 'FontWeight', 'bold');
legend({'Growth region','Decline region','dP/dt'}, 'Location', 'best', 'FontSize', 10);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 3  —  Slope field + solution curves  (constant harvesting)
% =========================================================
figure(3);
set(gcf, 'Name', 'Fig 3 – Slope Field & Trajectories (Constant)', 'Color', 'w', ...
         'Position', [660 540 620 420]);

% Slope field grid
[T_sf, P_sf] = meshgrid(linspace(tspan(1), tspan(2), 22), ...
                         linspace(0, N*1.3, 18));
dP_sf = k .* P_sf .* (1 - P_sf ./ N) - a;
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2);
mag(mag == 0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.52, ...
       'Color', [0.72 0.72 0.72], 'LineWidth', 0.7);
hold on;

% Multiple initial conditions spanning above/below equilibria
if ~isnan(P1_eq)
    ics = unique([P0, P1_eq*1.15, P1_eq*0.85, P2_eq*1.15, P2_eq*0.85, ...
                  N*0.1, N*0.05]);
else
    ics = [P0, P0*0.8, P0*0.6, P0*0.4, P0*0.2, N*0.05];
end
ics = ics(ics > 0);

colors = lines(numel(ics));
for i = 1:numel(ics)
    [tt, PP] = ode45(ode_const, tspan, ics(i), opts);
    plot(tt, PP, '-', 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P_0=%.2f', ics(i)));
end

% Equilibrium lines
if ~isnan(P1_eq)
    yline(P1_eq, '--', 'Color', [0.05 0.45 0.25], 'LineWidth', 1.6, ...
          'Label', sprintf('P_1=%.3f stable', P1_eq), 'FontSize', 9, ...
          'LabelHorizontalAlignment', 'left');
    if P1_eq ~= P2_eq
        yline(P2_eq, '--', 'Color', [0.65 0.22 0.12], 'LineWidth', 1.6, ...
              'Label', sprintf('P_2=%.3f unstable', P2_eq), 'FontSize', 9, ...
              'LabelHorizontalAlignment', 'left');
    end
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field & Trajectories — Constant Harvesting  (a = %.2f)', a), ...
      'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim(tspan);  ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 4  —  Slope field + solution curves  (periodic harvesting)
% =========================================================
figure(4);
set(gcf, 'Name', 'Fig 4 – Slope Field & Trajectories (Periodic)', 'Color', 'w', ...
         'Position', [660 100 620 420]);

[T_p, P_p] = meshgrid(linspace(tspan(1), tspan(2), 22), ...
                       linspace(0, N*1.3, 18));
dP_p  = k .* P_p .* (1 - P_p ./ N) - a .* (1 + sin(b .* T_p));
dT_p  = ones(size(dP_p));
mag_p = sqrt(dT_p.^2 + dP_p.^2);
mag_p(mag_p == 0) = 1;
quiver(T_p, P_p, dT_p./mag_p, dP_p./mag_p, 0.52, ...
       'Color', [0.72 0.72 0.72], 'LineWidth', 0.7);
hold on;

ics_p = [P0, P0*0.7, P0*0.5, P0*0.3, N*0.15, N*0.05];
ics_p = ics_p(ics_p > 0);
colors_p = lines(numel(ics_p));

for i = 1:numel(ics_p)
    [tt, PP] = ode45(ode_periodic, tspan, ics_p(i), opts);
    plot(tt, PP, '-', 'Color', colors_p(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P_0=%.2f', ics_p(i)));
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field & Trajectories — Periodic Harvesting\ndP/dt = %.2fP(1−P/%.1f) − %.2f(1+sin(%.1ft))', ...
      k, N, a, b), 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim(tspan);  ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 5  —  Side-by-side comparison: constant vs periodic
%               for the SAME initial condition P0
% =========================================================
figure(5);
set(gcf, 'Name', 'Fig 5 – Constant vs Periodic Comparison', 'Color', 'w', ...
         'Position', [360 300 800 360]);

[t_c, P_c] = ode45(ode_const,    tspan, P0, opts);
[t_p, P_p2] = ode45(ode_periodic, tspan, P0, opts);

subplot(1,2,1);
plot(t_c, P_c, 'b-', 'LineWidth', 2.2);
if ~isnan(P1_eq)
    yline(P1_eq, '--g', 'LineWidth', 1.4, ...
          'Label', sprintf('P_1=%.3f', P1_eq), 'FontSize', 9, ...
          'LabelHorizontalAlignment', 'left');
    yline(P2_eq, '--r', 'LineWidth', 1.4, ...
          'Label', sprintf('P_2=%.3f', P2_eq), 'FontSize', 9, ...
          'LabelHorizontalAlignment', 'left');
end
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title(sprintf('Constant Harvesting  (a=%.2f)', a), 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 N*1.2]);  grid on; box on;
set(gca, 'FontSize', 11);

subplot(1,2,2);
plot(t_p, P_p2, 'r-', 'LineWidth', 2.2);
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title(sprintf('Periodic Harvesting  (a=%.2f, b=%.1f)', a, b), 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 N*1.2]);  grid on; box on;
set(gca, 'FontSize', 11);

sgtitle(sprintf('Logistic Harvesting  |  k=%.2f,  N=%.1f,  P_0=%.2f', k, N, P0), ...
        'FontSize', 13, 'FontWeight', 'bold');

%% =========================================================
%  FIGURE 6  —  Harvesting rate sweep: extinction threshold
%               Shows how final population at t=tspan(2)
%               changes as a increases from 0 to 1.2*MSY
% =========================================================
figure(6);
set(gcf, 'Name', 'Fig 6 – Extinction Threshold Sweep', 'Color', 'w', ...
         'Position', [360 100 560 360]);

a_sweep2   = linspace(0, MSY*1.3, 120);
P_final_c  = nan(size(a_sweep2));
P_final_p  = nan(size(a_sweep2));

for i = 1:numel(a_sweep2)
    ai = a_sweep2(i);
    try
        [~, Pc] = ode45(@(t,P) k*P*(1-P/N) - ai,           tspan, P0, opts);
        P_final_c(i) = max(Pc(end), 0);
    catch; end
    try
        [~, Pp] = ode45(@(t,P) k*P*(1-P/N) - ai*(1+sin(b*t)), tspan, P0, opts);
        P_final_p(i) = max(Pp(end), 0);
    catch; end
end

plot(a_sweep2, P_final_c, 'b-', 'LineWidth', 2.2, 'DisplayName', 'Constant harvesting');
hold on;
plot(a_sweep2, P_final_p, 'r-', 'LineWidth', 2.2, 'DisplayName', 'Periodic harvesting');
xline(MSY, '--k', 'LineWidth', 1.4, 'Label', sprintf('MSY=%.4f', MSY), ...
      'FontSize', 10, 'LabelHorizontalAlignment', 'right');
yline(0, ':k', 'LineWidth', 1, 'HandleVisibility', 'off');

xlabel('Harvesting rate  a', 'FontSize', 13);
ylabel(sprintf('Population at  t = %d', tspan(2)), 'FontSize', 13);
title('Extinction Threshold — Final Population vs Harvesting Rate', ...
      'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  TABLE — print equilibrium values for a range of a values
%          (replicates Table 1 from the lab report, generalized)
% =========================================================
fprintf('\n============================================================\n');
fprintf('  Equilibrium Table  (k=%.2f, N=%.1f)\n', k, N);
fprintf('  MSY = k*N/4 = %.4f\n', MSY);
fprintf('------------------------------------------------------------\n');
fprintf('  %-10s  %-20s  %-20s\n', 'a', 'P1 (stable)', 'P2 (unstable)');
fprintf('------------------------------------------------------------\n');

a_tbl = [0, 0.2*MSY, 0.4*MSY, 0.6*MSY, 0.8*MSY, MSY];
for ai = a_tbl
    d = N^2 - 4*(ai*N/k);
    if d > 0
        fprintf('  %-10.4f  %-20.9f  %-20.9f\n', ai, ...
            (N+sqrt(d))/2, (N-sqrt(d))/2);
    elseif d == 0
        fprintf('  %-10.4f  %-20.9f  %-20s\n', ai, N/2, '(= P1, MSY point)');
    else
        fprintf('  %-10.4f  %-20s  %-20s\n', ai, 'undefined', 'undefined');
    end
end
fprintf('============================================================\n');
