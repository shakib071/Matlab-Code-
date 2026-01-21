
R0 = 3;
mu = 0.2;
h = 0.5;
theta = 0.6;
tau = 1;

theta_range = linspace(0,1,100);
tau_range = linspace(0.5,10,100);
R0_range = linspace(1,5,100);
mu_range = linspace(0.01,1,100);
h_range = linspace(0.1,5,100);

% Example R* and R*
R_star_theta = R0*(1-theta_range).*exp(-mu*h)./(1-(1-theta_range).*exp(-mu*tau));
R_star_tau = R0*(1-theta)*exp(-mu*h)./(1-(1-theta).*exp(-mu*tau_range));
R_star_R0 = R0_range*(1-theta)*exp(-mu*h)./(1-(1-theta).*exp(-mu*tau));
R_star_mu = R0*(1-theta)*exp(-mu_range*h)./(1-(1-theta).*exp(-mu_range*tau));
R_star_h = R0*(1-theta)*exp(-mu*h_range)./(1-(1-theta).*exp(-mu*tau));

figure

subplot(3,2,1)
plot(theta_range, R_star_theta, 'LineWidth',2)
xlabel('\theta'), ylabel('R^*')
title('R^* vs \theta')
grid on

subplot(3,2,2)
plot(tau_range, R_star_tau, 'LineWidth',2)
xlabel('\tau'), ylabel('R^*')
title('R^* vs \tau')
grid on

subplot(3,2,3)
plot(R0_range, R_star_R0, 'LineWidth',2)
xlabel('R_0'), ylabel('R^*')
title('R^* vs R_0')
grid on

subplot(3,2,4)
plot(mu_range, R_star_mu, 'LineWidth',2)
xlabel('\mu'), ylabel('R^*')
title('R^* vs \mu')
grid on

subplot(3,2,5)
plot(h_range, R_star_h, 'LineWidth',2)
xlabel('h'), ylabel('R^*')
title('R^* vs h')
grid on
