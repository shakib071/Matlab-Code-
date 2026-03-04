x = linspace(0, 4*pi, 100);
y = exp(-0.4*x) .* sin(x);

figure;
plot(x,y,'b','LineWidth',2);
xlabel('x');
ylabel('y');
legend('y = exp(-0.4*x)*sin(x)');
grid on;