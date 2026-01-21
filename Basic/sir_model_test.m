% ==========================================================
% EPIDEMIC MODELING USING SIR/SEIR DIFFERENTIAL EQUATIONS
% ==========================================================
clc; clear; close all;

% ==============================
% 1. BASIC SIR MODEL
% ==============================
fprintf('=== BASIC SIR MODEL ===\n');

% Parameters (example values - can be adjusted)
beta = 0.2;      % Transmission rate
gamma = 0.1;     % Recovery rate
N = 1000;        % Total population
I0 = 1;          % Initial infected
S0 = N - I0;     % Initial susceptible
R0_initial = 0;  % Initial recovered (rename to avoid conflict with R0 variable)
tspan = [0 200]; % Time span (days)

% Solve SIR ODEs
[t, Y] = ode45(@(t,y) sir_odes(t, y, beta, gamma, N), tspan, [S0; I0; R0_initial]);
S = Y(:,1); I = Y(:,2); R = Y(:,3);

% Plot basic SIR
figure('Position', [100 100 1200 800]);

subplot(2,3,1);
plot(t, S, 'b-', 'LineWidth', 2); hold on;
plot(t, I, 'r-', 'LineWidth', 2);
plot(t, R, 'g-', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
title('Basic SIR Model');
legend('Susceptible', 'Infected', 'Recovered', 'Location', 'best');
grid on;

% Calculate basic reproduction number R0
R0_basic = beta/gamma;
fprintf('Basic Reproduction Number R0 = %.2f\n', R0_basic);
fprintf('Peak Infected: %.0f people (%.1f%% of population)\n', ...
    max(I), max(I)/N*100);
fprintf('Final Susceptible: %.0f people\n', S(end));

% ==============================
% 2. SEIR MODEL (WITH EXPOSED COMPARTMENT)
% ==============================
fprintf('\n=== SEIR MODEL ===\n');

% Additional parameter for SEIR
sigma = 0.2;     % Incubation rate (1/incubation period)
E0 = 0;          % Initial exposed

% Solve SEIR ODEs
[t_seir, Y_seir] = ode45(@(t,y) seir_odes(t, y, beta, sigma, gamma, N), ...
    tspan, [S0; E0; I0; R0_initial]);

S_seir = Y_seir(:,1); E = Y_seir(:,2); I_seir = Y_seir(:,3); R_seir = Y_seir(:,4);

subplot(2,3,2);
plot(t_seir, S_seir, 'b-', 'LineWidth', 2); hold on;
plot(t_seir, E, 'm-', 'LineWidth', 2);
plot(t_seir, I_seir, 'r-', 'LineWidth', 2);
plot(t_seir, R_seir, 'g-', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
title('SEIR Model');
legend('Susceptible', 'Exposed', 'Infected', 'Recovered', 'Location', 'best');
grid on;

% ==============================
% 3. SIR WITH VITAL DYNAMICS (BIRTHS/DEATHS) - CORRECTED
% ==============================
fprintf('\n=== SIR WITH VITAL DYNAMICS ===\n');

mu = 0.0001;     % Birth/death rate (approx 3.65% annually)
[t_vital, Y_vital] = ode45(@(t,y) sir_vital_odes(t, y, beta, gamma, mu, N), ...
    tspan, [S0; I0; R0_initial]);

S_vital = Y_vital(:,1); I_vital = Y_vital(:,2); R_vital = Y_vital(:,3);

subplot(2,3,3);
plot(t_vital, S_vital, 'b-', 'LineWidth', 2); hold on;
plot(t_vital, I_vital, 'r-', 'LineWidth', 2);
plot(t_vital, R_vital, 'g-', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population');
title('SIR with Vital Dynamics (\mu = 0.0001/day)');
legend('Susceptible', 'Infected', 'Recovered', 'Location', 'best');
grid on;

% ==============================
% 4. EFFECT OF INTERVENTIONS
% ==============================
fprintf('\n=== INTERVENTION SCENARIOS ===\n');

% Scenario 1: Social distancing (reduced beta)
beta_sd = 0.15;  % 50% reduction in transmission
[t_sd, Y_sd] = ode45(@(t,y) sir_odes(t, y, beta_sd, gamma, N), tspan, [S0; I0; R0_initial]);
I_sd = Y_sd(:,2);

% Scenario 2: Vaccination (reduced initial susceptibles)
vaccination_rate = 0.4;  % 30% vaccinated
S0_vacc = N*(1-vaccination_rate) - I0;
R0_vacc = N*vaccination_rate;
[t_vacc, Y_vacc] = ode45(@(t,y) sir_odes(t, y, beta, gamma, N), ...
    tspan, [S0_vacc; I0; R0_vacc]);
I_vacc = Y_vacc(:,2);

subplot(2,3,4);
plot(t, I, 'r-', 'LineWidth', 2); hold on;
plot(t_sd, I_sd, 'b--', 'LineWidth', 2);
plot(t_vacc, I_vacc, 'g:', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Infected Population');
title('Effect of Interventions');
legend('No Intervention', 'Social Distancing (\beta reduced 50%)', ...
    'Vaccination (30% immune)', 'Location', 'best');
grid on;

% Calculate intervention impact
fprintf('Peak Infections:\n');
fprintf('  No intervention: %.0f\n', max(I));
fprintf('  Social distancing: %.0f (%.1f%% reduction)\n', ...
    max(I_sd), (1-max(I_sd)/max(I))*100);
fprintf('  Vaccination: %.0f (%.1f%% reduction)\n', ...
    max(I_vacc), (1-max(I_vacc)/max(I))*100);

% ==============================
% 5. PHASE PLANE ANALYSIS
% ==============================
fprintf('\n=== PHASE PLANE ANALYSIS ===\n');

subplot(2,3,5);
plot(S, I, 'b-', 'LineWidth', 2);
xlabel('Susceptible');
ylabel('Infected');
title('S-I Phase Plane');
grid on;
hold on;

% Add direction field
[S_grid, I_grid] = meshgrid(linspace(0, N, 15), linspace(0, N/2, 10));
dS = -beta/N * S_grid .* I_grid;
dI = beta/N * S_grid .* I_grid - gamma * I_grid;
quiver(S_grid, I_grid, dS, dI, 'r', 'LineWidth', 1);

% Add nullclines
S_null = linspace(0, N, 100);
I_null_s = zeros(size(S_null));  % dS/dt = 0 when I = 0
I_null_i = N/gamma * (1 - gamma./(beta*S_null/N));  % dI/dt = 0
plot(S_null, I_null_s, 'k--', 'LineWidth', 1.5);
plot(S_null, I_null_i, 'k--', 'LineWidth', 1.5);

% ==============================
% 6. SENSITIVITY ANALYSIS
% ==============================
fprintf('\n=== SENSITIVITY ANALYSIS ===\n');

% Vary beta and gamma
beta_values = [0.2, 0.3, 0.4];
gamma_values = [0.05, 0.1, 0.15];

subplot(2,3,6);
colors = {'r-', 'g-', 'b-', 'm-', 'c-', 'k-'};
line_count = 1;

for i = 1:length(beta_values)
    for j = 1:length(gamma_values)
        [t_var, Y_var] = ode45(@(t,y) sir_odes(t, y, beta_values(i), ...
            gamma_values(j), N), tspan, [S0; I0; R0_initial]);
        I_var = Y_var(:,2);
        
        plot(t_var, I_var, colors{line_count}, 'LineWidth', 1.5);
        hold on;
        
        % Calculate R0 for this combination
        R0_var = beta_values(i)/gamma_values(j);
        fprintf('β=%.2f, γ=%.2f: R0=%.2f, Peak I=%.0f\n', ...
            beta_values(i), gamma_values(j), R0_var, max(I_var));
        
        line_count = line_count + 1;
        if line_count > length(colors)
            line_count = 1;
        end
    end
end

xlabel('Time (days)');
ylabel('Infected Population');
title('Sensitivity to Parameters');
legend('\beta=0.2,\gamma=0.05', '\beta=0.2,\gamma=0.1', '\beta=0.2,\gamma=0.15', ...
    '\beta=0.3,\gamma=0.05', '\beta=0.3,\gamma=0.1', '\beta=0.3,\gamma=0.15', ...
    'Location', 'best');
grid on;

% ==============================
% 7. REAL DATA COMPARISON (Optional - COVID-19 Example)
% ==============================
fprintf('\n=== REAL DATA SIMULATION ===\n');

% Example: COVID-19 parameters (approximate)
beta_covid = 0.25;
gamma_covid = 0.1;  % ~10 day infectious period
sigma_covid = 1/5.1;  % ~5.1 day incubation period

[t_covid, Y_covid] = ode45(@(t,y) seir_odes(t, y, beta_covid, ...
    sigma_covid, gamma_covid, N), [0 365], [S0; E0; I0; R0_initial]);

figure('Position', [100 100 800 600]);

% Plot with real data comparison (you would load actual data here)
subplot(2,1,1);
plot(t_covid, Y_covid(:,3), 'r-', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Active Infections');
title('SEIR Model for COVID-19-like Parameters');
grid on;

% Add hypothetical data points (in real project, use actual data)
% hypothetical_data = [0 1; 30 150; 60 450; 90 250; 120 100; 150 50; 180 30];
% hold on;
% plot(hypothetical_data(:,1), hypothetical_data(:,2), 'bo', 'MarkerSize', 8, 'LineWidth', 2);
% legend('Model Prediction', 'Actual Data', 'Location', 'best');

% Calculate key metrics
R0_covid = beta_covid/gamma_covid;
herd_immunity_threshold = 1 - 1/R0_covid;

fprintf('COVID-19 Simulation:\n');
fprintf('  R0 = %.2f\n', R0_covid);
fprintf('  Herd Immunity Threshold = %.1f%%\n', herd_immunity_threshold*100);
fprintf('  Peak Infections: Day %.0f with %.0f cases\n', ...
    t_covid(Y_covid(:,3) == max(Y_covid(:,3))), max(Y_covid(:,3)));

% ==============================
% 8. VACCINATION STRATEGY ANALYSIS
% ==============================
fprintf('\n=== VACCINATION STRATEGY ANALYSIS ===\n');

vaccination_rates = linspace(0, 0.8, 9);  % 0% to 80% vaccination
peak_infections = zeros(size(vaccination_rates));

for v = 1:length(vaccination_rates)
    S0_v = N*(1-vaccination_rates(v)) - I0;
    R0_v = N*vaccination_rates(v);
    [~, Y_v] = ode45(@(t,y) sir_odes(t, y, beta, gamma, N), ...
        tspan, [S0_v; I0; R0_v]);
    peak_infections(v) = max(Y_v(:,2));
end

subplot(2,1,2);
plot(vaccination_rates*100, peak_infections, 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Vaccination Rate (%)');
ylabel('Peak Infections');
title('Effect of Vaccination on Outbreak Severity');
grid on;

% Add herd immunity line
line([herd_immunity_threshold*100 herd_immunity_threshold*100], ...
    [0 max(peak_infections)], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
text(herd_immunity_threshold*100+5, max(peak_infections)*0.8, ...
    sprintf('Herd Immunity\nThreshold = %.1f%%', herd_immunity_threshold*100), ...
    'Color', 'r', 'FontSize', 10);

% ==============================
% CORRECTED ODE FUNCTIONS
% ==============================
function dydt = sir_odes(t, y, beta, gamma, N)
    % SIR model equations
    % y(1) = S, y(2) = I, y(3) = R
    
    S = y(1);
    I = y(2);
    
    dSdt = -beta * S * I / N;
    dIdt = beta * S * I / N - gamma * I;
    dRdt = gamma * I;
    
    dydt = [dSdt; dIdt; dRdt];
end

function dydt = seir_odes(t, y, beta, sigma, gamma, N)
    % SEIR model equations
    % y(1) = S, y(2) = E, y(3) = I, y(4) = R
    
    S = y(1);
    E = y(2);
    I = y(3);
    
    dSdt = -beta * S * I / N;
    dEdt = beta * S * I / N - sigma * E;
    dIdt = sigma * E - gamma * I;
    dRdt = gamma * I;
    
    dydt = [dSdt; dEdt; dIdt; dRdt];
end

function dydt = sir_vital_odes(t, y, beta, gamma, mu, N)
    % SIR with vital dynamics (births and deaths)
    % y(1) = S, y(2) = I, y(3) = R
    
    S = y(1);
    I = y(2);
    R = y(3);  % This line was missing!
    
    dSdt = mu * N - beta * S * I / N - mu * S;
    dIdt = beta * S * I / N - gamma * I - mu * I;
    dRdt = gamma * I - mu * R;  % Now R is defined
    
    dydt = [dSdt; dIdt; dRdt];
end

% ==============================
% SAVE RESULTS AND REPORT
% ==============================
fprintf('\n=== SIMULATION COMPLETE ===\n');
fprintf('\nKey Findings:\n');
fprintf('1. Basic SIR shows classic epidemic curve\n');
fprintf('2. SEIR adds realistic incubation period\n');
fprintf('3. R0 = %.2f determines outbreak severity\n', R0_basic);
fprintf('4. Herd immunity requires %.1f%% immunity\n', herd_immunity_threshold*100);
fprintf('5. Interventions significantly reduce peak load\n');

% Save figures
saveas(gcf, 'epidemic_model_results.png');
fprintf('\nResults saved as epidemic_model_results.png\n');