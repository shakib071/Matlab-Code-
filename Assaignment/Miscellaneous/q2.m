
x = [-3.5, 5, -6.2, 11.1, 0, 7, -9.5, 2, 15, -1, 3, 2.5];

disp('Original x:'); 
fprintf('%0.1f ',x);
fprintf('\n');
n = length(x);
for i = 1:n-1
    for j = 1:n-i
        if x(j) > x(j+1)
            temp    = x(j);
            x(j)    = x(j+1);
            x(j+1)  = temp;
        end
    end
end

disp('Sorted x :'); 
fprintf('%0.1f ',x);
fprintf('\n');
