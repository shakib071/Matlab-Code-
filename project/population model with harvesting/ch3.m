%% Chapter 3 - Constant Harvesting: Table and Plots
clc; clear; close all;

%% --- Parameters ---
k  = 0.20;
N  = 5;
MSY = k*N/4;

%% =========================================================
%  TABLE 3.1 - Equilibrium Points
%% =========================================================
% a_vals = [0, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26];

% fprintf('=======================================================\n');
% fprintf('Table 3.1: Equilibrium Points (k=%.2f, N=%d)\n', k, N);
% fprintf('=======================================================\n');
% fprintf('%-8s %-16s %-14s %-14s %-20s\n', ...
%         'a', 'Discriminant D', 'P1 (stable)', 'P2 (unstable)', 'Status');
% fprintf('%s\n', repmat('-', 1, 75));

% for i = 1:length(a_vals)
%     a  = a_vals(i);
%     D  = N^2 - 4*(a*N/k);
%     if D > 0
%         P1 = (N + sqrt(D)) / 2;
%         P2 = (N - sqrt(D)) / 2;
%         status = 'Two equilibria';
%     elseif D == 0
%         P1 = N/2;
%         P2 = N/2;
%         status = 'MSY - saddle node';
%     else
%         P1 = NaN;
%         P2 = NaN;
%         status = 'Extinction';
%     end

%     if isnan(P1)
%         fprintf('%-8.2f %-16.3f %-14s %-14s %-20s\n', ...
%                 a, D, '---', '---', status);
%     else
%         fprintf('%-8.2f %-16.3f %-14.4f %-14.4f %-20s\n', ...
%                 a, D, P1, P2, status);
%     end
% end
% fprintf('%s\n', repmat('=', 1, 75));

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

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed

% p1=plot(a_sweep, P1_vals, '-','Color', c1 , 'LineWidth', 2.8);
% hold on;
% p2=plot(a_sweep, P2_vals, '-','Color', c2 , 'LineWidth', 2.8);
% p3=plot(MSY, N/2, 'p','Color', c6 , 'MarkerSize', 20, 'MarkerFaceColor', 'y', ...
%      'DisplayName', sprintf('MSY = %.2f', MSY));
% xlabel('Harvesting Rate  a', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Equilibrium Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );

% lgd = legend([p1 p2 p3],'P1 (stable)','P2 (unstable)',sprintf('MSY = %.2f', MSY),'Location','best', 'FontSize', 12, ...
%     'FontName', 'Times New Roman');
% lgd.Box       = 'on';
% lgd.EdgeColor = [0.2 0.2 0.2];
% lgd.LineWidth = 1.2;
% lgd.Color     = [0.97 0.97 0.97];

% % Axis styling
% ax = gca;
% ax.FontSize   = 12;
% ax.FontName   = 'Times New Roman';
% ax.XColor     = 'k';
% ax.YColor     = 'k';
% ax.LineWidth  = 1.4;
% ax.GridColor  = [0.5 0.5 0.5];
% ax.GridAlpha  = 0.35;
% ax.GridLineStyle = '--';
% ax.TickDir    = 'out';
% ax.TickLength = [0.012 0.025];
% ax.Position = [0.15 0.13 0.78 0.78];
% xlim([0 MSY*1.1]); ylim([0 N*1.1]);

