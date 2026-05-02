% 6.10 Summary Table
findings = {
    '6.3 Case I (A<B)',        'A=0.20, B=0.57', 'E2 = (0, 0.57, 0.57, 1, 1)', 'Sensitive bacteria eliminated. Resistant bacteria and immune cells coexist.';
    '6.4 Case II (A>B)',       'A=0.33, B=0.25', 'E3 = (0.33, 0.00, 0.33, 1, 1)', 'All three populations persist. Infection not cleared.';
    '6.5 Immune Strength',     'eta: 0.1 to 1.0', 'Lower equilibrium as eta increases', 'Stronger immune system reduces bacterial burden significantly.';
    '6.6 Fitness Cost',        'c: 0.1 to 0.9',  'Resistant bacteria decrease as c increases', 'High fitness cost limits resistant strain dominance.';
    '6.7 Early Termination',   'Stop at day 30, 60, 90', 'Rebound increases the earlier treatment stops', 'Full course essential. Early stopping causes bacterial resurgence.';
    '6.8 Combination Therapy', 'INH only, PZA only, Both', 'Combination clears sensitive bacteria fastest', 'Two drugs together outperform either drug alone.';
    '6.9 Sensitivity',         'Each param varied ±20%', 'beta_S, eta, d1, d2 most critical', 'Drug killing rate and immune strength are the key clinical levers.';
};

T_summary = cell2table(findings, ...
    'VariableNames', {'Section','Parameters','Equilibrium_Outcome','Biological_Conclusion'});

disp(T_summary)