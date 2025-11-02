[X, Y] = meshgrid(-2:0.1:2, -2:0.1:2);
Z = X.^2 + Y.^2;
%surf(X,Y,Z) % 3D Surface Plot
%mesh(X,Y,Z) %3D wirefreame
plot3(X,Y,Z) %3D curve
title('3D suface plot')
xlabel('X'),ylabel('Y'),zlabel('Z')
saveas(gcf, 'plot1.png')    % save current figure


% [X, Y] = meshgrid(x, y)
% You give it two 1D vectors (x and y)
% It returns two 2D matrices — one for all X coordinates, one for all Y coordinates

%Category	Command	Description
%2D	plot	Line plot
%2D	scatter	Points
%2D	bar / barh	Bars
%2D	histogram	Frequency
%2D	area	Filled curve
%2D	contour	Level lines
%3D	plot3	3D line
%3D	mesh	Wireframe surface
%3D	surf	Colored surface
%3D	contour3	3D contour lines
%3D	scatter3	3D points
%3D	quiver	Vector field
%3D	bar3	3D bars

%check the pdf 

%| Command                       | Description            |
%| ----------------------------- | ---------------------- |
%| `xlabel('text')`              | Label x-axis           |
%| `ylabel('text')`              | Label y-axis           |
%| `zlabel('text')`              | Label z-axis           |
%| `title('text')`               | Add title              |
%| `legend('name1','name2',...)` | Add legend             |
%| `grid on`                     | Show grid              |
%| `axis equal`                  | Equal scaling on axes  |
%| `colorbar`                    | Add color scale        |
%| `hold on/off`                 | Combine multiple plots |

