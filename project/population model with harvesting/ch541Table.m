%% =========================================================
%  TABLE 5.3 - Effect of Harvesting Rate a
%  Constant Harvesting vs Periodic Harvesting
%% =========================================================
clc; clear; close all;

k   = 0.20;
N   = 5;
P0  = 4.0;
b   = 1.0;
MSY = k*N/4;

opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

a_vals = [0.05, 0.10, 0.15, 0.21, 0.25, 0.30];
tspan  = [0 200];   % long window to reach steady state
t_eval = linspace(100, 200, 5000);  % sample only steady-state portion

% Preallocate
mean_c = zeros(size(a_vals));  min_c = zeros(size(a_vals));  max_c = zeros(size(a_vals));
mean_p = zeros(size(a_vals));  min_p = zeros(size(a_vals));  max_p = zeros(size(a_vals));
status_c = cell(size(a_vals));
status_p = cell(size(a_vals));

for i = 1:length(a_vals)
    ai = a_vals(i);

    %% --- Constant Harvesting ---
    ode_c = @(t,P) k*P*(1 - P/N) - ai;
    [~, PC] = ode45(ode_c, tspan, P0, opts);
    % Sample steady-state window
    [tc, Pc] = ode45(ode_c, t_eval, P0, opts);
    Pc_ss = Pc(tc >= 100);

    mean_c(i) = mean(Pc_ss);
    min_c(i)  = min(Pc_ss);
    max_c(i)  = max(Pc_ss);

    if mean_c(i) < 0.01
        status_c{i} = 'Extinction';
    elseif abs(ai - MSY) < 1e-9
        status_c{i} = 'MSY boundary';
    elseif ai > MSY
        status_c{i} = 'Extinction';
    else
        status_c{i} = 'Sustainable';
    end

    %% --- Periodic Harvesting ---
    ode_p = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));
    [tp, Pp] = ode45(ode_p, t_eval, P0, opts);
    Pp_ss = Pp(tp >= 100);

    mean_p(i) = mean(Pp_ss);
    min_p(i)  = min(Pp_ss);
    max_p(i)  = max(Pp_ss);

    if mean_p(i) < 0.01
        status_p{i} = 'Extinction';
    elseif abs(ai - MSY) < 1e-9
        status_p{i} = 'MSY boundary';
    elseif ai > MSY
        status_p{i} = 'Extinction';
    else
        status_p{i} = 'Sustainable';
    end
end

%% --- Display Table ---
fprintf('\nTable 5.3 — Effect of Harvesting Rate a\n');
fprintf('(k=%.2f, N=%d, b=%.1f, P0=%.1f, MSY=%.4f)\n\n', k, N, b, P0, MSY);

fprintf('%-6s | %-8s %-8s %-8s %-15s | %-8s %-8s %-8s %-15s\n', ...
    'a', ...
    'Mean_C', 'Min_C', 'Max_C', 'Status_C', ...
    'Mean_P', 'Min_P', 'Max_P', 'Status_P');
fprintf('%s\n', repmat('-', 1, 95));

for i = 1:length(a_vals)
    fprintf('%-6.2f | %-8.4f %-8.4f %-8.4f %-15s | %-8.4f %-8.4f %-8.4f %-15s\n', ...
        a_vals(i), ...
        mean_c(i), min_c(i), max_c(i), status_c{i}, ...
        mean_p(i), min_p(i), max_p(i), status_p{i});
end

%% --- Optional: Save as formatted table using writetable ---
T = table(a_vals', ...
    mean_c', min_c', max_c', status_c', ...
    mean_p', min_p', max_p', status_p', ...
    'VariableNames', { 'a', ...
    'Mean_Constant','Min_Constant','Max_Constant','Status_Constant', ...
    'Mean_Periodic','Min_Periodic','Max_Periodic','Status_Periodic'});

disp(' ');
disp(T);