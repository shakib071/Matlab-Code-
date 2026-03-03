
t=linspace(-10,10,1000);
y1=t.*sin(t);
y2=(t-1).*(t+1);
y3=sin(t.^2)./t.^2;


subplot(3,1,1)
plot(t,y1)
xlabel('X-Axis')
ylabel('Y-Axis')
title('tsin(t)')
subplot(3,1,2)
plot(t,y2)
xlabel('X-Axis')
ylabel('Y-Axis')
title('(t-1)/(t+1)')
subplot(3,1,3)
plot(t,y3)
xlabel('X-Axis')
ylabel('Y-Axis')
title('sin(t^2)/t^2')