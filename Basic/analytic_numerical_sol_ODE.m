% ============================================
% SIMPLE ODE COMPARISON (ERROR-FREE)
% ============================================
clc; clear; close all;

fprintf('=== SIMPLE ODE COMPARISON ===\n');

% Test ODE: y' = -2y, y(0) = 1
% Analytical solution: y(t) = exp(-2t)

% Time setup
tspan = [0 5];
dt_values = [0.5, 0.2, 0.1, 0.05, 0.01];
t_fine = linspace(tspan(1), tspan(2), 1000);
y_analytical = exp(-2*t_fine);

% Initialize
methods = {'Euler', 'Heun', 'RK4', 'ode45'};
errors = zeros(length(methods), length(dt_values));
times = zeros(length(methods), length(dt_values));

figure('Position', [100 100 1200 800]);

for dt_idx = 1:length(dt_values)
    dt = dt_values(dt_idx);
    t = tspan(1):dt:tspan(2);
    
    % 1. Euler Method
    tic;
    y_euler = zeros(size(t));
    y_euler(1) = 1;
    for i = 1:length(t)-1
        y_euler(i+1) = y_euler(i) + dt * (-2*y_euler(i));
    end
    times(1, dt_idx) = toc;
    
    % Interpolate to fine grid for error calculation
    y_euler_interp = interp1(t, y_euler, t_fine);
    errors(1, dt_idx) = sqrt(mean((y_euler_interp - y_analytical).^2));
    
    % 2. Heun's Method
    tic;
    y_heun = zeros(size(t));
    y_heun(1) = 1;
    for i = 1:length(t)-1
        % Predictor
        y_pred = y_heun(i) + dt * (-2*y_heun(i));
        % Corrector
        y_heun(i+1) = y_heun(i) + dt/2 * (-2*y_heun(i) - 2*y_pred);
    end
    times(2, dt_idx) = toc;
    
    y_heun_interp = interp1(t, y_heun, t_fine);
    errors(2, dt_idx) = sqrt(mean((y_heun_interp - y_analytical).^2));
    
    % 3. RK4 Method (FIXED SYNTAX)
    tic;
    y_rk4 = zeros(size(t));
    y_rk4(1) = 1;
    for i = 1:length(t)-1
        k1 = -2 * y_rk4(i);
        k2 = -2 * (y_rk4(i) + dt/2 * k1);
        k3 = -2 * (y_rk4(i) + dt/2 * k2);
        k4 = -2 * (y_rk4(i) + dt * k3);
        y_rk4(i+1) = y_rk4(i) + dt/6 * (k1 + 2*k2 + 2*k3 + k4);
    end
    times(3, dt_idx) = toc;
    
    y_rk4_interp = interp1(t, y_rk4, t_fine);
    errors(3, dt_idx) = sqrt(mean((y_rk4_interp - y_analytical).^2));
    
    % 4. MATLAB ode45
    tic;
    [t_ode45, y_ode45] = ode45(@(t,y) -2*y, tspan, 1);
    times(4, dt_idx) = toc;
    
    y_ode45_interp = interp1(t_ode45, y_ode45, t_fine);
    errors(4, dt_idx) = sqrt(mean((y_ode45_interp - y_analytical).^2));
    
    % Plot for this dt
    subplot(2,3,dt_idx);
    plot(t_fine, y_analytical, 'k-', 'LineWidth', 3, 'DisplayName', 'Analytical');
    hold on;
    plot(t, y_euler, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Euler');
    plot(t, y_heun, 'g-.', 'LineWidth', 1.5, 'DisplayName', 'Heun');
    plot(t, y_rk4, 'b:', 'LineWidth', 1.5, 'DisplayName', 'RK4');
    plot(t_ode45, y_ode45, 'm-', 'LineWidth', 1.5, 'DisplayName', 'ode45');
    xlabel('Time t');
    ylabel('y(t)');
    title(sprintf('dt = %.2f', dt));
    legend('Location', 'best');
    grid on;
    xlim(tspan);
end

% Convergence plot
subplot(2,3,6);
loglog(dt_values, errors(1,:), 'ro-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Euler');
hold on;
loglog(dt_values, errors(2,:), 'gs-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Heun');
loglog(dt_values, errors(3,:), 'bd-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'RK4');
loglog(dt_values, errors(4,:), 'm^-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'ode45');

% Add theoretical convergence lines
for order = [1, 2, 4]
    ref_line = dt_values.^order * errors(1,1) / dt_values(1)^order;
    loglog(dt_values, ref_line, 'k:', 'LineWidth', 1, 'DisplayName', sprintf('O(dt^%d)', order));
end

xlabel('Step Size dt');
ylabel('RMS Error');
title('Convergence Analysis');
legend('Location', 'best');
grid on;

% Print results
fprintf('\nStep Size\tEuler Error\tHeun Error\tRK4 Error\tode45 Error\n');
fprintf('---------\t-----------\t----------\t---------\t----------\n');
for dt_idx = 1:length(dt_values)
    fprintf('%.3f\t\t%.2e\t%.2e\t%.2e\t%.2e\n', ...
        dt_values(dt_idx), errors(1,dt_idx), errors(2,dt_idx), ...
        errors(3,dt_idx), errors(4,dt_idx));
end

% Calculate convergence rates
fprintf('\nConvergence Rates:\n');
for m = 1:4
    p = polyfit(log(dt_values), log(errors(m,:)), 1);
    fprintf('%s: slope = %.3f\n', methods{m}, p(1));
end

saveas(gcf, 'simple_ode_comparison.png');
fprintf('\nFigure saved as simple_ode_comparison.png\n');