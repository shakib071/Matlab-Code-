

% Solve ODE
tspan = [0 90];

s = 0.8; %sensitive bacteria
r = 0.05; %resistant bacteria
b = 0.05; %immune cells
a1 = 0.05;  % INH
a2 = 0.02;  % ZPA

% For INH (antibiotic 1)
params.alpha1 = 0.02;    % Mutation rate due to INH
params.d1 = 0.15;         % Death rate due to INH
    
% For ZPA (antibiotic 2)
params.alpha2 = 0.06;    % Mutation rate due to ZPA
params.d2 = 0.35;         % Death rate due to ZPA

y0 = [s  r  b  a1  a2];
[t,y] = ode45(@(t,y) model(t,y,params), tspan, y0);

% Plot
figure
plot(t, y(:,1)+y(:,2),'b','LineWidth',2)   % s+r
hold on
plot(t, y(:,3),'g','LineWidth',2)          % b

xlabel('Time (days)')
ylabel('Bacteria and Immune Cells')
title('Time-Dependent Changes of Bacteria and Immune Cells')
legend('s+r','b')
grid on
