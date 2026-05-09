clc; clear; close all;

%% --- Base Parameters ---
k   = 0.20;
N   = 5;
a   = 0.21;
b   = 0.5;
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
% k_vals = [0.10, 0.20, 0.30, 0.40];

% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black

% traj_colors = {c1, c2, c3, c4};

% figure('Position',[100 100 1200 520], 'Color', 'white');

% % ── Subplot 1: Constant Harvesting ───────────────────────────────────
% subplot(1,2,1);
% hold on; grid on; box on;

% plotHandles1  = [];
% legendLabels1 = {};

% for i = 1:length(k_vals)
%     ki    = k_vals(i);
%     ode_c = @(t,P) ki*P*(1 - P/N) - a;
%     [tt, PP] = ode45(ode_c, [0 80], P0, opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles1(end+1)  = h;
%     legendLabels1{end+1} = sprintf('k = %.2f  (MSY = %.3f)', ki, ki*N/4);
% end

% % Equilibrium line
% h_n2 = yline(N/2, '--', 'Color', c6, 'LineWidth', 1.8);
% text(1, N/2 + N*0.03, 'N/2', ...
%      'FontSize', 10, 'FontName', 'Times New Roman', ...
%      'Color', c6, 'FontWeight', 'bold');

% xlabel('Time  t', 'FontSize', 13, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 13, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% title('Constant Harvesting', 'FontSize', 13, 'FontWeight', 'bold', ...
%       'FontName', 'Times New Roman');

% lgd1 = legend(plotHandles1, legendLabels1, ...
%               'Location', 'best', 'FontSize', 10, ...
%               'FontName', 'Times New Roman');
% lgd1.Box       = 'on';
% lgd1.EdgeColor = [0.2 0.2 0.2];
% lgd1.LineWidth = 1.2;
% lgd1.Color     = [0.97 0.97 0.97];

% ax1 = gca;
% ax1.FontSize      = 11;
% ax1.FontName      = 'Times New Roman';
% ax1.XColor        = 'k';
% ax1.YColor        = 'k';
% ax1.LineWidth     = 1.4;
% ax1.GridColor     = [0.5 0.5 0.5];
% ax1.GridAlpha     = 0.35;
% ax1.GridLineStyle = '--';
% ax1.TickDir       = 'out';
% ax1.TickLength    = [0.012 0.025];
% xlim([0 80]);
% ylim([0 N*1.2]);

% % ── Subplot 2: Periodic Harvesting ───────────────────────────────────
% subplot(1,2,2);
% hold on; grid on; box on;

% plotHandles2  = [];
% legendLabels2 = {};

% for i = 1:length(k_vals)
%     ki    = k_vals(i);
%     ode_p = @(t,P) ki*P*(1 - P/N) - a*(1 + sin(b*t));
%     [tt, PP] = ode45(ode_p, [0 80], P0, opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles2(end+1)  = h;
%     legendLabels2{end+1} = sprintf('k = %.2f  (MSY = %.3f)', ki, ki*N/4);
% end

% % Equilibrium line
% yline(N/2, '--', 'Color', c6, 'LineWidth', 1.8);
% text(1, N/2 + N*0.03, 'N/2', ...
%      'FontSize', 10, 'FontName', 'Times New Roman', ...
%      'Color', c6, 'FontWeight', 'bold');

% xlabel('Time  t', 'FontSize', 13, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 13, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% title('Periodic Harvesting', 'FontSize', 13, 'FontWeight', 'bold', ...
%       'FontName', 'Times New Roman');

% lgd2 = legend(plotHandles2, legendLabels2, ...
%               'Location', 'best', 'FontSize', 10, ...
%               'FontName', 'Times New Roman');
% lgd2.Box       = 'on';
% lgd2.EdgeColor = [0.2 0.2 0.2];
% lgd2.LineWidth = 1.2;
% lgd2.Color     = [0.97 0.97 0.97];

% ax2 = gca;
% ax2.FontSize      = 11;
% ax2.FontName      = 'Times New Roman';
% ax2.XColor        = 'k';
% ax2.YColor        = 'k';
% ax2.LineWidth     = 1.4;
% ax2.GridColor     = [0.5 0.5 0.5];
% ax2.GridAlpha     = 0.35;
% ax2.GridLineStyle = '--';
% ax2.TickDir       = 'out';
% ax2.TickLength    = [0.012 0.025];
% xlim([0 80]);
% ylim([0 N*1.2]);

% ── Super Title ───────────────────────────────────────────────────────

exportgraphics(gcf, 'fig_312.png', 'Resolution', 1200);


% exportgraphics(gcf, 'fig312.png', 'Resolution', 1200);

%% --- Table 5.1 - Effect of k: Constant vs Periodic ---
% fprintf('================================================================================\n');
% fprintf('Table 5.1 — Effect of k  (N=%.1f, a=%.2f)\n', N, a);
% fprintf('================================================================================\n');
% fprintf('%-6s %-10s | %-14s %-14s %-14s | %-14s\n', ...
%         'k', 'MSY', 'P1 (const)', 'P2 (const)', 'Status (const)', 'Status (periodic)');
% fprintf('%s\n', repmat('-',1,80));
% for i = 1:length(k_vals)
%     ki  = k_vals(i);
%     msy = ki*N/4;
%     Di  = N^2 - 4*(a*N/ki);

%     % constant status
%     if Di > 0
%         p1 = (N+sqrt(Di))/2;
%         p2 = (N-sqrt(Di))/2;
%         c_status = 'Sustainable';
%         p1_str   = sprintf('%.4f', p1);
%         p2_str   = sprintf('%.4f', p2);
%     else
%         c_status = 'Extinction';
%         p1_str   = '---';
%         p2_str   = '---';
%     end

%     % periodic status — run simulation and check mean
%     ode_p    = @(t,P) ki*P*(1-P/N) - a*(1+sin(b*t));
%     [tp, Pp] = ode45(ode_p, [0 100], P0, opts);
%     idx      = tp >= 80;
%     mean_P   = mean(Pp(idx));
%     if mean_P < 0.01
%         p_status = 'Extinction';
%     else
%         p_status = sprintf('Mean P=%.2f', mean_P);
%     end

%     fprintf('%-6.2f %-10.4f | %-14s %-14s %-14s | %-14s\n', ...
%             ki, msy, p1_str, p2_str, c_status, p_status);
% end
% fprintf('%s\n\n', repmat('=',1,80));

%% =========================================================
%  FIGURE 5.3 - Effect of varying N (2 subplots)
%% =========================================================
N_vals = [3, 5, 7, 10];

c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black

traj_colors = {c1, c2, c3, c4};

figure('Position',[100 100 1200 520], 'Color', 'white');

% ── Subplot 1: Constant Harvesting ───────────────────────────────────
subplot(1,2,1);
hold on; grid on; box on;

plotHandles1  = [];
legendLabels1 = {};

for i = 1:length(N_vals)
    Ni    = N_vals(i);
    ode_c = @(t,P) k*P*(1 - P/Ni) - a;
    [tt, PP] = ode45(ode_c, [0 80], P0, opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles1(end+1)  = h;
    legendLabels1{end+1} = sprintf('N = %d  (MSY = %.3f)', Ni, k*Ni/4);
end

xlabel('Time  t', 'FontSize', 13, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Population  P', 'FontSize', 13, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
title('Constant Harvesting', 'FontSize', 13, 'FontWeight', 'bold', ...
      'FontName', 'Times New Roman');

lgd1 = legend(plotHandles1, legendLabels1, ...
              'Location', 'best', 'FontSize', 10, ...
              'FontName', 'Times New Roman');
lgd1.Box       = 'on';
lgd1.EdgeColor = [0.2 0.2 0.2];
lgd1.LineWidth = 1.2;
lgd1.Color     = [0.97 0.97 0.97];

ax1 = gca;
ax1.FontSize      = 11;
ax1.FontName      = 'Times New Roman';
ax1.XColor        = 'k';
ax1.YColor        = 'k';
ax1.LineWidth     = 1.4;
ax1.GridColor     = [0.5 0.5 0.5];
ax1.GridAlpha     = 0.35;
ax1.GridLineStyle = '--';
ax1.TickDir       = 'out';
ax1.TickLength    = [0.012 0.025];
xlim([0 80]);
ylim([0 max(N_vals)*1.2]);

% ── Subplot 2: Periodic Harvesting ───────────────────────────────────
subplot(1,2,2);
hold on; grid on; box on;

plotHandles2  = [];
legendLabels2 = {};

for i = 1:length(N_vals)
    Ni    = N_vals(i);
    ode_p = @(t,P) k*P*(1 - P/Ni) - a*(1 + sin(b*t));
    [tt, PP] = ode45(ode_p, [0 80], P0, opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles2(end+1)  = h;
    legendLabels2{end+1} = sprintf('N = %d  (MSY = %.3f)', Ni, k*Ni/4);
end

xlabel('Time  t', 'FontSize', 13, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Population  P', 'FontSize', 13, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
title('Periodic Harvesting', 'FontSize', 13, 'FontWeight', 'bold', ...
      'FontName', 'Times New Roman');

lgd2 = legend(plotHandles2, legendLabels2, ...
              'Location', 'best', 'FontSize', 10, ...
              'FontName', 'Times New Roman');
lgd2.Box       = 'on';
lgd2.EdgeColor = [0.2 0.2 0.2];
lgd2.LineWidth = 1.2;
lgd2.Color     = [0.97 0.97 0.97];

ax2 = gca;
ax2.FontSize      = 11;
ax2.FontName      = 'Times New Roman';
ax2.XColor        = 'k';
ax2.YColor        = 'k';
ax2.LineWidth     = 1.4;
ax2.GridColor     = [0.5 0.5 0.5];
ax2.GridAlpha     = 0.35;
ax2.GridLineStyle = '--';
ax2.TickDir       = 'out';
ax2.TickLength    = [0.012 0.025];
xlim([0 80]);
ylim([0 max(N_vals)*1.2]);

exportgraphics(gcf, 'fig313.png', 'Resolution', 1200);

% % ── Table: Effect of N ────────────────────────────────────────────────
% fprintf('================================================================================\n');
% fprintf('Table 5.2 — Effect of N  (k = %.2f,  a = %.2f)\n', k, a);
% fprintf('================================================================================\n');
% fprintf('%-6s %-10s | %-14s %-14s %-14s | %-14s\n', ...
%         'N', 'MSY', 'P1 (const)', 'P2 (const)', 'Status (const)', 'Status (periodic)');
% fprintf('%s\n', repmat('-',1,80));

% for i = 1:length(N_vals)
%     Ni  = N_vals(i);
%     msy = k*Ni/4;
%     Di  = Ni^2 - 4*(a*Ni/k);

%     % Constant status
%     if Di > 0
%         p1       = (Ni + sqrt(Di)) / 2;
%         p2       = (Ni - sqrt(Di)) / 2;
%         c_status = 'Sustainable';
%         p1_str   = sprintf('%.4f', p1);
%         p2_str   = sprintf('%.4f', p2);
%     else
%         c_status = 'Extinction';
%         p1_str   = '---';
%         p2_str   = '---';
%     end

%     % Periodic status
%     ode_p    = @(t,P) k*P*(1 - P/Ni) - a*(1 + sin(b*t));
%     [tp, Pp] = ode45(ode_p, [0 100], P0, opts);
%     idx      = tp >= 80;
%     mean_P   = mean(Pp(idx));
%     if mean_P < 0.01
%         p_status = 'Extinction';
%     else
%         p_status = sprintf('Mean P = %.2f', mean_P);
%     end

%     fprintf('%-6d %-10.4f | %-14s %-14s %-14s | %-14s\n', ...
%             Ni, msy, p1_str, p2_str, c_status, p_status);
% end
% fprintf('%s\n', repmat('=',1,80));