%% Chapter 3 - Constant Harvesting: Table and Plots
clc; clear; close all;

%% --- Parameters ---
k  = 0.20;
N  = 5;
MSY = k*N/4;

%% =========================================================
%  TABLE 3.1 - Equilibrium Points
%% =========================================================
a_vals = [0, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26];

fprintf('=======================================================\n');
fprintf('Table 3.1: Equilibrium Points (k=%.2f, N=%d)\n', k, N);
fprintf('=======================================================\n');
fprintf('%-8s %-16s %-14s %-14s %-20s\n', ...
        'a', 'Discriminant D', 'P1 (stable)', 'P2 (unstable)', 'Status');
fprintf('%s\n', repmat('-', 1, 75));

for i = 1:length(a_vals)
    a  = a_vals(i);
    D  = N^2 - 4*(a*N/k);
    if D > 0
        P1 = (N + sqrt(D)) / 2;
        P2 = (N - sqrt(D)) / 2;
        status = 'Two equilibria';
    elseif D == 0
        P1 = N/2;
        P2 = N/2;
        status = 'MSY - saddle node';
    else
        P1 = NaN;
        P2 = NaN;
        status = 'Extinction';
    end

    if isnan(P1)
        fprintf('%-8.2f %-16.3f %-14s %-14s %-20s\n', ...
                a, D, '---', '---', status);
    else
        fprintf('%-8.2f %-16.3f %-14.4f %-14.4f %-20s\n', ...
                a, D, P1, P2, status);
    end
end
fprintf('%s\n', repmat('=', 1, 75));

%% =========================================================
%  FIGURE 3.1 - Equilibrium Map (P1 and P2 vs a)
%% =========================================================
a_sweep = linspace(0, MSY, 300);
P1_vals = nan(size(a_sweep));
P2_vals = nan(size(a_sweep));

for i = 1:length(a_sweep)
    D = N^2 - 4*(a_sweep(i)*N/k);
    if D >= 0
        P1_vals(i) = (N + sqrt(D)) / 2;
        P2_vals(i) = (N - sqrt(D)) / 2;
    end
end

figure(1);
set(gcf, 'Color', 'w', 'Position', [100 500 560 380]);
plot(a_sweep, P1_vals, 'b-', 'LineWidth', 2.5, 'DisplayName', 'P1 (stable)');
hold on;
plot(a_sweep, P2_vals, 'r-', 'LineWidth', 2.5, 'DisplayName', 'P2 (unstable)');
plot(MSY, N/2, 'kp', 'MarkerSize', 14, 'MarkerFaceColor', 'y', ...
     'DisplayName', sprintf('MSY = %.2f', MSY));
xlabel('Harvesting Rate  a', 'FontSize', 13);
ylabel('Equilibrium Population  P', 'FontSize', 13);
title('Equilibrium Map: P1 and P2 vs a', ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 11);
xlim([0 MSY*1.05]);
ylim([0 N*1.1]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 3.2 - Phase Portrait (dP/dt vs P)
%% =========================================================
a = 0.21;
D = N^2 - 4*(a*N/k);
P1 = (N + sqrt(D)) / 2;
P2 = (N - sqrt(D)) / 2;

P_range = linspace(0, N*1.2, 500);
dPdt    = k .* P_range .* (1 - P_range./N) - a;

figure(2);
set(gcf, 'Color', 'w', 'Position', [100 100 560 360]);
% shade growth region green
fill([P_range, fliplr(P_range)], ...
     [max(dPdt,0), zeros(1,500)], ...
     [0.85 0.96 0.88], 'EdgeColor', 'none');
hold on;
% shade decline region red
fill([P_range, fliplr(P_range)], ...
     [min(dPdt,0), zeros(1,500)], ...
     [0.98 0.88 0.86], 'EdgeColor', 'none');
plot(P_range, dPdt, 'b-', 'LineWidth', 2.2);
yline(0, '--k', 'LineWidth', 1.2);
xline(P1, '-g', 'LineWidth', 1.8, 'Label', sprintf('P1=%.2f (stable)', P1), ...
      'FontSize', 10, 'LabelVerticalAlignment', 'bottom');
xline(P2, '-r', 'LineWidth', 1.8, 'Label', sprintf('P2=%.2f (unstable)', P2), ...
      'FontSize', 10, 'LabelVerticalAlignment', 'bottom');
xlabel('Population  P', 'FontSize', 13);
ylabel('dP/dt', 'FontSize', 13);
title(sprintf('Phase Portrait  (a = %.2f)', a), ...
      'FontSize', 13, 'FontWeight', 'bold');
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 3.3 - Slope Field + Trajectories  a < MSY (a = 0.21)
%% =========================================================
a    = 0.21;
D    = N^2 - 4*(a*N/k);
P1   = (N + sqrt(D)) / 2;
P2   = (N - sqrt(D)) / 2;
tspan = [0 40];
ode  = @(t,P) k*P*(1 - P/N) - a;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

figure(3);
set(gcf, 'Color', 'w', 'Position', [680 500 620 420]);

% slope field
[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0)=1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
hold on;

% trajectories
ICs    = [0.5, 1.0, 1.5, 2.0, 2.5, 3.5, 4.5, 5.5];
colors = lines(length(ICs));
for i = 1:length(ICs)
    [tt, PP] = ode45(ode, tspan, ICs(i), opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0=%.1f', ICs(i)));
end

yline(P1, '--', 'Color', [0.05 0.50 0.25], 'LineWidth', 1.8, ...
      'Label', sprintf('P1=%.2f stable', P1), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');
yline(P2, '--r', 'LineWidth', 1.8, ...
      'Label', sprintf('P2=%.2f unstable', P2), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field & Trajectories  (a = %.2f < MSY)', a), ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim(tspan); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 3.4 - Slope Field + Trajectories  a = MSY (a = 0.25)
%% =========================================================
a   = 0.25;
P_star = N/2;
ode = @(t,P) k*P*(1 - P/N) - a;

figure(4);
set(gcf, 'Color', 'w', 'Position', [100 100 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0)=1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
hold on;

ICs    = [0.5, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0];
colors = lines(length(ICs));
for i = 1:length(ICs)
    [tt, PP] = ode45(ode, tspan, ICs(i), opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0=%.1f', ICs(i)));
end

yline(P_star, '--k', 'LineWidth', 2, ...
      'Label', sprintf('P* = %.2f  (MSY point)', P_star), ...
      'FontSize', 10, 'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf(' Slope Field & Trajectories  (a = %.2f = MSY)', a), ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim(tspan); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 3.5 - Slope Field + Trajectories  a > MSY (a = 0.26)
%% =========================================================
a   = 0.26;
ode = @(t,P) k*P*(1 - P/N) - a;

figure(5);
set(gcf, 'Color', 'w', 'Position', [680 100 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,140,30), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0)=1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
hold on;

ICs    = [0.5, 1.5, 2.5, 3.5, 4.5, 5.5];
colors = lines(length(ICs));
for i = 1:length(ICs)
    [tt, PP] = ode45(ode, [0 140], ICs(i));
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0=%.1f', ICs(i)));
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field & Trajectories  (a = %.2f > MSY) — Extinction', a), ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim([0 140]); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);