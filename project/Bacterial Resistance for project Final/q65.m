% 6.5 Effect of Immune System Strength — Varying eta
eta_values = [0.1, 0.3, 0.6, 1.0];
colors     = {'b', 'r', 'g', 'm'};

y0    = [0.80; 0.05; 0.05; 0.05; 0.02];
tspan = 0:1:90;
opts  = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1:5);

figure;
hold on; grid on; box on;

for i = 1:length(eta_values)
    p = struct( ...
        'beta_S',0.8, 'beta_R',0.4, ...
        'eta',   eta_values(i), 'k', 0.6, ...
        'alpha1',0.02,'d1',0.15,'mu1',0.06, ...
        'alpha2',0.06,'d2',0.35,'mu2',0.03);

    [t, y] = ode45(@(t,y) model(t,y,p), tspan, y0, opts);
    total_bac = y(:,1) + y(:,2);
    plot(t, total_bac, colors{i}, 'LineWidth', 2);
end

xlabel('Time (days)', 'FontSize', 12);
ylabel('Total Bacteria (s+r)', 'FontSize', 12);
title('Effect of Immune Strength (\eta) on Total Bacterial Load', 'FontSize', 13);
legend('\eta = 0.1','\eta = 0.3','\eta = 0.6','\eta = 1.0','Location','best');
ylim([0 1.1]);