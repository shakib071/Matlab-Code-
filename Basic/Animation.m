x = 0:0.1:2*pi;
y = sin(x);

figure;
h=plot(x,y,'r','LineWidth',2);
ylim([-1.5,1.5]); %Sets the y-axis limits of the current axes.
% Ensures your plot stays within a fixed vertical range, which is important in animations so the axes don’t keep rescaling.
grid on;

for k=1:50
    y=sin(x + k*0.1);
    set(h,'YData',y); % update plot
    %'YData' → specifies the y-values of the plot.
    % set(h, 'YData', y) → updates the plot’s y-values without creating a new figure.
    drawnow; % refresh figure
    pause(0.05);  % pause 0.05s
end 

% drawnow → forces MATLAB to update the figure immediately.
% pause → controls speed of animation.