%% Table 5.3 - Effect of a on Periodic Harvesting
k   = 0.20;
N   = 5;
P0  = 4.0;
b   = 1.0;
MSY = k*N/4;

opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'NonNegative',1);

a_vals = [0.05, 0.10, 0.15, 0.21, 0.25, 0.30];

fprintf('================================================================\n');
fprintf('Table 5.3 — Effect of Harvesting Rate a on Periodic Harvesting\n');
fprintf('(k=%.2f, N=%d, b=%.1f, P0=%.1f)\n', k, N, b, P0);
fprintf('================================================================\n');
fprintf('%-8s %-12s %-12s %-12s %-15s\n', ...
        'a', 'Mean P', 'Min P', 'Max P', 'Status');
fprintf('%s\n', repmat('-',1,62));

for i = 1:length(a_vals)
    ai    = a_vals(i);
    ode_p = @(t,P) k*P*(1 - P/N) - ai*(1 + sin(b*t));

    [tt, PP] = ode45(ode_p, [0 100], P0, opts);

    % use last 20 time units only
    idx  = tt >= 80;
    PP_s = PP(idx);

    mean_P = mean(PP_s);
    min_P  = min(PP_s);
    max_P  = max(PP_s);

    % determine status
    if mean_P < 0.01
        status = 'Extinction';
    elseif ai > MSY
        status = 'Declining';
    elseif ai == MSY
        status = 'MSY boundary';
    else
        status = 'Sustainable';
    end

    fprintf('%-8.2f %-12.4f %-12.4f %-12.4f %-15s\n', ...
            ai, mean_P, min_P, max_P, status);
end
fprintf('%s\n', repmat('=',1,62));
fprintf('MSY = kN/4 = %.4f\n', MSY);