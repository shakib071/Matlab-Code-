% 6.6 Effect of Fitness Cost — Varying c
c_values = [0.1, 0.3, 0.5, 0.9];
colors   = {'b', 'r', 'g', 'm'};

y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;
c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black for dashed
colors1     = {c1, c2, c3, c4, c5, c6};
p1 =[];
for i = 1:length(c_values)
    p = struct( ...
        'beta_S', 0.8, ...
        'beta_R', (1 - c_values(i)) * 0.8, ...
        'eta',    0.3, 'k', 0.6, ...
        'alpha1', 0.02,'d1',0.15,'mu1',0.06, ...
        'alpha2', 0.06,'d2',0.35,'mu2',0.03);

    [t, y] = ode45(@(t,y) model(t,y,p), tspan, y0, opts);
    temp=plot(t, y(:,2), '-', 'Color', colors1{i}, 'LineWidth', 2.8);
    p1 = [p1, temp];
end

xlabel('Time (days)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman' );
ylabel('Resistant Bacteria (r)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman' );
% title('Effect of Fitness Cost (c) on Resistant Bacteria', 'FontSize', 13);
lgd=legend([p1(1), p1(2), p1(3), p1(4)], 'c = 0.1','c = 0.3','c = 0.5','c = 0.9','Location','best', 'FontSize', 12, ...
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

exportgraphics(gcf, 'fig29.png', 'Resolution', 1200);