% exportgraphics(gcf, 'fig31.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 3.2 - Phase Portrait (dP/dt vs P)
%% =========================================================
a = 0.21;
D = N^2 - 4*(a*N/k);
P1 = (N + sqrt(D)) / 2;
P2 = (N - sqrt(D)) / 2;

P_range = linspace(0, N*1.2, 500);
dPdt    = k .* P_range .* (1 - P_range./N) - a;

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed
% % shade growth region green
% fill([P_range, fliplr(P_range)], ...
%      [max(dPdt,0), zeros(1,500)], ...
%      [0.85 0.96 0.88], 'EdgeColor', 'none');
% hold on;
% % shade decline region red
% fill([P_range, fliplr(P_range)], ...
%      [min(dPdt,0), zeros(1,500)], ...
%      [0.98 0.88 0.86], 'EdgeColor', 'none');
% plot(P_range, dPdt,  '-',  'Color', c1, 'LineWidth', 2.8);
% yline(0, '--', 'Color', c4, 'LineWidth', 2.0, 'Alpha', 1.0);
% xline(P1, '--', 'Color', c4, 'LineWidth', 2.0, 'Label', sprintf('P1=%.2f (stable)', P1), ...
%       'FontSize', 14, 'LabelVerticalAlignment', 'bottom');
% xline(P2, '--', 'Color', c5, 'LineWidth', 2.0, 'Label', sprintf('P2=%.2f (unstable)', P2), ...
%       'FontSize', 14, 'LabelVerticalAlignment', 'bottom');
% xlabel('Population  P','FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% ylabel('dP/dt', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );



% ax = gca;
% ax.FontSize   = 13;
% ax.FontName   = 'Times New Roman';
% ax.XColor     = 'k';
% ax.YColor     = 'k';
% ax.LineWidth  = 1.4;
% ax.GridColor  = [0.5 0.5 0.5];
% ax.GridAlpha  = 0.35;
% ax.GridLineStyle = '--';
% ax.TickDir    = 'out';
% ax.TickLength = [0.012 0.025];
% exportgraphics(gcf, 'fig32.png', 'Resolution', 1200);
%% =========================================================
%  FIGURE 3.3 - Slope Field + Trajectories  a < MSY (a = 0.21)
%% =========================================================
% a    = 0.21;
% D    = N^2 - 4*(a*N/k);
% P1   = (N + sqrt(D)) / 2;
% P2   = (N - sqrt(D)) / 2;
% tspan = [0 40];
% ode  = @(t,P) k*P*(1 - P/N) - a;
% opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed

% % slope field
% [T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2); mag(mag==0)=1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);
% hold on;

% % trajectories
% ICs    = [0.5, 1.0, 1.5, 2.0, 2.5, 3.5, 4.5, 5.5];
% colors = lines(length(ICs));
% for i = 1:length(ICs)
%     [tt, PP] = ode45(ode, tspan, ICs(i), opts);
%     plot(tt, PP, 'Color', colors(i,:), 'LineWidth', 1.8, ...
%          'DisplayName', sprintf('P0=%.1f', ICs(i)));
% end

% yline(P1, '--', 'Color', [0.05 0.50 0.25], 'LineWidth', 1.8, ...
%       'Label', sprintf('P1=%.2f stable', P1), 'FontSize', 10, ...
%       'LabelHorizontalAlignment', 'left');
% yline(P2, '--r', 'LineWidth', 1.8, ...
%       'Label', sprintf('P2=%.2f unstable', P2), 'FontSize', 10, ...
%       'LabelHorizontalAlignment', 'left');

% xlabel('Time  t', 'FontSize', 13);
% ylabel('Population  P', 'FontSize', 13);
% legend('Location', 'northeast', 'FontSize', 9);
% legend('show')
% legend('NumColumns', 2)
% xlim(tspan); ylim([0 N*1.35]);
% grid on; box on;
% set(gca, 'FontSize', 11);

a    = 0.21;
D    = N^2 - 4*(a*N/k);
P1   = (N + sqrt(D)) / 2;
P2   = (N - sqrt(D)) / 2;
tspan = [0 40];
ode_fun = @(t,P) k*P*(1 - P/N) - a;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;

% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black

% % ── Slope Field ───────────────────────────────────────────────────────
% [T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% % ── Trajectories ──────────────────────────────────────────────────────
% ICs    = [0.5, 1.0, 1.5, 2.0, 2.5, 3.5, 4.5, 5.5];
% traj_colors = {c1, c2, c3, c4, c5, ...
%                [0.00 0.75 0.80], ...   % cyan
%                [0.90 0.10 0.60], ...   % magenta
%                [0.50 0.30 0.10]};      % brown

% plotHandles = [];
% legendLabels = {};

% for i = 1:length(ICs)
%     [tt, PP] = ode45(ode_fun, tspan, ICs(i), opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles  = [plotHandles h];
%     legendLabels{end+1} = sprintf('P_0 = %.1f', ICs(i));
% end

% % ── Equilibrium Lines ─────────────────────────────────────────────────
% h_P1 = yline(P1, '--', 'Color', [0.05 0.50 0.25], 'LineWidth', 2.0);
% h_P2 = yline(P2, '--', 'Color', c1,               'LineWidth', 2.0);

% % ── Labels on Equilibrium Lines ───────────────────────────────────────
% text(1, P1 + N*0.04, sprintf('P_1 = %.2f  (stable)',   P1), ...
%      'FontSize', 11, 'FontName', 'Times New Roman', ...
%      'Color', [0.05 0.50 0.25], 'FontWeight', 'bold');

% text(1, P2 + N*0.04, sprintf('P_2 = %.2f  (unstable)', P2), ...
%      'FontSize', 11, 'FontName', 'Times New Roman', ...
%      'Color', c1, 'FontWeight', 'bold');

% % ── Axis Labels ───────────────────────────────────────────────────────
% xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');

% % ── Legend ────────────────────────────────────────────────────────────
% lgd = legend(plotHandles, legendLabels, ...
%              'Location', 'northeast', 'FontSize', 11, ...
%              'FontName', 'Times New Roman', 'NumColumns', 2);
% lgd.Box       = 'on';
% lgd.EdgeColor = [0.2 0.2 0.2];
% lgd.LineWidth = 1.2;
% lgd.Color     = [0.97 0.97 0.97];

% % ── Axis Styling ──────────────────────────────────────────────────────
% ax = gca;
% ax.FontSize      = 12;
% ax.FontName      = 'Times New Roman';
% ax.XColor        = 'k';
% ax.YColor        = 'k';
% ax.LineWidth     = 1.4;
% ax.GridColor     = [0.5 0.5 0.5];
% ax.GridAlpha     = 0.35;
% ax.GridLineStyle = '--';
% ax.TickDir       = 'out';
% ax.TickLength    = [0.012 0.025];
% ax.Position      = [0.15 0.13 0.78 0.78];

% xlim(tspan);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig33.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 3.4 - Slope Field + Trajectories  a = MSY (a = 0.25)
%% =========================================================
a      = 0.25;
P_star = N/2;
ode_fun = @(t,P) k*P*(1 - P/N) - a;

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;

% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black

% % ── Slope Field ───────────────────────────────────────────────────────
% [T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% % ── Trajectories ──────────────────────────────────────────────────────
% ICs = [0.5, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0];
% traj_colors = {c1, c2, c3, c4, c5, ...
%                [0.00 0.75 0.80], ...   % cyan
%                [0.90 0.10 0.60]};      % magenta

% plotHandles  = [];
% legendLabels = {};

% for i = 1:length(ICs)
%     [tt, PP] = ode45(ode_fun, tspan, ICs(i), opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles(end+1)  = h;
%     legendLabels{end+1} = sprintf('P_0 = %.1f', ICs(i));
% end

% % ── MSY Equilibrium Line ──────────────────────────────────────────────
% h_msy = yline(P_star, '--', 'Color', c6, 'LineWidth', 2.2);

% % ── MSY Label ─────────────────────────────────────────────────────────
% text(1, P_star + N*0.04, ...
%      sprintf('P* = %.2f  (MSY point)', P_star), ...
%      'FontSize', 11, 'FontName', 'Times New Roman', ...
%      'Color', c6, 'FontWeight', 'bold');

% % ── Axis Labels ───────────────────────────────────────────────────────
% xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');

% % ── Legend ────────────────────────────────────────────────────────────
% lgd = legend(plotHandles, legendLabels, ...
%              'Location', 'northeast', 'FontSize', 11, ...
%              'FontName', 'Times New Roman', 'NumColumns', 2);
% lgd.Box       = 'on';
% lgd.EdgeColor = [0.2 0.2 0.2];
% lgd.LineWidth = 1.2;
% lgd.Color     = [0.97 0.97 0.97];

% % ── Axis Styling ──────────────────────────────────────────────────────
% ax = gca;
% ax.FontSize      = 12;
% ax.FontName      = 'Times New Roman';
% ax.XColor        = 'k';
% ax.YColor        = 'k';
% ax.LineWidth     = 1.4;
% ax.GridColor     = [0.5 0.5 0.5];
% ax.GridAlpha     = 0.35;
% ax.GridLineStyle = '--';
% ax.TickDir       = 'out';
% ax.TickLength    = [0.012 0.025];
% ax.Position      = [0.15 0.13 0.78 0.78];

% xlim(tspan);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig34.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 3.5 - Slope Field + Trajectories  a > MSY (a = 0.26)
%% =========================================================
a       = 0.26;
ode_fun = @(t,P) k*P*(1 - P/N) - a;

figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;

c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black

% ── Slope Field ───────────────────────────────────────────────────────
[T_sf, P_sf] = meshgrid(linspace(0,140,30), linspace(0,N*1.3,18));
dP_sf = k.*P_sf.*(1 - P_sf./N) - a;
dT_sf = ones(size(dP_sf));
mag   = sqrt(dT_sf.^2 + dP_sf.^2);
mag(mag==0) = 1;
quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
       'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% ── Trajectories ──────────────────────────────────────────────────────
ICs = [0.5, 1.5, 2.5, 3.5, 4.5, 5.5];
traj_colors = {c1, c2, c3, c4, c5, ...
               [0.00 0.75 0.80]};      % cyan

plotHandles  = [];
legendLabels = {};

for i = 1:length(ICs)
    [tt, PP] = ode45(ode_fun, [0 140], ICs(i), opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles(end+1)  = h;
    legendLabels{end+1} = sprintf('P_0 = %.1f', ICs(i));
end



% ── Axis Labels ───────────────────────────────────────────────────────
xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');

% ── Legend ────────────────────────────────────────────────────────────
lgd = legend(plotHandles, legendLabels, ...
             'Location', 'northeast', 'FontSize', 11, ...
             'FontName', 'Times New Roman', 'NumColumns', 2);
lgd.Box       = 'on';
lgd.EdgeColor = [0.2 0.2 0.2];
lgd.LineWidth = 1.2;
lgd.Color     = [0.97 0.97 0.97];

% ── Axis Styling ──────────────────────────────────────────────────────
ax = gca;
ax.FontSize      = 12;
ax.FontName      = 'Times New Roman';
ax.XColor        = 'k';
ax.YColor        = 'k';
ax.LineWidth     = 1.4;
ax.GridColor     = [0.5 0.5 0.5];
ax.GridAlpha     = 0.35;
ax.GridLineStyle = '--';
ax.TickDir       = 'out';
ax.TickLength    = [0.012 0.025];
ax.Position      = [0.15 0.13 0.78 0.78];

xlim([0 140]);
ylim([0 N*1.35]);

exportgraphics(gcf, 'fig35.png', 'Resolution', 1200);