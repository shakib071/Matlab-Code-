[X,Y] = meshgrid(-5:0.5:5);
Z = sin(sqrt(X.^2 + Y.^2));
mesh(X,Y,Z)
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Mesh plot')

[X, Y] = meshgrid(-5:0.5:5);
Z = sin(sqrt(X.^2 + Y.^2));

surfc(X, Y, Z)
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Surface + Contour plot');
colorbar