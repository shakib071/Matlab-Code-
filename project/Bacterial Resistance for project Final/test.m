

%% ── Figure 1: Total Bacterial Load ──────────────────────────────────
figure('Position',[100 100 900 560], 'Color', 'white');
hold on; grid on; box on;

% Vibrant custom colors
c1 = [0.85 0.10 0.10];   % deep red
c2 = [0.05 0.40 0.85];   % vivid blue
c3 = [0.10 0.72 0.20];   % vivid green
c4 = [0.10 0.10 0.10];   % near black for dashed

% Thick vibrant lines
p1 = plot(t1, y1(:,1)+y1(:,2), '-',  'Color', c1, 'LineWidth', 2.8);
p2 = plot(t2, y2(:,1)+y2(:,2), '-',  'Color', c2, 'LineWidth', 2.8);
p3 = plot(t3, y3(:,1)+y3(:,2), '-',  'Color', c3, 'LineWidth', 2.8);
p4 = yline(B_val, '--', 'Color', c4, 'LineWidth', 2.0, 'Alpha', 1.0);

% Axis labels
xlabel('Time (days)',          'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
ylabel('Total Bacteria (s+r)', 'FontSize', 14, 'FontWeight', 'bold', ...
       'FontName', 'Times New Roman');
title('Single vs Combination Antibiotic Therapy', ...
      'FontSize', 15, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% Legend with dashed line labeled
lgd = legend([p1 p2 p3 p4], ...
    'INH only', 'PZA only', 'INH+PZA (Combination)', ...
    sprintf('Equilibrium B = %.4f', B_val), ...
    'Location', 'northeast', 'FontSize', 12, ...
    'FontName', 'Times New Roman');
lgd.Box       = 'on';
lgd.EdgeColor = [0.2 0.2 0.2];
lgd.LineWidth = 1.2;
lgd.Color     = [0.97 0.97 0.97];

% Axis styling
ax = gca;
ax.FontSize   = 13;
ax.FontName   = 'Times New Roman';
ax.XColor     = 'k';
ax.YColor     = 'k';
ax.LineWidth  = 1.4;
ax.GridColor  = [0.5 0.5 0.5];
ax.GridAlpha  = 0.35;
ax.GridLineStyle = '--';
ax.TickDir    = 'out';
ax.TickLength = [0.012 0.025];

% Export high quality
exportgraphics(gcf, 'SingleVsCombination.png', 'Resolution', 300);