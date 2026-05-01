function dydt = model(t, y, params)

    s  = y(1);  % Sensitive bacteria (normalized)
    r  = y(2);  % Resistant bacteria (normalized)
    b  = y(3);  % Immune cells (normalized)
    a1 = y(4);  % INH concentration (normalized)
    a2 = y(5);  % PZA concentration (normalized)

    % Unpack all parameters from struct
    beta_S = params.beta_S;
    beta_R = params.beta_R;
    eta    = params.eta;
    k      = params.k;
    alpha1 = params.alpha1;
    alpha2 = params.alpha2;
    d1     = params.d1;
    d2     = params.d2;
    mu1    = params.mu1;
    mu2    = params.mu2;

    % Total bacteria
    total_bac = s + r;

    % Sensitive bacteria
    % ds/dt = β_S * s * (1 - s - r) - η * s * b - s * Σ(α_i + d_i)*a_i
    growth_s          = beta_S * s * (1 - total_bac);
    immune_kill_s     = eta * s * b;
    antibiotic_effect = s * ((alpha1 + d1) * a1 + (alpha2 + d2) * a2);

    ds = growth_s - immune_kill_s - antibiotic_effect;

    % Resistant bacteria
    % dr/dt = β_R * r * (1 - s - r) - η * r * b + s * Σ(α_i)*a_i
    growth_r      = beta_R * r * (1 - total_bac);
    immune_kill_r = eta * r * b;
    mutation_gain = s * (alpha1 * a1 + alpha2 * a2);

    dr = growth_r - immune_kill_r + mutation_gain;

    % Immune cells
    % db/dt = k * b * (1 - b/(s + r))
    if total_bac > 1e-12
        db = k * b * (1 - b / total_bac);
    else
        db = -k * b;
    end

    % Antibiotic concentrations
    % da_i/dt = μ_i * (1 - a_i)
    da1 = mu1 * (1 - a1);
    da2 = mu2 * (1 - a2);

    dydt = [ds; dr; db; da1; da2];
end