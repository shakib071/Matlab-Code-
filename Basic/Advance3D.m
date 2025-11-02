[X, Y] = meshgrid(-2:0.1:2, -2:0.1:2);
Z = X.^2 + Y.^2;

figure;
mesh(X,Y,Z);
xlabel('X'),ylabel('Y'),zlabel('Z');
title('3D Mesh plot');
grid on;


figure;
surf(X, Y, Z);
shading interp;      % smooth color transitions
colorbar;            % display color scale
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Surface Plot');


figure;
contour(X, Y, Z, 20); % 20 contour levels
colorbar;
title('2D Contour Plot');

figure;
contour3(X, Y, Z, 20); % 3D contour lines
title('3D Contour Plot');

% contour → top-down view (2D)
% contour3 → 3D lines


figure;
surfc(X, Y, Z);
title('Surface + Contour Plot');

% 3D Scatter
x = rand(1, 30);
y = rand(1, 30);
z = rand(1, 30);
figure; scatter3(x, y, z, 60, z, 'filled');

%scatter3(x, y, z, 10);  % small points
%scatter3(x, y, z, 100); % large points
%scatter3(x, y, z, 60, z);  % colors according to z
colorbar;                  % shows the color scale


% 3D Line
t = 0:0.1:10;
figure; plot3(sin(t), cos(t), t, 'LineWidth', 2);
grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Line Plot');



%1️⃣ Specialized 2D Plots
% area – stacked area plots
% barh – horizontal bar chart
% pie / pie3 – 2D and 3D pie charts
% stem / stairs – discrete data visualization
% histogram – histogram plots
% errorbar – data with error bars
% polarplot – polar coordinates plot
% compass – directional vectors in polar coordinates
% rose – circular histogram (angles)
% 2️⃣ Specialized 3D Plots
% meshc – mesh + contour combined
% surfl – surface with lighting effect
% ribbon – 3D ribbon plot
% waterfall – 3D waterfall (already mentioned briefly)
% slice – slice 3D volumetric data
% contourf – filled contour plots
% sphere, cylinder, ellipsoid – plotting geometric 3D shapes
% 3️⃣ Vector Field Plots
% quiver – 2D vector field
% quiver3 – 3D vector field
% 4️⃣ Other Useful Plotting Functions
% plotmatrix – scatter plots for matrix pairs (correlation analysis)
% scatterhist – scatter plot with histograms
% spy – visualize sparsity of matrices
% imagesc / imshow – display images or matrices as color maps
% heatmap – grid-based heatmaps
% 
% ✅ Summary
% We have covered: plot, subplot, hold on/off, scatter3, mesh, surf, contour, contour3, surfc, waterfall, bar, barh, pie, stairs, stem, polarplot, quiver, quiver3.
% Missing specialized or advanced plots: area, errorbar, ribbon, slice, surfl, plotmatrix, spy, heatmap, etc.
