% 6.7 Early Antibiotic Termination
stop_days = [30, 60, 90];
colors    = {'r', 'b', 'g'};
labels    = {'Stopped at Day 30','Stopped at Day 60','Full Course (Day 90)'};

y0   = [0.80; 0.05; 0.05; 0.05; 0.02];
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% Case II parameters
p = struct( ...
    'beta_S',0.8,'beta_R',0.1, ...
    'eta',0.3,'k',0.6, ...
    'alpha1',0.02,'d1',0.15,'mu1',0.06, ...
    'alpha2',0.06,'d2',0.35,'mu2',0.03);

p_off = struct( ...
    'beta_S',0.8,'beta_R',0.1, ...
    'eta',0.3,'k',0.6, ...
    'alpha1',0,'d1',0,'mu1',0.06, ...
    'alpha2',0,'d2',0,'mu2',0.03);

figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;
c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.90 0.50 0.00];   % vivid orange
c5 = [0.60 0.10 0.85];   % vivid purple
c6 = [0.10 0.10 0.10];   % near black for dashed
colors1 = {c1, c2, c3};
p1 = [];
for i = 1:length(stop_days)

    tspan1 = 0:1:stop_days(i);
    [t1, y1] = ode45(@(t,y) model(t,y,p), tspan1, y0, opts);

    if stop_days(i) < 90
        tspan2    = stop_days(i):1:90;
        y_restart = y1(end,:);

        [t2, y2] = ode45(@(t,y) model(t,y,p_off), tspan2, y_restart, opts);

        t_full = [t1; t2(2:end)];
        s_full = [y1(:,1)+y1(:,2); y2(2:end,1)+y2(2:end,2)];
    else
        t_full = t1;
        s_full = y1(:,1) + y1(:,2);
    end

    temp = plot(t_full, s_full, '-', 'Color', colors1{i}, 'LineWidth', 2.8);
    p1 = [p1, temp];
end

temp2 = xline(30, '--', 'Color', c4, 'LineWidth', 2.0);
temp3 = xline(60, '--', 'Color', c5, 'LineWidth', 2.0);
xlabel('Time (days)','FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');

ylabel('Total Bacteria (s+r)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
text(31, 1.05, 'Day 30', 'FontSize', 10, 'Color', c4, 'FontName', 'Times New Roman');
text(61, 1.05, 'Day 60', 'FontSize', 10, 'Color', c5, 'FontName', 'Times New Roman');
p1=[p1, temp2, temp3];
% title('Effect of Early Antibiotic Termination on Bacterial Load', 'FontSize', 13);
lgd = legend(p1,labels, 'Location', 'best', 'FontSize', 12, ...
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

exportgraphics(gcf, 'fig210.png', 'Resolution', 1200);
