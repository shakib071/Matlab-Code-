t = linspace(0, 20, 1000);
x = sin(t);
y = cos(t);
z = t;

figure;
plot3(x,y,z,'b','LineWidth',2);
xlabel('x = sin(t)');
ylabel('y = cos(t)');
zlabel('z = t');
title('Circular Helix');
legend('Helix: x=sin(t), y=cos(t), z=t');
grid on;