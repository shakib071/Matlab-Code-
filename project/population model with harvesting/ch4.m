%% Chapter 4 - Periodic Harvesting: Plots
clc; clear; close all;

%% --- Parameters ---
k   = 0.20;
N   = 5;
a1  = 0.21;
a2  = 0.25;
b   = 1.0;
MSY = k*N/4;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

%% =========================================================
%  FIGURE 4.1 - Slope Field for a = a1 = 0.21
%% =========================================================
figure(1);
set(gcf, 'Color', 'w', 'Position', [100 500 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a1.*(1 + sin(b.*T_sf));
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field  Periodic Harvesting  (a = %.2f, b = %.1f)', a1, b), ...
      'FontSize', 13, 'FontWeight', 'bold');
xlim([0 40]); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 4.2 - Trajectories for a = a1 = 0.21
%% =========================================================
ode_a1 = @(t,P) k*P*(1 - P/N) - a1*(1 + sin(b*t));

figure(2);
set(gcf, 'Color', 'w', 'Position', [680 500 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a1.*(1 + sin(b.*T_sf));
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
hold on;

ICs    = [0.5, 1.0, 1.5, 2.5, 3.5, 4.5, 5.5];
colors = lines(length(ICs));
for i = 1:length(ICs)
    [tt, PP] = ode45(ode_a1, [0 40], ICs(i), opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0=%.1f', ICs(i)));
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Trajectories  Periodic Harvesting  (a = %.2f, b = %.1f)', a1, b), ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim([0 40]); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 4.3 - Slope Field for a = a2 = 0.25
%% =========================================================
figure(3);
set(gcf, 'Color', 'w', 'Position', [100 50 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a2.*(1 + sin(b.*T_sf));
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Slope Field  Periodic Harvesting  (a = %.2f, b = %.1f)', a2, b), ...
      'FontSize', 13, 'FontWeight', 'bold');
xlim([0 40]); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 4.4 - Trajectories for a = a2 = 0.25
%% =========================================================
ode_a2 = @(t,P) k*P*(1 - P/N) - a2*(1 + sin(b*t));

figure(4);
set(gcf, 'Color', 'w', 'Position', [680 50 620 420]);

[T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a2.*(1 + sin(b.*T_sf));
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
hold on;

ICs    = [0.5, 1.0, 1.5, 2.5, 3.5, 4.5, 5.5];
colors = lines(length(ICs));
for i = 1:length(ICs)
    [tt, PP] = ode45(ode_a2, [0 40], ICs(i), opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0=%.1f', ICs(i)));
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Trajectories  Periodic Harvesting  (a = %.2f, b = %.1f)', a2, b), ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 9);
xlim([0 40]); ylim([0 N*1.35]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  FIGURE 4.5 - Effect of b  (b = 0.5, 1, 2, 4)
%% =========================================================
b_vals = [0.5, 1.0, 2.0, 4.0];
P0     = 4.0;
a      = 0.21;

figure(5);
set(gcf, 'Color', 'w', 'Position', [350 250 700 500]);

colors_b = lines(length(b_vals));
for i = 1:length(b_vals)
    ode_b = @(t,P) k*P*(1 - P/N) - a*(1 + sin(b_vals(i)*t));
    [tt, PP] = ode45(ode_b, [0 60], P0, opts);
    plot(tt, PP, 'Color', colors_b(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('b = %.1f  (period = %.2f)', b_vals(i), 2*pi/b_vals(i)));
    hold on;
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf(' Effect of Frequency b  (k=%.2f, N=%d, a=%.2f, P0=%.1f)', ...
      k, N, a, P0), 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
xlim([0 60]); ylim([0 N*1.2]);
grid on; box on;
set(gca, 'FontSize', 11);

%% =========================================================
%  TABLE 4.1 - Effect of b on mean and min population
%% =========================================================
fprintf('=======================================================\n');
fprintf(' Effect of Frequency b on Population\n');
fprintf('(k=%.2f, N=%d, a=%.2f, P0=%.1f)\n', k, N, a, P0);
fprintf('=======================================================\n');
fprintf('%-8s %-12s %-14s %-14s %-14s\n', ...
        'b', 'Period', 'Mean P', 'Min P', 'Max P');
fprintf('%s\n', repmat('-', 1, 65));

for i = 1:length(b_vals)
    ode_b    = @(t,P) k*P*(1 - P/N) - a*(1 + sin(b_vals(i)*t));
    [tt, PP] = ode45(ode_b, [0 60], P0, opts);
    % use second half of simulation to avoid transient
    half     = round(length(tt)/2);
    PP_ss    = PP(half:end);
    fprintf('%-8.1f %-12.4f %-14.4f %-14.4f %-14.4f\n', ...
            b_vals(i), 2*pi/b_vals(i), mean(PP_ss), min(PP_ss), max(PP_ss));
end
fprintf('%s\n', repmat('=', 1, 65));

%% =========================================================
%  TABLE 4.2 - Comparison a1 vs a2 at steady state
%% =========================================================
fprintf('\n=======================================================\n');
fprintf('Comparison of a1 vs a2 (b=%.1f, P0=%.1f)\n', b, P0);
fprintf('=======================================================\n');
fprintf('%-8s %-14s %-14s %-14s\n', 'a', 'Mean P', 'Min P', 'Max P');
fprintf('%s\n', repmat('-', 1, 55));

for ai = [a1, a2]
    ode_ai   = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));
    [tt, PP] = ode45(ode_ai, [0 60], P0, opts);
    half     = round(length(tt)/2);
    PP_ss    = PP(half:end);
    fprintf('%-8.2f %-14.4f %-14.4f %-14.4f\n', ...
            ai, mean(PP_ss), min(PP_ss), max(PP_ss));
end
fprintf('%s\n', repmat('=', 1, 55));