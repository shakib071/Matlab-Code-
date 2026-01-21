% ==========================================================
% TRAFFIC FLOW MODELING USING CONSERVATION LAWS AND PDEs
% ==========================================================
clc; clear; close all;

% ==============================
% 1. LIGHTHILL-WHITHAM-RICHARDS (LWR) MODEL
% ==============================
fprintf('=== LWR TRAFFIC FLOW MODEL ===\n');

% Parameters
L = 1000;           % Road length (meters)
T = 100;            % Simulation time (seconds)
dx = 10;            % Spatial step (meters)
dt = 0.5;           % Time step (seconds)
x = 0:dx:L;         % Spatial grid
t = 0:dt:T;         % Time grid
nx = length(x);     % Number of spatial points
nt = length(t);     % Number of time points

% Initial density profile (cars/km)
rho0 = zeros(1, nx);
% Create initial traffic jam in middle of road
jam_center = L/2;   % Scalar value
jam_width = 100;
rho0 = 50 + 30 * exp(-(x - jam_center).^2 / (2*(jam_width/3)^2));

% Maximum density (jam density)
rho_max = 120;      % cars/km
% Free flow speed
v_max = 60;         % km/h = 16.67 m/s
v_max_ms = v_max * (1000/3600); % Convert to m/s

% ==============================
% 2. CONSERVATION LAW: ∂ρ/∂t + ∂(ρv)/∂x = 0
% ==============================
fprintf('Solving conservation equation...\n');

% Velocity function (Greenshields model)
% v(ρ) = v_max * (1 - ρ/ρ_max)
velocity = @(rho) v_max_ms * (1 - rho/rho_max);

% Flux function: q(ρ) = ρ * v(ρ)
flux = @(rho) rho .* velocity(rho);

% Initialize density matrix
rho = zeros(nt, nx);
rho(1,:) = rho0;

% ==============================
% 3. NUMERICAL SOLUTION USING FINITE DIFFERENCE
% ==============================
fprintf('Computing numerical solution...\n');

% Lax-Friedrichs scheme for stability
for n = 1:nt-1
    for i = 2:nx-1
        % Calculate fluxes
        F_left = flux(rho(n, i-1));
        F_right = flux(rho(n, i+1));
        
        % Lax-Friedrichs update
        rho(n+1, i) = 0.5*(rho(n, i-1) + rho(n, i+1)) ...
            - (dt/(2*dx)) * (F_right - F_left);
    end
    
    % Boundary conditions: periodic or fixed
    rho(n+1, 1) = rho(n+1, 2);      % Neumann boundary
    rho(n+1, nx) = rho(n+1, nx-1);  % Neumann boundary
end

% ==============================
% 4. METHOD OF CHARACTERISTICS SOLUTION
% ==============================
fprintf('Computing method of characteristics solution...\n');

% For comparison, solve using method of characteristics
% Characteristic speed: c(ρ) = dq/dρ = v_max * (1 - 2ρ/ρ_max)
char_speed = @(rho) v_max_ms * (1 - 2*rho/rho_max);

% Create characteristic grid
rho_char = zeros(nt, nx);

% Initial conditions along characteristics
for i = 1:10:nx  % Sample every 10th point for speed
    x0 = x(i);
    rho0_val = rho0(i);
    
    % Characteristic equation: dx/dt = c(ρ)
    for n = 1:10:nt  % Sample every 10th time step
        % Follow characteristic curve
        char_position = x0 + char_speed(rho0_val) * t(n);
        
        % Find nearest grid point
        [~, idx] = min(abs(x - char_position));
        if idx >= 1 && idx <= nx
            rho_char(n, idx) = rho0_val;
        end
    end
end

% ==============================
% 5. VISUALIZE RESULTS
% ==============================
figure('Position', [100 100 1400 800]);

% Subplot 1: Initial density
subplot(2,3,1);
plot(x, rho0, 'b-', 'LineWidth', 2);
xlabel('Position (m)');
ylabel('Density (cars/km)');
title('Initial Traffic Density');
grid on;
xlim([0 L]);
ylim([0 rho_max]);

