
tspan = [0 90];

s = 0.8; %sensitive bacteria
r = 0.07; %resistant bacteria
b = 0.05; %immune cells
a1 = 0.05;  % INH
a2 = 0.02;  % ZPA

% For INH (antibiotic 1)
params.alpha1 = 0.06;    % Mutation rate due to INH
params.d1 = 0.35;         % Death rate due to INH
    
% For ZPA (antibiotic 2)
params.alpha2 = 0.02;    % Mutation rate due to ZPA
params.d2 = 0.15;         % Death rate due to ZPA

y0 = [s  r  b  a1  a2];
[t,y] = ode45(@(t,y) model(t,y,params), tspan, y0);


s  = y(:,1);
r  = y(:,2);
b  = y(:,3);
a1 = y(:,4);
a2 = y(:,5);

% Plot 
figure;
hold on; grid on; box on;

plot(t,s,'b','LineWidth',2)
plot(t,r,'g','LineWidth',2)
plot(t,b,'r','LineWidth',2)
plot(t,a1,'c','LineWidth',2)
plot(t,a2,'m','LineWidth',2)

xlabel('Time (days)','FontSize',12)
ylabel('Bacteria, Immune cells and Antibiotics','FontSize',12)
title('In case B<A Time-dependent changes of all variables','FontSize',13)

legend('s','r','b','INH','ZPA','Location','best')
ylim([-0.2 1.05])
xlim([0 90])