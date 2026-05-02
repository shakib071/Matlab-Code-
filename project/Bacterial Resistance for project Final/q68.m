% 6.8 Single vs Combination Therapy
y0   = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

% INH only
p_INH = struct( ...
    'beta_S',0.8,'beta_R',0.4, ...
    'eta',0.3,'k',0.6, ...
    'alpha1',0.02,'d1',0.40,'mu1',0.06, ...
    'alpha2',0,   'd2',0,   'mu2',0.03);

% PZA only
p_PZA = struct( ...
    'beta_S',0.8,'beta_R',0.4, ...
    'eta',0.3,'k',0.6, ...
    'alpha1',0,   'd1',0,   'mu1',0.06, ...
    'alpha2',0.06,'d2',0.55,'mu2',0.03);

% Combination
p_both = struct( ...
    'beta_S',0.8,'beta_R',0.4, ...
    'eta',0.3,'k',0.6, ...
    'alpha1',0.02,'d1',0.40,'mu1',0.06, ...
    'alpha2',0.06,'d2',0.55,'mu2',0.03);

[t1, y1] = ode45(@(t,y) model(t,y,p_INH),  tspan, y0, opts);
[t2, y2] = ode45(@(t,y) model(t,y,p_PZA),  tspan, y0, opts);
[t3, y3] = ode45(@(t,y) model(t,y,p_both), tspan, y0, opts);

figure;
hold on; grid on; box on;
plot(t1, y1(:,1)+y1(:,2), 'r', 'LineWidth', 2);
plot(t2, y2(:,1)+y2(:,2), 'b', 'LineWidth', 2);
plot(t3, y3(:,1)+y3(:,2), 'g', 'LineWidth', 2);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Total Bacteria (s+r)', 'FontSize', 12);
title('Single vs Combination Antibiotic Therapy', 'FontSize', 13);
legend('INH only','PZA only','INH + PZA (Combination)','Location','best');
ylim([0 1.1]);