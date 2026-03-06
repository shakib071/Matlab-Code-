balance     = 300000;
interest    = 0.05;
withdrawal  = 25000;
inflation   = 0.02;

years       = 0;
balances    = balance;
withdrawals = 0;

fprintf('%10s %15s %15s\n', 'Year', 'Withdrawal', 'Balance');
fprintf('%s\n', repmat('-', 1, 40));
fprintf('%10d %15.2f %15.2f\n', 0, 0, balance);

while balance > 0
    years = years + 1;

    
    balance = balance * (1 + interest);
    if balance <= withdrawal
        fprintf('\n%10d %15.2f %15.2f\n', years, balance, 0);
        fprintf('Money runs out after %d years .\n', years);
        balances    = [balances, 0];
        withdrawals = [withdrawals, balance];
        break;
    end
    
    balance    = balance - withdrawal;
    balances   = [balances,   balance];
    withdrawals= [withdrawals, withdrawal];

    fprintf('%10d %15.2f %15.2f\n', years, withdrawal, balance);

    
    withdrawal = withdrawal * (1 + inflation);
end

figure;
year_axis = 0:years;

yyaxis left;
bar(year_axis, balances, 'b');
ylabel('Account Balance ($)');

yyaxis right;
plot(1:years, withdrawals(2:end), 'r-o', 'LineWidth', 2);
ylabel('Annual Withdrawal ($)');

xlabel('Year');
title('Retirement Account Balance and Withdrawals');
legend('Balance', 'Withdrawal');
grid on;
