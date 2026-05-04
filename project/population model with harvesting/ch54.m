%% =========================================================
%  FIGURE 5.4 - Effect of Harvesting Rate a
%  Constant Harvesting (left) vs Periodic Harvesting (right)
%% =========================================================
clc; clear; close all;

k   = 0.20;
N   = 5;
P0  = 4.0;
b   = 1.0;
MSY = k*N/4;

opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

a_vals = [0.05, 0.10, 0.15, 0.21, 0.25, 0.30];
colors = lines(length(a_vals));

figure(1);
set(gcf, 'Color', 'w', 'Position', [100 100 1200 450]);

%% --- Left: Constant Harvesting ---
subplot(1,2,1);
for i = 1:length(a_vals)
    ai    = a_vals(i);
    ode_c = @(t,P) k*P*(1 - P/N) - ai;
    [tt, PP] = ode45(ode_c, [0 100], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('a=%.2f (MSY=%.3f)', ai, MSY));
    hold on;
end

yline(N/2, '--k', 'LineWidth', 1.5, ...
      'Label', 'N/2 = 2.5', 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title('Constant Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 10);
xlim([0 100]); ylim([0 N*1.2]);
grid on; box on;
set(gca, 'FontSize', 11);

%% --- Right: Periodic Harvesting ---
subplot(1,2,2);
for i = 1:length(a_vals)
    ai    = a_vals(i);
    ode_p = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));
    [tt, PP] = ode45(ode_p, [0 100], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('a=%.2f (MSY=%.3f)', ai, MSY));
    hold on;
end

yline(N/2, '--k', 'LineWidth', 1.5, ...
      'Label', 'N/2 = 2.5', 'FontSize', 10, ...
      'LabelHorizontalAlignment', 'left');

xlabel('Time  t', 'FontSize', 13);
ylabel('Population  P', 'FontSize', 13);
title('Periodic Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 10);
xlim([0 100]); ylim([0 N*1.2]);
grid on; box on;
set(gca, 'FontSize', 11);

%% --- Super title ---
sgtitle(sprintf('Effect of Harvesting Rate a  (k=%.2f, N=%d, b=%.1f, P0=%.1f)', ...
        k, N, b, P0), 'FontSize', 13, 'FontWeight', 'bold');