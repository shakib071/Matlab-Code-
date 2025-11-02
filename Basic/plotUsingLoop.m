% y=sin(kx)for k=1,2,3

x = 0:0.1:2*pi;
k_values = 1:3;  % different sine frequencies
colors = ['r','g','b']; % line colors

figure; hold on;

%figure opens a new figure window in MATLAB.
%If you don’t use figure, MATLAB will draw plots in the current figure, overwriting existing plots.
%hold on tells MATLAB:
  %“Keep all the existing plots in this figure, and add new plots on top.”

for idx = 1:length(k_values)
    k=k_values(idx);
    y=sin(k*x);
    plot(x,y,colors(idx),'LineWidth',2);
end

xlabel('x'); ylabel('y');
title('Multiple Sine Waves using Loop');
legend('sin(x)', 'sin(2x)', 'sin(3x)');
grid on;
hold off;