% Subplot 2: Density evolution (3D surface)
subplot(2,3,2);
[X, T_grid] = meshgrid(x, t);  % Renamed to T_grid to avoid conflict with T
surf(X, T_grid, rho, 'EdgeColor', 'none');
xlabel('Position (m)');
ylabel('Time (s)');
zlabel('Density (cars/km)');
title('Traffic Density Evolution');
colorbar;
view(30, 30);

% Subplot 3: Characteristic curves
subplot(2,3,3);
hold on;
for i = 1:20:nx  % Plot fewer curves for clarity
    x0 = x(i);
    rho0_val = rho0(i);
    char_traj = x0 + char_speed(rho0_val) * t;
    plot(char_traj, t, 'b-', 'LineWidth', 0.5);
end
xlabel('Position (m)');
ylabel('Time (s)');
title('Characteristic Curves');
grid on;
xlim([0 L]);

% Subplot 4: Shock wave formation
subplot(2,3,4);
% Plot density at different times
times_to_plot = [1, round(nt/4), round(nt/2), round(3*nt/4), nt];
colors = {'b-', 'r-', 'g-', 'm-', 'k-'};
legend_entries = cell(1, length(times_to_plot));

hold on;
for i = 1:length(times_to_plot)
    n = times_to_plot(i);
    plot(x, rho(n,:), colors{i}, 'LineWidth', 2);
    legend_entries{i} = sprintf('t = %.1f s', t(n));
end
xlabel('Position (m)');
ylabel('Density (cars/km)');
title('Density Propagation (Shock Formation)');
legend(legend_entries, 'Location', 'best');
grid on;
xlim([0 L]);
ylim([0 rho_max]);

% Subplot 5: Fundamental diagram
subplot(2,3,5);
rho_test = linspace(0, rho_max, 100);
q_test = flux(rho_test);
v_test = velocity(rho_test);

yyaxis left;
plot(rho_test, q_test, 'b-', 'LineWidth', 2);
xlabel('Density ρ (cars/km)');
ylabel('Flow q (cars/h)');
title('Fundamental Diagram');
grid on;

yyaxis right;
plot(rho_test, v_test * 3.6, 'r--', 'LineWidth', 2); % Convert back to km/h
ylabel('Speed v (km/h)');

% Subplot 6: Comparison of methods
subplot(2,3,6);
hold on;
plot(x, rho(end,:), 'b-', 'LineWidth', 2);
% Interpolate characteristic solution to fill gaps
rho_char_filled = fillmissing(rho_char(end,:), 'nearest');
plot(x, rho_char_filled, 'r--', 'LineWidth', 2);
xlabel('Position (m)');
ylabel('Density (cars/km)');
title('Final Density: FD vs Characteristics');
legend('Finite Difference', 'Method of Characteristics', 'Location', 'best');
grid on;
xlim([0 L]);

% ==============================
% 6. TRAFFIC JAM ANALYSIS (CORRECTED)
% ==============================
fprintf('\n=== TRAFFIC JAM ANALYSIS ===\n');

% Find traffic jam properties
[max_density, max_idx] = max(rho(end,:));
jam_position_final = x(max_idx);  % Renamed to avoid confusion
jam_speed = char_speed(max_density);

fprintf('Traffic Jam Properties:\n');
fprintf('  Maximum density: %.1f cars/km\n', max_density);
fprintf('  Jam position (final): %.1f m\n', jam_position_final);
fprintf('  Characteristic speed at jam: %.2f m/s\n', jam_speed);

% Calculate total flow
total_flow = sum(flux(rho(end,:))) * dx / 1000; % cars/h
fprintf('  Total flow at end: %.0f cars/h\n', total_flow);

% ==============================
% 7. SHOCK WAVE SPEED CALCULATION (CORRECTED)
% ==============================
fprintf('\n=== SHOCK WAVE ANALYSIS ===\n');

% Find shock location (steepest gradient)
density_gradient = abs(diff(rho(end,:)));
[~, shock_idx] = max(density_gradient);
shock_position = x(shock_idx);

% FIXED: Both are scalars now
shock_speed = (shock_position - jam_center) / T;

fprintf('Shock Wave Properties:\n');
fprintf('  Shock position: %.1f m\n', shock_position);
fprintf('  Shock speed: %.2f m/s\n', shock_speed);

