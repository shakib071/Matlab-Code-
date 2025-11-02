

x = 0:0.1:2*pi;
y = sin(x);
plot(x, y, 'r', 'LineWidth', 2);
xlabel('x'); ylabel('sin(x)');
title('Sine Wave');
grid on;
