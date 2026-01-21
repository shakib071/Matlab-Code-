

% Solve ODE
tspan = [0 90];
y0 = [0.8 0.1 0.3 1 1];
[t,y] = ode45(@model,tspan,y0);

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