% Rankine-Hugoniot condition for shock speed
if shock_idx < nx
    rho_left = rho(end, shock_idx);
    rho_right = rho(end, shock_idx+1);
    
    if rho_right ~= rho_left  % Avoid division by zero
        shock_speed_RH = (flux(rho_right) - flux(rho_left)) / (rho_right - rho_left);
        fprintf('  Rankine-Hugoniot shock speed: %.2f m/s\n', shock_speed_RH);
    else
        fprintf('  No density jump at shock location\n');
    end
end

% ==============================
% 8. SIMULATION WITH TRAFFIC LIGHT
% ==============================
fprintf('\n=== TRAFFIC LIGHT SIMULATION ===\n');

% Add traffic light at x = 500 m
traffic_light_pos = 500;
traffic_light_state = zeros(1, nt); % 0 = red, 1 = green

% Traffic light cycle: 30 seconds green, 30 seconds red
cycle_period = 60; % seconds
for n = 1:nt
    traffic_light_state(n) = mod(t(n), cycle_period) < cycle_period/2;
end

% Modify flux function with traffic light
flux_with_light = @(rho_val, state) ...
    rho_val .* velocity(rho_val) .* state; % Simple: no flow when red

% Simulate with traffic light
rho_light = zeros(nt, nx);
rho_light(1,:) = rho0;

for n = 1:nt-1
    current_state = traffic_light_state(n);
    for i = 2:nx-1
        % Check if position is near traffic light
        if abs(x(i) - traffic_light_pos) < 50
            F_left = flux_with_light(rho_light(n, i-1), current_state);
            F_right = flux_with_light(rho_light(n, i+1), current_state);
        else
            F_left = flux(rho_light(n, i-1));
            F_right = flux(rho_light(n, i+1));
        end
        
        rho_light(n+1, i) = 0.5*(rho_light(n, i-1) + rho_light(n, i+1)) ...
            - (dt/(2*dx)) * (F_right - F_left);
    end
    
    rho_light(n+1, 1) = rho_light(n+1, 2);
    rho_light(n+1, nx) = rho_light(n+1, nx-1);
end

% Visualize traffic light effect
figure('Position', [100 100 1200 500]);

subplot(1,2,1);
imagesc(x, t, rho_light);
xlabel('Position (m)');
ylabel('Time (s)');
title('Traffic Density with Traffic Light');
colorbar;
hold on;
% Add traffic light state indicator
plot([traffic_light_pos, traffic_light_pos], [0 T], 'w--', 'LineWidth', 2);
text(traffic_light_pos+10, T/2, 'Traffic Light', 'Color', 'white', 'FontSize', 12);

subplot(1,2,2);
% Plot queue length at traffic light
queue_length = zeros(1, nt);
light_idx = find(abs(x - traffic_light_pos) < dx, 1); % Index near traffic light

for n = 1:nt
    if traffic_light_state(n) == 0  % Red light
        % Find where density > threshold upstream of light
        upstream_idx = 1:light_idx;
        high_density = rho_light(n, upstream_idx) > 0.7*rho_max;
        if any(high_density)
            queue_length(n) = sum(high_density) * dx;
        end
    end
end

plot(t, queue_length, 'r-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Queue Length (m)');
title('Queue Length at Traffic Light');
grid on;
xlim([0 T]);

% Add red/green light indicators
yyaxis right;
plot(t, traffic_light_state, 'g-', 'LineWidth', 1);
ylabel('Light State (0=Red, 1=Green)');
ylim([-0.1 1.1]);

% ==============================
% 9. TRAFFIC METRICS AND ANALYSIS
% ==============================
fprintf('\n=== TRAFFIC PERFORMANCE METRICS ===\n');

% Calculate average travel time
avg_speed = mean(velocity(rho(end,:)));
if avg_speed > 0
    avg_travel_time = L / avg_speed;
    fprintf('Average travel time: %.1f seconds\n', avg_travel_time);
else
    fprintf('Average speed is zero (complete jam)\n');
end

% Calculate delay
free_flow_time = L / v_max_ms;
if avg_speed > 0
    delay = avg_travel_time - free_flow_time;
    fprintf('Delay compared to free flow: %.1f seconds\n', delay);
