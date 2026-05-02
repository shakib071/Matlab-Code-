% 6.6 Effect of Fitness Cost — Varying c
c_values = [0.1, 0.3, 0.5, 0.9];
colors   = {'b', 'r', 'g', 'm'};

y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

figure;
hold on; grid on; box on;

for i = 1:length(c_values)
    p = struct( ...
        'beta_S', 0.8, ...
        'beta_R', (1 - c_values(i)) * 0.8, ...
        'eta',    0.3, 'k', 0.6, ...
        'alpha1', 0.02,'d1',0.15,'mu1',0.06, ...
        'alpha2', 0.06,'d2',0.35,'mu2',0.03);

    [t, y] = ode45(@(t,y) model(t,y,p), tspan, y0, opts);
    plot(t, y(:,2), colors{i}, 'LineWidth', 2);
end

xlabel('Time (days)', 'FontSize', 12);
ylabel('Resistant Bacteria (r)', 'FontSize', 12);
title('Effect of Fitness Cost (c) on Resistant Bacteria', 'FontSize', 13);
legend('c = 0.1','c = 0.3','c = 0.5','c = 0.9','Location','best');
ylim([0 1.1]);