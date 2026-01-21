% Select time points
t_points = [0 10 20 30 50];

% Interpolate S, R, B at these times
S_points = interp1(t, y(:,1), t_points);
R_points = interp1(t, y(:,2), t_points);
B_points = interp1(t, y(:,3), t_points);

% Create table
T = table(t_points', S_points', R_points', B_points', ...
    'VariableNames', {'Time','Sensitive','Resistant','Immune'})

% Display table
disp(T)
% Select time points
t_points = [0 10 20 30 50];

% Interpolate S, R, B at these times
S_points = interp1(t, y(:,1), t_points);
R_points = interp1(t, y(:,2), t_points);
B_points = interp1(t, y(:,3), t_points);

% Create table
T = table(t_points', S_points', R_points', B_points', ...
    'VariableNames', {'Time','Sensitive','Resistant','Immune'})

% Display table
disp(T)
