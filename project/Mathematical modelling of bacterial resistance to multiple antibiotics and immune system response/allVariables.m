clc; clear; close all

tspan = [0 90];
y0 = [0.8 0.1 0.3 1 1];
[t,y] = ode45(@model,tspan,y0);

figure
plot(t,y(:,1),'b','LineWidth',2)   % s
hold on
plot(t,y(:,2),'r','LineWidth',2)   % r
plot(t,y(:,3),'g','LineWidth',2)   % b
plot(t,y(:,4),'c','LineWidth',2)   % INH
plot(t,y(:,5),'m','LineWidth',2)   % ZPA

xlabel('Time (days)')
ylabel('Population / Concentration')
title('Time-Dependent Changes of All Variables')
legend('s','r','b','INH','ZPA')
grid on
