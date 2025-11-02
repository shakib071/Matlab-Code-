x = 0:0.1:2*pi;
y=sin(x);

plot(x,y)
title('sine wave')
xlabel('x (rad)')
ylabel('sin(x)')
grid on % shows grid line (horizontal and vertical grid lines)

%grid on	Turn grid on
%grid off	Turn grid off
%grid minor	Add smaller, lighter grid lines (minor ticks)

