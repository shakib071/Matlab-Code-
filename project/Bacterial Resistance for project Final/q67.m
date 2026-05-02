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

figure;
hold on; grid on; box on;

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

    plot(t_full, s_full, colors{i}, 'LineWidth', 2);
end

xline(30, 'k--', 'Day 30', 'FontSize', 10);
xline(60, 'k:',  'Day 60', 'FontSize', 10);
xlabel('Time (days)', 'FontSize', 12);
ylabel('Total Bacteria (s+r)', 'FontSize', 12);
title('Effect of Early Antibiotic Termination on Bacterial Load', 'FontSize', 13);
legend(labels, 'Location', 'best');
ylim([0 1.1]);