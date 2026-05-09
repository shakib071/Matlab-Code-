% Parameters — Case I
params = struct( ...
    'beta_S',  0.8,  'beta_R',  0.4,  ...
    'eta',     0.3,  'k',       0.6,  ...
    'alpha1',  0.02, 'd1',      0.15, 'mu1', 0.06, ...
    'alpha2',  0.06, 'd2',      0.35, 'mu2', 0.03  ...
);

% Initial conditions
y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Solve
[t, y] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

s  = y(:,1);  r  = y(:,2);  b  = y(:,3);
a1 = y(:,4);  a2 = y(:,5);

% ── Plot 1: All 5 variables ───────────────────────────────────────────────────
% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed
% p1 = plot(t, s,  '-','Color', c1 , 'LineWidth',2.8);
% p2 = plot(t, r,  '-','Color', c2 ,  'LineWidth', 2.8);
% p3 = plot(t, b,  '-','Color', c3 ,  'LineWidth', 2.8);
% p4 = plot(t, a1, '-','Color', c4 ,  'LineWidth', 2.8);
% p5 =plot(t, a2, '-','Color', c5 ,  'LineWidth', 2.8);
% xlabel('Time (days)',           'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Normalized Concentration', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% % title('Case I (A<B): Time-Dependent Changes of All Variables', 'FontSize', 13);
% lgd = legend([p1 p2 p3 p4 p5],'Sensitive (s)','Resistant (r)','Immune (b)','INH (antibiotic a1)','PZA (antibiotic a2)', ...
%        'Location','best', 'FontSize', 12, ...
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

% % Export high quality
% exportgraphics(gcf, 'fig21.png', 'Resolution', 1200);

% ── Plot 2: Bacteria vs Immune Cells ─────────────────────────────────────────
% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed
% p1 = plot(t, s+r, '-','Color', c1 , 'LineWidth', 2.8);
% p2 = plot(t, b,    '-','Color', c2 , 'LineWidth', 2.8);
% xlabel('Time (days)','FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% ylabel('Normalized Population', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% % title('Case I (A<B): Total Bacteria vs Immune Cells', 'FontSize', 13);
% lgd =legend([p1 p2],'Total Bacteria (s+r)','Immune Cells (b)','Location','best', 'FontSize', 12, ...
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

% % Export high quality
% exportgraphics(gcf, 'fig22.png', 'Resolution', 1200);


% ── Plot 3: Antibiotic Concentrations ────────────────────────────────────────
figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;
c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black for dashed
p1=plot(t, a1, '-','Color', c1 , 'LineWidth', 2.8);
p2=plot(t, a2, '-','Color', c2 , 'LineWidth', 2.8);
xlabel('Time (days)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman' );
ylabel('Normalized Concentration', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman' );
% title('Case I (A<B): Antibiotic Concentrations Over Time', 'FontSize', 13);
lgd = legend([p1 p2],'INH (antibiotic a1)','PZA (antibiotic a2)','Location','best', 'FontSize', 12, ...
    'FontName', 'Times New Roman');
lgd.Box       = 'on';
lgd.EdgeColor = [0.2 0.2 0.2];
lgd.LineWidth = 1.2;
lgd.Color     = [0.97 0.97 0.97];

% Axis styling
ax = gca;
ax.FontSize   = 12;
ax.FontName   = 'Times New Roman';
ax.XColor     = 'k';
ax.YColor     = 'k';
ax.LineWidth  = 1.4;
ax.GridColor  = [0.5 0.5 0.5];
ax.GridAlpha  = 0.35;
ax.GridLineStyle = '--';
ax.TickDir    = 'out';
ax.TickLength = [0.012 0.025];
ax.Position = [0.15 0.13 0.78 0.78];
ylim([0,1.1]);

exportgraphics(gcf, 'fig23.png', 'Resolution', 1200);


% Extract values at t = 0, 10, 20, 30, 40, 50, 60, 70, 80, 90
% idx = [1, 11, 21, 31, 41, 51, 61, 71, 81, 91];

% T_table = table( ...
%     [0;10;20;30;40;50;60;70;80;90], ...
%     round(s(idx),  4), ...
%     round(r(idx),  4), ...
%     round(s(idx)+r(idx), 4), ...
%     round(b(idx),  4), ...
%     round(a1(idx), 4), ...
%     round(a2(idx), 4), ...
%     'VariableNames', ...
%     {'Time','Sensitive','Resistant','TotalBacteria','ImmuneCells','INH','PZA'});

% disp(T_table)


% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed

% p1 =plot(s, r, '-','Color', c1 , 'LineWidth', 2.8);

% % Markers
% p2 =plot(s(1),   r(1),   'go', 'MarkerSize', 10, 'MarkerFaceColor', c2);
% p3 =plot(s(end), r(end), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', c3);

% % Start label — push left since s(1)=0.80 is on right
% text(s(1)-0.20, r(1)-0.008, ...
%     sprintf('s=%.2f, r=%.2f', s(1), r(1)), ...
%      'FontSize', 10, 'FontWeight', 'bold');

% % End label — s(end)≈0, r(end)≈0.57
% text(s(end)+0.03, r(end), ...
%     sprintf('s=%.2f, r=%.2f', s(end), r(end)), ...
%      'FontSize', 10, 'FontWeight', 'bold');

% xlabel('Sensitive Bacteria (s)', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% ylabel('Resistant Bacteria (r)', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% % title('Case I (A<B): Phase Portrait — s vs r', 'FontSize', 13);
% % lgd.Box       = 'on';
% % lgd.EdgeColor = [0.2 0.2 0.2];
% % lgd.LineWidth = 1.2;
% % lgd.Color     = [0.97 0.97 0.97];

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


% exportgraphics(gcf, 'fig24.png', 'Resolution', 1200);