disp('Enter coefficients for a1x + b1y = c1');
a1 = input('a1 = ');
b1 = input('b1 = ');
c1 = input('c1 = ');

disp('Enter coefficients for a2x + b2y = c2');
a2 = input('a2 = ');
b2 = input('b2 = ');
c2 = input('c2 = ');

A = [a1 b1; a2 b2];
B = [c1; c2];

if det(A) == 0
    disp('No unique solution exists!');
else
    X = A \ B;
    fprintf('x = %0.2f\n', X(1));
    fprintf('y = %0.2f\n', X(2));
end



