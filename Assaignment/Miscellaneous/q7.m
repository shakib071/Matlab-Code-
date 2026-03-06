fprintf('%15s %15s\n', 'Celsius', 'Fahrenheit');
fprintf('%s\n', repmat('-', 1, 30));


for C = 1:2:18
    F = (9/5 * C) + 32;
    fprintf('%15.1f %15.2f\n', C, F);
end
