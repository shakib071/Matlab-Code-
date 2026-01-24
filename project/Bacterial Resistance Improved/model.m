function dydt = model(t, y , params)

    s = y(1); %sensitive bacteria
    r = y(2); %resistant bacteria
    b = y(3); %immune cells
    a1 = y(4);  % INH
    a2 = y(5);  % ZPA
    
    % PARAMETERS 

    beta_S = 1.1;     % Growth rate of sensitive bacteria
    beta_R = 0.9;     % Growth rate of resistant bacteria (with fitness cost)
  
    eta = 0.6;        % Immune killing rate 
    k = 0.4;          % Immune cell proliferation rate
    
    % For INH (antibiotic 1)
    alpha1 = params.alpha1;    % Mutation rate due to INH
    d1 = params.d1;         % Death rate due to INH
    
    % For ZPA (antibiotic 2)
    alpha2 = params.alpha2;    % Mutation rate due to ZPA
    d2 = params.d2;         % Death rate due to ZPA
    
    mu1 = 0.08;        % Clearance rate for INH
    mu2 = 0.04;       % Clearance rate for ZPA


    
    % DE
    total_bac = s + r; % Total bacteria
    
    % Sensitive bacteria 
    % ds/dt = β_S * s * (1 - s - r) - η * s * b - s * Σ(α_i + d_i)*a_i

    growth_s = beta_S * s * (1 - total_bac);
    immune_kill_s = eta * s * b;
    antibiotic_effect_s = s * ((alpha1 + d1) * a1 + (alpha2 + d2) * a2);
    
    ds = growth_s - immune_kill_s - antibiotic_effect_s;
    
    % Resistant bacteria 
    % dr/dt = β_R * r * (1 - s - r) - η * r * b + s * Σ(α_i)*a_i

    growth_r = beta_R * r * (1 - total_bac);
    immune_kill_r = eta * r * b;
    mutation_gain = s * (alpha1 * a1 + alpha2 * a2);
    
    dr = growth_r - immune_kill_r + mutation_gain;
    
    % Immune cells 
    % db/dt = k * b * (1 - b/(s + r))

   
    db = k * b * (1 - b / total_bac);
  
    
    % Antibiotic concentrations
    % da_i/dt = μ_i * (1 - a_i)

    da1 = mu1 * (1 - a1);
    da2 = mu2 * (1 - a2);
    
    % OUTPUT
    dydt = [ds; dr; db; da1; da2];
end