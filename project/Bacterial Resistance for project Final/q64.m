% Parameters — Case II
params = struct( ...
    'beta_S',  0.8,  'beta_R',  0.1,  ...
    'eta',     0.3,  'k',       0.6,  ...
    'alpha1',  0.02, 'd1',      0.30, 'mu1', 0.06, ...
    'alpha2',  0.06, 'd2',      0.05, 'mu2', 0.03  ...
);

% Initial conditions
y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Solve
[t, y] = ode45(@(t,y) model(t,y,params), tspan, y0, opts);

s  = y(:,1);  r  = y(:,2);  b  = y(:,3);
a1 = y(:,4);  a2 = y(:,5);

% Compute A and B to confirm A > B
A = (params.beta_S - sum([(params.alpha1+params.d1), (params.alpha2+params.d2)])) ...
    / (params.beta_S + params.eta);
B = params.beta_R / (params.beta_R + params.eta);
fprintf('Case II — A = %.4f, B = %.4f  (A > B: %d)\n', A, B, A > B);

% ── Plot 1: All 5 Variables ───────────────────────────────────────────────────
% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed
% p1= plot(t, s,  '-',  'Color', c1 , 'LineWidth',2.8);
% p2= plot(t, r,  '-',  'Color', c2 ,  'LineWidth', 2.8);
% p3= plot(t, b,  '-',  'Color', c3 ,  'LineWidth', 2.8);
% p4= plot(t, a1, '-',  'Color', c4 ,  'LineWidth', 2.8);
% p5= plot(t, a2, '-',  'Color', c5 ,  'LineWidth', 2.8);
% xlabel('Time (days)', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% ylabel('Normalized Concentration', 'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman');
% % title('Case II (A>B): Time-Dependent Changes of All Variables', 'FontSize', 13);
% lgd = legend([p1 p2 p3 p4 p5],'Sensitive (s)','Resistant (r)','Immune (b)','INH (antibiotic a1)','PZA ( antibiotic a2)', ...
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
% ylim([0,1.1]);

% exportgraphics(gcf, 'fig25.png', 'Resolution', 1200);

% ── Plot 2: Phase Portrait s vs r ────────────────────────────────────────────
% figure;
% hold on; grid on; box on;
% plot(s, r, 'b', 'LineWidth', 2);
% plot(s(1),   r(1),   'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
% plot(s(end), r(end), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
% xlabel('Sensitive Bacteria (s)', 'FontSize', 12);
% ylabel('Resistant Bacteria (r)', 'FontSize', 12);
% title('Case II (A>B): Phase Portrait — s vs r', 'FontSize', 13);
% legend('Trajectory','Start','End ','Location','best');

% figure('Position',[100 100 900 560], 'Color', 'white');
% hold on; grid on; box on;
% c1 = [0.85 0.10 0.10];   % deep red
% c2 = [0.05 0.40 0.85];   % vivid blue
% c3 = [0.10 0.72 0.20];   % vivid green
% c4 = [0.90 0.50 0.00];   % vivid orange
% c5 = [0.60 0.10 0.85];   % vivid purple
% c6 = [0.10 0.10 0.10];   % near black for dashed

% p1=plot(s, r, '-', 'Color', c1 , 'LineWidth', 2.8);

% % Markers
% p2=plot(s(1),   r(1),   'go', 'MarkerSize', 10, 'MarkerFaceColor', c2);
% p3 = plot(s(end), r(end), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', c3);

% % Annotate start point
% text(s(1)+0.02, r(1), ...
%     sprintf('s=%.2f, r=%.2f', s(1), r(1)), ...
%      'FontSize', 10, 'FontWeight', 'bold');

% % Annotate end point
% text(s(end)+0.02, r(end), ...
%     sprintf('s=%.2f, r=%.2f', s(end), r(end)), ...
%      'FontSize', 10, 'FontWeight', 'bold');

% xlabel('Sensitive Bacteria (s)',  'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% ylabel('Resistant Bacteria (r)',  'FontSize', 14, 'FontWeight', 'bold', ...
%        'FontName', 'Times New Roman' );
% % title('Case II (A>B): Phase Portrait — s vs r', 'FontSize', 13);
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


% exportgraphics(gcf, 'fig26.png', 'Resolution', 1200);

% % ── Plot 3: Bacteria and Immune Coexistence ───────────────────────────────────
figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;
c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black for dashed
p1=plot(t, s,   '-','Color', c1 , 'LineWidth', 2.8);
p2=plot(t, r,   '-','Color', c2 , 'LineWidth', 2.8);
p3=plot(t, b,   '-','Color', c3 , 'LineWidth', 2.8);
p4=plot(t, s+r, '-','Color', c4 , 'LineWidth', 2.8);
xlabel('Time (days)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Normalized Population', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
% title('Case II (A>B): Bacteria and Immune Cell Coexistence', 'FontSize', 13);
lgd =legend('Sensitive (s)','Resistant (r)','Immune (b)','Total (s+r)','Location','best', 'FontSize', 12, ...
    'FontName', 'Times New Roman');
lgd.Box       = 'on';
lgd.EdgeColor = [0.2 0.2 0.2];
lgd.LineWidth = 1.2;
lgd.Color     = [0.97 0.97 0.97];

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

exportgraphics(gcf, 'fig27.png', 'Resolution', 1200);

% % ── Table: Key values at t = 0, 30, 60, 90 ───────────────────────────────────
% idx = [1, 21, 41, 61, 81, 101,  121,  141,  161, 181, 201, 221, 241];
% T_table = table( ...
%     [0;20;40;60;80;100;120;140;160;180;200;220;240], ...
%     round(s(idx),  4), ...
%     round(r(idx),  4), ...
%     round(s(idx)+r(idx), 4), ...
%     round(b(idx),  4), ...
%     round(a1(idx), 4), ...
%     round(a2(idx), 4), ...
%     'VariableNames', ...
%     {'Time','Sensitive','Resistant','TotalBacteria','ImmuneCells','INH','PZA'});

% disp(T_table)