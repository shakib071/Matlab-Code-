
figure;
hold on;
x1 = linspace(0, 4*pi, 10);
y1 = exp(-0.4*x1) .* sin(x1);
plot(x1,y1,'b','LineWidth',2);

x2 = linspace(0, 4*pi, 50);
y2 = exp(-0.4*x2) .* sin(x2);
plot(x2,y2,'r','LineWidth',2);

x3 = linspace(0, 4*pi, 100);
y3 = exp(-0.4*x3) .* sin(x3);
plot(x1,y1,'g','LineWidth',2);

xlabel('x');
ylabel('y');
title('y = exp(-0.4*x)*sin(x)');
legend('10 points', '50 points', '100 points');
grid on;