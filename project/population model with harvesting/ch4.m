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
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a1.*(1 + sin(b.*T_sf));
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% % ── Slope Field Label ─────────────────────────────────────────────────
% % text(1, N*1.22, ...
% %      sprintf('Periodic Harvesting  —  a = %.2f,  b = %.1f', a1, b), ...
% %      'FontSize', 12, 'FontName', 'Times New Roman', ...
% %      'Color', c6, 'FontWeight', 'bold');

% % ── Axis Labels ───────────────────────────────────────────────────────
% xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');

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

% xlim([0 40]);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig36.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 4.2 - Trajectories for a = a1 = 0.21
%% =========================================================
% ode_a1 = @(t,P) k*P*(1 - P/N) - a1*(1 + sin(b*t));

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
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a1.*(1 + sin(b.*T_sf));
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% % ── Trajectories ──────────────────────────────────────────────────────
% ICs = [0.5, 1.0, 1.5, 2.5, 3.5, 4.5, 5.5];
% traj_colors = {c1, c2, c3, c4, c5, ...
%                [0.00 0.75 0.80], ...   % cyan
%                [0.90 0.10 0.60]};      % magenta

% plotHandles  = [];
% legendLabels = {};

% for i = 1:length(ICs)
%     [tt, PP] = ode45(ode_a1, [0 40], ICs(i), opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles(end+1)  = h;
%     legendLabels{end+1} = sprintf('P_0 = %.1f', ICs(i));
% end



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

% xlim([0 40]);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig37.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 4.3 - Slope Field for a = a2 = 0.25
%% =========================================================
figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;

c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black

% ── Slope Field ───────────────────────────────────────────────────────
% [T_sf, P_sf] = meshgrid(linspace(0,40,22), linspace(0,N*1.3,18));
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a2.*(1 + sin(b.*T_sf));
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);


% % ── Axis Labels ───────────────────────────────────────────────────────
% xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');

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

% xlim([0 40]);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig38.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 4.4 - Trajectories for a = a2 = 0.25
%% =========================================================
% ode_a2 = @(t,P) k*P*(1 - P/N) - a2*(1 + sin(b*t));

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
% dP_sf = k.*P_sf.*(1 - P_sf./N) - a2.*(1 + sin(b.*T_sf));
% dT_sf = ones(size(dP_sf));
% mag   = sqrt(dT_sf.^2 + dP_sf.^2);
% mag(mag==0) = 1;
% quiver(T_sf, P_sf, dT_sf./mag, dP_sf./mag, 0.5, ...
%        'Color', [0.75 0.75 0.75], 'LineWidth', 0.7);

% % ── Trajectories ──────────────────────────────────────────────────────
% ICs = [0.5, 1.0, 1.5, 2.5, 3.5, 4.5, 5.5];
% traj_colors = {c1, c2, c3, c4, c5, ...
%                [0.00 0.75 0.80], ...   % cyan
%                [0.90 0.10 0.60]};      % magenta

% plotHandles  = [];
% legendLabels = {};

% for i = 1:length(ICs)
%     [tt, PP] = ode45(ode_a2, [0 40], ICs(i), opts);
%     h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
%     plotHandles(end+1)  = h;
%     legendLabels{end+1} = sprintf('P_0 = %.1f', ICs(i));
% end


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

% xlim([0 40]);
% ylim([0 N*1.35]);

% exportgraphics(gcf, 'fig39.png', 'Resolution', 1200);

%% =========================================================
%  FIGURE 4.5 - Effect of b  (b = 0.5, 1, 2, 4)
%% =========================================================
b_vals = [0.5, 1.0, 2.0, 4.0];
P0     = 4.0;
a      = 0.21;

figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;

c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black

% ── Trajectories for each b value ────────────────────────────────────
traj_colors = {c1, c2, c3, c4};

plotHandles  = [];
legendLabels = {};

for i = 1:length(b_vals)
    ode_b = @(t,P) k*P*(1 - P/N) - a*(1 + sin(b_vals(i)*t));
    [tt, PP] = ode45(ode_b, [0 60], P0, opts);
    h = plot(tt, PP, '-', 'Color', traj_colors{i}, 'LineWidth', 2.0);
    plotHandles(end+1)  = h;
    legendLabels{end+1} = sprintf('b = %.1f  (period = %.2f)', ...
                                   b_vals(i), 2*pi/b_vals(i));
end



% ── Axis Labels ───────────────────────────────────────────────────────
xlabel('Time  t', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Population  P', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');

% ── Legend ────────────────────────────────────────────────────────────
lgd = legend(plotHandles, legendLabels, ...
             'Location', 'northeast', 'FontSize', 11, ...
             'FontName', 'Times New Roman');
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

xlim([0 60]);
ylim([0 N*1.2]);

exportgraphics(gcf, 'fig310.png', 'Resolution', 1200);

%% =========================================================
%  TABLE 4.1 - Effect of b on mean and min population
%% =========================================================
% fprintf('=======================================================\n');
% fprintf(' Effect of Frequency b on Population\n');
% fprintf('(k=%.2f, N=%d, a=%.2f, P0=%.1f)\n', k, N, a, P0);
% fprintf('=======================================================\n');
% fprintf('%-8s %-12s %-14s %-14s %-14s\n', ...
%         'b', 'Period', 'Mean P', 'Min P', 'Max P');
% fprintf('%s\n', repmat('-', 1, 65));

% for i = 1:length(b_vals)
%     ode_b    = @(t,P) k*P*(1 - P/N) - a*(1 + sin(b_vals(i)*t));
%     [tt, PP] = ode45(ode_b, [0 60], P0, opts);
%     % use second half of simulation to avoid transient
%     half     = round(length(tt)/2);
%     PP_ss    = PP(half:end);
%     fprintf('%-8.1f %-12.4f %-14.4f %-14.4f %-14.4f\n', ...
%             b_vals(i), 2*pi/b_vals(i), mean(PP_ss), min(PP_ss), max(PP_ss));
% end
% fprintf('%s\n', repmat('=', 1, 65));

%% =========================================================
%  TABLE 4.2 - Comparison a1 vs a2 at steady state
%% =========================================================
% fprintf('\n=======================================================\n');
% fprintf('Comparison of a1 vs a2 (b=%.1f, P0=%.1f)\n', b, P0);
% fprintf('=======================================================\n');
% fprintf('%-8s %-14s %-14s %-14s\n', 'a', 'Mean P', 'Min P', 'Max P');
% fprintf('%s\n', repmat('-', 1, 55));

% for ai = [a1, a2]
%     ode_ai   = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));
%     [tt, PP] = ode45(ode_ai, [0 60], P0, opts);
%     half     = round(length(tt)/2);
%     PP_ss    = PP(half:end);
%     fprintf('%-8.2f %-14.4f %-14.4f %-14.4f\n', ...
%             ai, mean(PP_ss), min(PP_ss), max(PP_ss));
% end
% fprintf('%s\n', repmat('=', 1, 55));