clc; clear; close all;

%% --- Base Parameters ---
k   = 0.20;
N   = 5;
a   = 0.21;
b   = 1.0;
P0  = 4.0;
MSY = k*N/4;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

% equilibrium for base a
D  = N^2 - 4*(a*N/k);
P1 = (N + sqrt(D)) / 2;
P2 = (N - sqrt(D)) / 2;

%% =========================================================
%  FIGURE 5.2 - Effect of varying k (2 subplots)
%% =========================================================
k_vals = [0.10, 0.20, 0.30, 0.40];
colors = lines(length(k_vals));

figure(1);
set(gcf, 'Color', 'w', 'Position', [50 400 1000 400]);

% --- subplot 1: constant ---
subplot(1,2,1);
for i = 1:length(k_vals)
    ki    = k_vals(i);
    ode_c = @(t,P) ki*P*(1 - P/N) - a;
    [tt, PP] = ode45(ode_c, [0 80], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('k=%.2f (MSY=%.3f)', ki, ki*N/4));
    hold on;
end
yline(N/2, '--k', 'LineWidth', 1.2, 'Label', 'N/2', ...
      'FontSize', 9, 'LabelHorizontalAlignment', 'left');
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title('Constant Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 9);
xlim([0 80]); ylim([0 N*1.2]);
grid on; box on; set(gca, 'FontSize', 10);

% --- subplot 2: periodic ---
subplot(1,2,2);
for i = 1:length(k_vals)
    ki    = k_vals(i);
    ode_p = @(t,P) ki*P*(1 - P/N) - a*(1 + sin(b*t));
    [tt, PP] = ode45(ode_p, [0 80], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('k=%.2f (MSY=%.3f)', ki, ki*N/4));
    hold on;
end
yline(N/2, '--k', 'LineWidth', 1.2, 'Label', 'N/2', ...
      'FontSize', 9, 'LabelHorizontalAlignment', 'left');
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title('Periodic Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 9);
xlim([0 80]); ylim([0 N*1.2]);
grid on; box on; set(gca, 'FontSize', 10);

sgtitle(sprintf('Effect of Growth Rate k  (N=%d, a=%.2f, b=%.1f, P0=%.1f)', ...
        N, a, b, P0), 'FontSize', 12, 'FontWeight', 'bold');

%% --- Table 5.1 - Effect of k: Constant vs Periodic ---
fprintf('================================================================================\n');
fprintf('Table 5.1 — Effect of k  (N=%.1f, a=%.2f)\n', N, a);
fprintf('================================================================================\n');
fprintf('%-6s %-10s | %-14s %-14s %-14s | %-14s\n', ...
        'k', 'MSY', 'P1 (const)', 'P2 (const)', 'Status (const)', 'Status (periodic)');
fprintf('%s\n', repmat('-',1,80));
for i = 1:length(k_vals)
    ki  = k_vals(i);
    msy = ki*N/4;
    Di  = N^2 - 4*(a*N/ki);

    % constant status
    if Di > 0
        p1 = (N+sqrt(Di))/2;
        p2 = (N-sqrt(Di))/2;
        c_status = 'Sustainable';
        p1_str   = sprintf('%.4f', p1);
        p2_str   = sprintf('%.4f', p2);
    else
        c_status = 'Extinction';
        p1_str   = '---';
        p2_str   = '---';
    end

    % periodic status — run simulation and check mean
    ode_p    = @(t,P) ki*P*(1-P/N) - a*(1+sin(b*t));
    [tp, Pp] = ode45(ode_p, [0 100], P0, opts);
    idx      = tp >= 80;
    mean_P   = mean(Pp(idx));
    if mean_P < 0.01
        p_status = 'Extinction';
    else
        p_status = sprintf('Mean P=%.2f', mean_P);
    end

    fprintf('%-6.2f %-10.4f | %-14s %-14s %-14s | %-14s\n', ...
            ki, msy, p1_str, p2_str, c_status, p_status);
end
fprintf('%s\n\n', repmat('=',1,80));

%% =========================================================
%  FIGURE 5.3 - Effect of varying N (2 subplots)
%% =========================================================
N_vals = [3, 5, 7, 10];
colors = lines(length(N_vals));

figure(2);
set(gcf, 'Color', 'w', 'Position', [50 50 1000 400]);

% --- subplot 1: constant ---
subplot(1,2,1);
for i = 1:length(N_vals)
    Ni    = N_vals(i);
    ode_c = @(t,P) k*P*(1 - P/Ni) - a;
    [tt, PP] = ode45(ode_c, [0 80], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('N=%d (MSY=%.3f)', Ni, k*Ni/4));
    hold on;
end
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title('Constant Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 9);
xlim([0 80]); ylim([0 max(N_vals)*1.2]);
grid on; box on; set(gca, 'FontSize', 10);

% --- subplot 2: periodic ---
subplot(1,2,2);
for i = 1:length(N_vals)
    Ni    = N_vals(i);
    ode_p = @(t,P) k*P*(1 - P/Ni) - a*(1 + sin(b*t));
    [tt, PP] = ode45(ode_p, [0 80], P0, opts);
    plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 2, ...
         'DisplayName', sprintf('N=%d (MSY=%.3f)', Ni, k*Ni/4));
    hold on;
end
xlabel('Time  t', 'FontSize', 12);
ylabel('Population  P', 'FontSize', 12);
title('Periodic Harvesting', 'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'east', 'FontSize', 9);
xlim([0 80]); ylim([0 max(N_vals)*1.2]);
grid on; box on; set(gca, 'FontSize', 10);

sgtitle(sprintf('Effect of Carrying Capacity N  (k=%.2f, a=%.2f, b=%.1f, P0=%.1f)', ...
        k, a, b, P0), 'FontSize', 12, 'FontWeight', 'bold');

%% --- Table 5.2 - Effect of N: Constant vs Periodic ---
fprintf('================================================================================\n');
fprintf('Table 5.2 — Effect of N  (k=%.2f, a=%.2f)\n', k, a);
fprintf('================================================================================\n');
fprintf('%-6s %-10s | %-14s %-14s %-14s | %-14s\n', ...
        'N', 'MSY', 'P1 (const)', 'P2 (const)', 'Status (const)', 'Status (periodic)');
fprintf('%s\n', repmat('-',1,80));
for i = 1:length(N_vals)
    Ni  = N_vals(i);
    msy = k*Ni/4;
    Di  = Ni^2 - 4*(a*Ni/k);

    % constant status
    if Di > 0
        p1 = (Ni+sqrt(Di))/2;
        p2 = (Ni-sqrt(Di))/2;
        c_status = 'Sustainable';
        p1_str   = sprintf('%.4f', p1);
        p2_str   = sprintf('%.4f', p2);
    else
        c_status = 'Extinction';
        p1_str   = '---';
        p2_str   = '---';
    end

    % periodic status
    ode_p    = @(t,P) k*P*(1-P/Ni) - a*(1+sin(b*t));
    [tp, Pp] = ode45(ode_p, [0 100], P0, opts);
    idx      = tp >= 80;
    mean_P   = mean(Pp(idx));
    if mean_P < 0.01
        p_status = 'Extinction';
    else
        p_status = sprintf('Mean P=%.2f', mean_P);
    end

    fprintf('%-6d %-10.4f | %-14s %-14s %-14s | %-14s\n', ...
            Ni, msy, p1_str, p2_str, c_status, p_status);
end
fprintf('%s\n', repmat('=',1,80));