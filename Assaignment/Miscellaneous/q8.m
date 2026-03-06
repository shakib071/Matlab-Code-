
principal = 1000;
rate      = 0.06 / 4; 
quarters  = 5 * 4; 

fprintf('%10s %15s %15s %15s\n', 'Year', 'Quarter', 'Interest', 'Balance');
fprintf('%s\n', repmat('-', 1, 65));

balance = principal;

for q = 1:quarters
    interest = balance * rate;
    balance  = balance + interest;
    year     = ceil(q/4);    

    fprintf('%10d %15d %15.2f %15.2f\n', year, q, interest, balance);
end

fprintf('Final balance after 5 years = $%0.2f\n', balance);
fprintf('Total interest earned       = $%0.2f\n', balance - principal);