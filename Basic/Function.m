function A = circleArea(r)
    A = pi*r.^2;
end

a1 = circleArea(2)
a2 = circleArea(3)

%You can have multiple outputs:

function [area, circumference] = circleProps(r)
    area = pi*r.^2;
    circumference = 2*pi*r;
end

[a, c] = circleProps(3);


function testReturn(x)
    if x < 0
        disp('Negative value!');
        return   % just exits the function early
    end
    disp('Positive value');
end

testReturn(-1)
testReturn(19)


%Multiple Plots Using a Function

function y = myFunc(x)
    y = sin(x) + cos(0.5*x);
end

x = 0:0.1:2*pi;
plot(x, myFunc(x), 'r', 'LineWidth', 2); hold on
plot(x, myFunc(2*x), 'b--', 'LineWidth', 2);
hold off;                           % optional
legend('f(x)', 'f(2x)') %Adds labels for each plotted line.
grid on

%hold on → keeps the current plot so you can add more plots on top.
%hold off → restores default behavior (new plot overwrites old one).