end

% Calculate total vehicle-hours
total_vehicles = sum(rho(end,:)) * dx / 1000; % Convert to cars
total_vehicle_hours = total_vehicles * avg_travel_time / 3600;
fprintf('Total vehicle-hours: %.2f veh-h\n', total_vehicle_hours);

% ==============================
% 10. BOTTLENECK ANALYSIS
% ==============================
fprintf('\n=== BOTTLENECK ANALYSIS ===\n');

% Create bottleneck (reduced capacity section)
bottleneck_start = 300;
bottleneck_end = 400;
bottleneck_factor = 0.5; % 50% capacity reduction

rho_bottleneck = zeros(nt, nx);
rho_bottleneck(1,:) = rho0;

for n = 1:nt-1
    for i = 2:nx-1
        % Reduced capacity in bottleneck section
        if x(i) >= bottleneck_start && x(i) <= bottleneck_end
            effective_v_max = v_max_ms * bottleneck_factor;
            velocity_local = @(rho_val) effective_v_max * (1 - rho_val/rho_max);
            flux_local = @(rho_val) rho_val .* velocity_local(rho_val);
            
            F_left = flux_local(rho_bottleneck(n, i-1));
            F_right = flux_local(rho_bottleneck(n, i+1));
        else
            F_left = flux(rho_bottleneck(n, i-1));
            F_right = flux(rho_bottleneck(n, i+1));
        end
        
        rho_bottleneck(n+1, i) = 0.5*(rho_bottleneck(n, i-1) + rho_bottleneck(n, i+1)) ...
            - (dt/(2*dx)) * (F_right - F_left);
    end
    
    rho_bottleneck(n+1, 1) = rho_bottleneck(n+1, 2);
    rho_bottleneck(n+1, nx) = rho_bottleneck(n+1, nx-1);
end

% Compare with and without bottleneck
figure('Position', [100 100 1000 400]);
subplot(1,2,1);
plot(x, rho(end,:), 'b-', 'LineWidth', 2);
hold on;
plot(x, rho_bottleneck(end,:), 'r--', 'LineWidth', 2);
xlabel('Position (m)');
ylabel('Density (cars/km)');
title('Effect of Bottleneck');
legend('No Bottleneck', 'With Bottleneck', 'Location', 'best');
grid on;
xlim([0 L]);

% Mark bottleneck region
rectangle('Position', [bottleneck_start, 0, bottleneck_end-bottleneck_start, rho_max], ...
    'FaceColor', [1 0.5 0.5 0.3], 'EdgeColor', 'none');

subplot(1,2,2);
% Calculate flow reduction
flow_normal = flux(rho(end,:));
flow_bottleneck = zeros(size(flow_normal));
for i = 1:nx
    if x(i) >= bottleneck_start && x(i) <= bottleneck_end
        effective_v_max = v_max_ms * bottleneck_factor;
        velocity_local = @(rho_val) effective_v_max * (1 - rho_val/rho_max);
        flow_bottleneck(i) = rho_bottleneck(end,i) .* velocity_local(rho_bottleneck(end,i));
    else
        flow_bottleneck(i) = flux(rho_bottleneck(end,i));
    end
end

plot(x, flow_normal, 'b-', 'LineWidth', 2);
hold on;
plot(x, flow_bottleneck, 'r--', 'LineWidth', 2);
xlabel('Position (m)');
ylabel('Flow (cars/h)');
title('Flow Reduction due to Bottleneck');
legend('No Bottleneck', 'With Bottleneck', 'Location', 'best');
grid on;
xlim([0 L]);

% ==============================
% SAVE RESULTS
% ==============================
fprintf('\n=== SIMULATION COMPLETE ===\n');
fprintf('\nKey Findings:\n');
fprintf('1. Traffic shock waves form at density gradients\n');
fprintf('2. Bottlenecks significantly reduce traffic flow\n');
fprintf('3. Traffic lights create queues during red phases\n');
fprintf('4. Fundamental diagram shows optimal density for maximum flow\n');

% Save figures
saveas(gcf, 'traffic_bottleneck_results.png');
fprintf('\nResults saved as traffic_bottleneck_results.png\n');