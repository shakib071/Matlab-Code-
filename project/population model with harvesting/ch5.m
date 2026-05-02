clc; clear; close all;

%% --- Base Parameters ---
k   = 0.20;
N   = 5;
a   = 0.21;
b   = 1.0;
P0  = 4.0;
MSY = k*N/4;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

%% =========================================================
%  FIGURE 5.1 - Constant vs Periodic Same Plot
%% =========================================================
ode_const    = @(t,P) k*P*(1 - P/N) - a;
ode_periodic = @(t,P) k*P*(1 - P/N) - a*(1 + sin(b*t));

[t_c, P_c] = ode45(ode_const,    [0 60], P0, opts);
[t_p, P_p] = ode45(ode_periodic, [0 60], P0, opts);

D  = N^2 - 4*(a*N/k);
P1 = (N + sqrt(D)) / 2;
P2 = (N - sqrt(D)) / 2;

figure(1);
set(gcf, 'Color', 'w', 'Position', [100 500 700 420]);

plot(t_c, P_c, 'b-', 'LineWidth', 2.2, 'DisplayName', 'Constant Harvesting');
hold on;
plot(t_p, P_p, 'r-', 'LineWidth', 2.2, 'DisplayName', 'Periodic Harvesting');
yline(P1, '--g', 'LineWidth', 1.5, ...
      'Label', sprintf('P1 = %.2f (stable)', P1), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');
yline(P2, '--r', 'LineWidth', 1.5, ...
      'Label', sprintf('P2 = %.2f (unstable)', P2), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Constant vs Periodic Harvesting  (k=%.2f, N=%d, a=%.2f, b=%.1f, P0=%.1f)', ...
      k, N, a, b, P0), 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
xlim([0 60]); ylim([0 N*1.2]);
grid on; box on;
set(gca, 'FontSize', 11);

% sgtitle(sprintf('Constant vs Periodic  (k=%.2f, N=%d, a=%.2f, b=%.1f, P0=%.1f)', ...
%         k, N, a, b, P0), 'FontSize', 12, 'FontWeight', 'bold');

%% =========================================================
%  FIGURE 5.2 - Effect of varying k
%% =========================================================
k_vals = [0.10, 0.20, 0.30, 0.40];
colors = lines(length(k_vals));

figure(2);
set(gcf, 'Color', 'w', 'Position', [100 50 700 420]);

for i = 1:length(k_vals)
    ki   = k_vals(i);
    ode_k = @(t,P) ki*P*(1 - P/N) - a;
    [tt, PP] = ode45(ode_k, [0 60], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('k = %.2f  (MSY=%.3f)', ki, ki*N/4));
    hold on;
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Effect of Growth Rate k  (N=%d, a=%.2f, P0=%.1f)', ...
      N, a, P0), 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 11);
xlim([0 60]); ylim([0 N*1.2]);
grid on; box on; set(gca, 'FontSize', 11);

%% --- Table 5.1 - Effect of k ---
fprintf('=======================================================\n');
fprintf('Effect of k  (N=%.1f, a=%.2f)\n', N, a);
fprintf('=======================================================\n');
fprintf('%-8s %-12s %-14s %-14s %-15s\n', ...
        'k', 'MSY=kN/4', 'P1', 'P2', 'Status');
fprintf('%s\n', repmat('-',1,65));
for i = 1:length(k_vals)
    ki  = k_vals(i);
    msy = ki*N/4;
    D   = N^2 - 4*(a*N/ki);
    if D > 0
        p1 = (N+sqrt(D))/2; p2 = (N-sqrt(D))/2;
        fprintf('%-8.2f %-12.4f %-14.4f %-14.4f %-15s\n', ki, msy, p1, p2, 'Two equilibria');
    else
        fprintf('%-8.2f %-12.4f %-14s %-14s %-15s\n', ki, msy, '---', '---', 'Extinction');
    end
end
fprintf('%s\n', repmat('=',1,65));

%% =========================================================
%  FIGURE 5.3 - Effect of varying N
%% =========================================================
N_vals = [3, 5, 7, 10];
colors = lines(length(N_vals));

figure(3);
set(gcf, 'Color', 'w', 'Position', [680 500 700 420]);

for i = 1:length(N_vals)
    Ni   = N_vals(i);
    ode_N = @(t,P) k*P*(1 - P/Ni) - a;
    [tt, PP] = ode45(ode_N, [0 60], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('N = %d  (MSY=%.3f)', Ni, k*Ni/4));
    hold on;
end

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Effect of Carrying Capacity N  (k=%.2f, a=%.2f, P0=%.1f)', ...
      k, a, P0), 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'best', 'FontSize', 11);
xlim([0 60]); ylim([0 max(N_vals)*1.2]);
grid on; box on; set(gca, 'FontSize', 11);

%% --- Table 5.2 - Effect of N ---
fprintf('\n=======================================================\n');
fprintf('Effect of N  (k=%.2f, a=%.2f)\n', k, a);
fprintf('=======================================================\n');
fprintf('%-8s %-12s %-14s %-14s %-15s\n', ...
        'N', 'MSY=kN/4', 'P1', 'P2', 'Status');
