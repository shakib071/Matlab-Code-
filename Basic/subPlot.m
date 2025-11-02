x = 0:0.1:2*pi;

subplot(3,2,1,'align') %Align the subplots’ axes horizontally and vertically
plot(x,sin(x))
title('sin(x)')

subplot(3,2,2)
plot(x,cos(x))
title('cos(x)')

subplot(3,2,3)
plot(x,cos(2*x))
title('cos(2x)')

subplot(3,2,4)
plot(x,cos(3*x))
title('cos(3x)')

subplot(3,2,5)
plot(x,cos(4*x))
title('cos(4x)')

subplot(3,2,6)
plot(x,cos(5*x))
title('cos(5x)')

%subplot(m, n, p)
%m → number of rows
%n → number of columns
%p → position number (counted left-to-right, top-to-bottom)