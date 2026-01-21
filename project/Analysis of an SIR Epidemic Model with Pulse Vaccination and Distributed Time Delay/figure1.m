
R0 = 3;
mu = 0.2;
h = 0.5;
theta = 0.6;
tau = 1;

% ranges
p_range = linspace(0,1,100); % vaccination
tau_range = linspace(0.5,10,100);
R0_range = linspace(1,5,100);
mu_range = linspace(0.01,1,100);

%  function R*
R_star_p = R0*(1 - p_range).*exp(-mu*h)./(1 - (1-p_range).*exp(-mu*tau));
R_star_tau = R0*(1 - theta).*exp(-mu*h)./(1 - (1-theta).*exp(-mu*tau_range));
R_star_R0 = R0_range.*(1 - theta).*exp(-mu*h)./(1 - (1-theta).*exp(-mu*tau)); % <-- fixed
R_star_mu = R0*(1 - theta).*exp(-mu_range*h)./(1 - (1-theta).*exp(-mu_range*tau));

figure

subplot(2,2,1)
plot(p_range, R_star_p,'LineWidth',2)
ylabel('R^*')
xlabel('Vaccination \theta')
title('R^* vs \theta')
grid on

subplot(2,2,2)
plot(tau_range, R_star_tau,'LineWidth',2)
ylabel('R^*')
xlabel('Pulse period \tau')
title('R^* vs \tau')
grid on

subplot(2,2,3)
plot(R0_range, R_star_R0,'LineWidth',2)
ylabel('R^*')
xlabel('Basic reproduction R_0')
title('R^* vs R_0')
grid on

subplot(2,2,4)
plot(mu_range, R_star_mu,'LineWidth',2)
ylabel('R^*')
xlabel('Natural death \mu')
title('R^* vs \mu')
grid on
