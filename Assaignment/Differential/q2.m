
f = @(x,y) [y(2);3*y(2) - 2*y(1)];
y0    = [1; 0];
xspan = [0 1];

[x,y] = ode45(f,xspan,y0);

figure;
plot(x, y(:,1), 'b', 'LineWidth', 2);
hold on;
plot(x, y(:,2), 'r', 'LineWidth', 2);
xlabel('x');
ylabel('y');

legend('y(x)', 'dy/dx');
grid on;