x = linspace(0, 10, 3);

A = [1 2 0;2 9 3;1 5 6]; 

z = A*sqrt(x');

disp('Solution for Matrix A is : ');
disp(z);

A1 = sin(x);
disp('Solution for Matrix A = sin(x) is : ');
y = A1 * sqrt(x');
disp(y);