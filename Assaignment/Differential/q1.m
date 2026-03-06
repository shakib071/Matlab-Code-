w = input('Enter value of w: ');
f = @(t,y) [y(2); -w^2 * sin((y(1)))];

y0 = [1;0];
tspan = [0,20];

[t,y] = ode45(f,tspan,y0);

displacement = y(:,1);
velocity = y(:,2);

figure;
plot(t,velocity,'b','LineWidth',2);
hold on;
plot(t,displacement,'r','LineWidth',2);
xlabel('t');
ylabel('value');
legend('Displacement','Velocity');
grid on;



