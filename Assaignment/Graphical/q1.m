t  = linspace(0, 2*pi, 100);
x  = sin(t);
y  = cos(t);
y2 = t.^2;

figure;

subplot(2, 1, 1);
plot(x, y, 'b', 'LineWidth', 2);
xlabel('t');
ylabel('x = sin(t) , y = cos(t)');
title('Circle');
legend('x=sin(t), y=cos(t)');
grid on;
axis equal;

subplot(2, 1, 2);
plot(t, y2, 'r', 'LineWidth', 2);
xlabel('t');
ylabel('y = t^2');
title('Parabola');
legend('y = t^2');
grid on;