fprintf('%s\n', repmat('-',1,65));
for i = 1:length(N_vals)
    Ni  = N_vals(i);
    msy = k*Ni/4;
    D   = Ni^2 - 4*(a*Ni/k);
    if D > 0
        p1 = (Ni+sqrt(D))/2; p2 = (Ni-sqrt(D))/2;
        fprintf('%-8d %-12.4f %-14.4f %-14.4f %-15s\n', Ni, msy, p1, p2, 'Two equilibria');
    else
        fprintf('%-8d %-12.4f %-14s %-14s %-15s\n', Ni, msy, '---', '---', 'Extinction');
    end
end
fprintf('%s\n', repmat('=',1,65));

%% =========================================================
%  FIGURE 5.4 - Extinction Threshold Curve (final P vs a)
%% =========================================================
a_sweep   = linspace(0, 0.32, 120);
P_final_c = nan(size(a_sweep));
P_final_p = nan(size(a_sweep));

for i = 1:length(a_sweep)
    ai = a_sweep(i);
    try
        [~, Pc] = ode45(@(t,P) k*P*(1-P/N) - ai, [0 60], P0, opts);
        P_final_c(i) = max(Pc(end), 0);
    catch
    end
    try
        [~, Pp] = ode45(@(t,P) k*P*(1-P/N) - ai*(1+sin(b*t)), [0 60], P0, opts);
        P_final_p(i) = max(Pp(end), 0);
    catch
    end
end

figure(4);
set(gcf, 'Color', 'w', 'Position', [680 50 700 420]);
plot(a_sweep, P_final_c, 'b-', 'LineWidth', 2.2, 'DisplayName', 'Constant harvesting');
hold on;
plot(a_sweep, P_final_p, 'r-', 'LineWidth', 2.2, 'DisplayName', 'Periodic harvesting');
xline(MSY, '--k', 'LineWidth', 1.5, ...
      'Label', sprintf('MSY = %.2f', MSY), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');
xlabel('Harvesting Rate  a', 'FontSize', 13);
ylabel(sprintf('Final Population at t = 60'), 'FontSize', 13);
title(' Extinction Threshold Curve', ...
      'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
ylim([0 N*1.1]); xlim([0 0.32]);
grid on; box on; set(gca, 'FontSize', 11);

%% =========================================================
%  Effect of Initial Condition P0
%% =========================================================
P0_vals = [0.3, 0.8, 1.2, 1.4, 1.6, 2.0, 3.0, 4.0, 5.0];
colors  = lines(length(P0_vals));

figure(5);
set(gcf, 'Color', 'w', 'Position', [400 250 700 450]);

for i = 1:length(P0_vals)
    [tt, PP] = ode45(ode_const, [0 60], P0_vals(i), opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('P0 = %.1f', P0_vals(i)));
    hold on;
end

yline(P1, '--g', 'LineWidth', 2, ...
      'Label', sprintf('P1 = %.2f  stable', P1), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');
yline(P2, '--r', 'LineWidth', 2, ...
      'Label', sprintf('P2 = %.2f  unstable threshold', P2), 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title(sprintf('Effect of Initial Condition P0  (k=%.2f, N=%d, a=%.2f)', ...
      k, N, a), 'FontSize', 13, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 9);
xlim([0 60]); ylim([0 N*1.2]);
grid on; box on; set(gca, 'FontSize', 11);

%% =========================================================
%  TABLE 5.3 - Sensitivity Summary
%% =========================================================
fprintf('\n=======================================================\n');
fprintf('Sensitivity Summary\n');
fprintf('=======================================================\n');
fprintf('%-12s %-20s %-20s %-20s\n', 'Parameter', 'Effect on MSY', 'Effect on P1', 'Effect on P2');
fprintf('%s\n', repmat('-',1,75));
fprintf('%-12s %-20s %-20s %-20s\n', 'k increases', 'MSY increases', 'P1 increases', 'P2 decreases');
fprintf('%-12s %-20s %-20s %-20s\n', 'N increases', 'MSY increases', 'P1 increases', 'P2 decreases');
fprintf('%-12s %-20s %-20s %-20s\n', 'a increases', 'No effect',    'P1 decreases', 'P2 increases');
fprintf('%-12s %-20s %-20s %-20s\n', 'b increases', 'No effect',    'No fixed P1',  'No fixed P2');
fprintf('%-12s %-20s %-20s %-20s\n', 'P0 changes',  'No effect',    'No effect',    'No effect');
fprintf('%s\n', repmat('=',1,75));

%% --- Table 5.4 - Parameter Ranking ---
fprintf('\n=======================================================\n');
fprintf('Parameter Ranking by Impact\n');
fprintf('=======================================================\n');
fprintf('%-8s %-15s %-40s\n', 'Rank', 'Parameter', 'Reason');
fprintf('%s\n', repmat('-',1,65));
fprintf('%-8d %-15s %-40s\n', 1, 'a', 'Directly controls existence of equilibria');
fprintf('%-8d %-15s %-40s\n', 2, 'k', 'Determines MSY — affects species survival');
fprintf('%-8d %-15s %-40s\n', 3, 'N', 'Determines MSY — habitat loss is critical');
fprintf('%-8d %-15s %-40s\n', 4, 'P0', 'Determines basin of attraction');
fprintf('%-8d %-15s %-40s\n', 5, 'b', 'Affects oscillation amplitude only');
fprintf('%s\n', repmat('=',1,65));