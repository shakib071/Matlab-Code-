%% =========================================================
%  FIGURE 5.4 - Effect of Harvesting Rate a
%  Constant Harvesting (left) vs Periodic Harvesting (right)
%% =========================================================
k   = 0.20;
N   = 5;
P0  = 4.0;
b   = 0.5;
MSY = k*N/4;

opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

a_vals = [0.05, 0.10, 0.15, 0.21, 0.25, 0.30];

c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black
c7 = [0.00 0.75 0.80];   % cyan
c8 = [0.90 0.10 0.60];   % magenta

traj_colors = {c1, c2, c3, c4, c5, c7};

figure('Position',[100 100 1200 520], 'Color', 'white');

% ── Subplot 1: Constant Harvesting ───────────────────────────────────
subplot(1,2,1);
hold on; grid on; box on;

plotHandles1  = [];
legendLabels1 = {};

for i = 1:length(a_vals)
    ai    = a_vals(i);
    ode_c = @(t,P) k*P*(1 - P/N) - ai;
    [tt, PP] = ode45(ode_c, [0 100], P0, opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles1(end+1)  = h;
    legendLabels1{end+1} = sprintf('a = %.2f  (MSY = %.3f)', ai, MSY);
end

% Equilibrium line
yline(N/2, '--', 'Color', c6, 'LineWidth', 1.8);
text(1, N/2 + N*0.03, 'N/2 = 2.5', ...
     'FontSize', 10, 'FontName', 'Times New Roman', ...
     'Color', c6, 'FontWeight', 'bold');

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
xlim([0 100]);
ylim([0 N*1.2]);

% ── Subplot 2: Periodic Harvesting ───────────────────────────────────
subplot(1,2,2);
hold on; grid on; box on;

plotHandles2  = [];
legendLabels2 = {};

for i = 1:length(a_vals)
    ai    = a_vals(i);
    ode_p = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));
    [tt, PP] = ode45(ode_p, [0 100], P0, opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles2(end+1)  = h;
    legendLabels2{end+1} = sprintf('a = %.2f  (MSY = %.3f)', ai, MSY);
end

% Equilibrium line
yline(N/2, '--', 'Color', c6, 'LineWidth', 1.8);
text(1, N/2 + N*0.03, 'N/2 = 2.5', ...
     'FontSize', 10, 'FontName', 'Times New Roman', ...
     'Color', c6, 'FontWeight', 'bold');

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
xlim([0 100]);
ylim([0 N*1.2]);


exportgraphics(gcf, 'fig314.png', 'Resolution', 1200);