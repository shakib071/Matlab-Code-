% 6.9 Sensitivity Analysis — Effect of ±20% parameter change on A and B

% Base parameters
beta_S  = 0.8;
beta_R  = 0.4;
eta     = 0.3;
alpha1  = 0.02;
alpha2  = 0.06;
d1      = 0.15;
d2      = 0.35;

% Base A and B
sum_ad = (alpha1 + d1) + (alpha2 + d2);
A_base = (beta_S - sum_ad) / (beta_S + eta);
B_base = beta_R / (beta_R + eta);

fprintf('Base A = %.4f,  Base B = %.4f\n\n', A_base, B_base);

% Parameters to vary
param_names = {'beta\_S','beta\_R','eta','alpha1','alpha2','d1','d2'};
base_vals   = [beta_S, beta_R, eta, alpha1, alpha2, d1, d2];

% Storage
A_plus  = zeros(length(base_vals),1);
A_minus = zeros(length(base_vals),1);
B_plus  = zeros(length(base_vals),1);
B_minus = zeros(length(base_vals),1);

for i = 1:length(base_vals)
    vals_p = base_vals;
    vals_m = base_vals;
    vals_p(i) = base_vals(i) * 1.20;
    vals_m(i) = base_vals(i) * 0.80;

    for sign = 1:2
        if sign == 1, v = vals_p; else, v = vals_m; end

        bS  = v(1); bR = v(2); et = v(3);
        a1  = v(4); a2 = v(5); dd1 = v(6); dd2 = v(7);

        sum_ad_v = (a1+dd1) + (a2+dd2);
        A_v = (bS - sum_ad_v) / (bS + et);
        B_v =  bR / (bR + et);

        if sign == 1
            A_plus(i)  = A_v;
            B_plus(i)  = B_v;
        else
            A_minus(i) = A_v;
            B_minus(i) = B_v;
        end
    end
end

% Build table
T = table(param_names', ...
    round(repmat(A_base,7,1),4), ...
    round(A_plus,4),  round(A_minus,4), ...
    round(repmat(B_base,7,1),4), ...
    round(B_plus,4),  round(B_minus,4), ...
    'VariableNames', ...
    {'Parameter','A_base','A_plus20','A_minus20', ...
                  'B_base','B_plus20','B_minus20'});

disp(T)