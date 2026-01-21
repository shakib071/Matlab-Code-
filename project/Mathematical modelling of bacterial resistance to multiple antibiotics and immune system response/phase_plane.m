

tspan = [0 90];
y0 = [0.8 0.2 0.3 .2 .1];
[t,y] = ode45(@model,tspan,y0);

figure
plot(y(:,1),y(:,2),'b','LineWidth',2)
hold on
plot(y(1,1),y(1,2),'ks','MarkerFaceColor','k')    % start
plot(y(end,1),y(end,2),'ko','MarkerFaceColor','k') % end

xlabel('Sensitive Bacteria (s)')
ylabel('Resistant Bacteria (r)')
title('Phase Plane Diagram of Bacteria')
grid on
