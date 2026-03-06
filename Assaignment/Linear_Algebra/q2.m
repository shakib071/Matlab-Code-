%217 page

disp('Task 6.1:');
A = [1 -1; 0 3];
B = [-2 1; 4 -2];
AB = A * B;
disp('AB ='); disp(AB);

disp('Task 6.2:');
r = 1:4;
M = [r; zeros(1,4); zeros(1,4); zeros(1,4)];
M(:,4) = flipud(r');
disp(M);

disp('Task 6.3:');
A = diag(ones(1,9), 1) + diag(-ones(1,9), -1);
disp(A);


disp('Task 6.3:');
A = diag(ones(1,9), 1) + diag(-ones(1,9), -1);
disp(A);

disp('Task 6.4:');
A = ones(3);
B = 2*ones(3,2);
C = 3*ones(2,3);
disp([A B]);        
disp([A C']);       
disp([A; C]);

disp('Task 6.5:');
disp([1 2; 3 4] + [3 4; -1 2]);
disp([3 5; -1 0; 2 -4] + [6 -2; 2 1; 0 0]);
disp([1 3 5] * [2 -1; -1 0; 7 -2]);

disp('Task 6.6:');
a=2; b=3; c=1; d=4;
alpha=5; beta=2;
A = [a b; c d];
B = [alpha beta; beta alpha];
disp('AB ='); disp(A*B);
disp('BA ='); disp(B*A);

disp('Task 6.7:');
A = [1 2 3; 4 5 6; 7 8 9];
B = A + A';   
C = A - A';   
disp('B = A+AT (symmetric):');    disp(B);
disp('C = A-AT (anti-symmetric):'); disp(C);

if isequal(B, B')
    disp('B is Symmetric');
else 
    disp('B is not Symmetric');
end

if isequal(C, -C')
    disp('C is anti-Symmetric');
else 
    disp('B is not anti-Symmetric');
end


disp('Task 6.8:');
for theta = [0, pi/2, pi]
    A = [cos(theta) sin(theta); -sin(theta) cos(theta)];
    fprintf('theta = %.4f\n', theta);
    disp(round(A));
    disp('Inverse:'); disp(round(inv(A)));
end

disp('Task 6.9:');
A = [3 4; -1 2];
b = [2; 0];
x = A\b;
fprintf('x = %0.4f, y = %0.4f\n', x(1), x(2));

disp('Task 6.10:');
A = [1 1 2; 1 -1 -3; -2 -5 1];
b = [1; 0; 4];
x = A\b;
fprintf('x=%.4f, y=%.4f, z=%.4f\n', x(1), x(2), x(3));

disp('Task 6.11:');
A = [1 -1; 0 2; 3 2]; 
B = [2 -1; -1 0; 3 2]; 
C = [-1 0; 2 1];
disp('A+B ='); disp(A+B);
disp('AC = '); disp(A*C);
disp('CB'' = '); disp(C*B');
disp('(A-B)C = '); disp((A-B)*C);
disp('AC - BC = '); disp(A*C-B*C);

disp('Task 6.12:');
disp([1 -1 2;3 0 1] * [3; 2; -1]);
disp([5 -2; -1 2] * [4 0 1 -1; 2 1 -2 -1]);

disp('Task 6.13:');
syms a b c d
A = [a b; c d];
I = eye(2);
disp(A*I);   
disp(I*A);  

disp('Task 6.14:');
A = [3 2 -1; 0 -1 -2];
disp('AAT ='); disp(A*A');
disp('ATA ='); disp(A'*A);

disp('Task 6.15:');
x = [1 2 3 4];
disp('xxT ='); disp(x*x'); disp('Which is positive ..'); 

disp('Task 6.16:');
A = [1 4; -2 3];
b = [1; -2];
x = A\b;
disp('1x + 4y =  1   ... (1)');
disp('-2x + 3y = -2   ... (2)');
fprintf('x=%.4f, y=%.4f\n', x(1), x(2));
A2 = [1 1 1; 1 -2 -1; -1 3 -1];
b2 = [0; 2; -1];
x2 = A2\b2;
disp('[ 1  1  1][x]   [ 0]');
disp('[ 1 -2 -1][y] = [ 2]');
disp('[-1  3 -1][z]   [-1]');
fprintf('x=%.4f, y=%.4f, z=%.4f\n', x2(1), x2(2), x2(3));


disp('TASK 6.17 :');

disp('--- System 1 ---');
disp('3x + 2y = 7');
disp('3x - 2y = 7');
A1 = [3  2;
      3 -2];
b1 = [7; 7];
d1 = det(A1);
fprintf('det(A1) = %.4f\n', d1);

if d1 ~= 0
    disp('→ Unique solution exists');
    x1 = A1\b1;
    fprintf('x = %.4f\n', x1(1));
    fprintf('y = %.4f\n', x1(2));
else
    Aug1 = [A1 b1];
    if rank(A1) == rank(Aug1)
        disp('→ Infinite solutions');
    else
        disp('→ No solution');
    end
end

disp('--- System 2 ---');
disp('x + y + z = 1');
disp('x + y - z = 0');
disp('x + y     = 0');

A2 = [1 1  1;
      1 1 -1;
      1 1  0];
b2 = [1; 0; 0];

d2 = det(A2);
fprintf('det(A2) = %.4f\n', d2);
Aug2 = [A2 b2];

fprintf('rank(A2)     = %d\n', rank(A2));
fprintf('rank([A2|b2])= %d\n', rank(Aug2));

if d2 ~= 0
    disp('→ Unique solution');
    x2 = A2\b2;
    disp(x2);
elseif rank(A2) == rank(Aug2)
    disp('→ Infinite solutions');
else
    disp('→ No solution exists');
end

disp('--- System 3 ---');
A3 = [ 1  1  1  1  1  1;
       1 -1  1  1  1  1;
       1  1 -1  1  1  1;
       1  1  1 -1  1  1;
       1  1  1  1 -1  1;
       1  1  1  1  1 -1];
b3 = [1;1;1;1;1;1];

d3 = det(A3);
fprintf('det(A3) = %.4f\n', d3);
Aug3 = [A3 b3];

fprintf('rank(A3)     = %d\n', rank(A3));
fprintf('rank([A3|b3])= %d\n', rank(Aug3));

if d3 ~= 0
    disp('→ Unique solution');
    x3 = A3\b3;
    disp(x3);
elseif rank(A3) == rank(Aug3)
    disp('→ Infinite solutions');
else
    disp('→ No solution exists');
end

disp('Task 6.18:');
A = [1 0 0 -1; -1 2 -1 0; 0 -1 2 -1; 0 0 0 1];
b1 = [0;0;0;1];
b2 = [1;0;0;0];
x1 = A\b1;
x2 = A\b2;
disp('Solution 1:'); disp(x1');
disp('Solution 2:'); disp(x2');


disp('Task 6.19:');
s_vals = -5:0.1:5;
d_vals = zeros(size(s_vals));

for i = 1:length(s_vals)
    s = s_vals(i);
    M = [0 1 s; s 0 1; 1 s 0];
    d_vals(i) = det(M);
end

coeffs = polyfit(s_vals, d_vals, 3);
disp('Cubic polynomial:');
disp(poly2str(coeffs, 's'));

r = roots(coeffs);
disp('Singular values of s:');
disp(r);


disp('Task 6.20:');
B = [0 1; -1 0];
for n = 1:4
    fprintf('B^%d =\n', n);
    disp(B^n);
end
disp('And so on (similar)');

disp('Task 6.21:');
A = [1 0 0 -1; 0 1 0 0; 0 0 1 0; -1 0 0 1];
eigenvals = eig(A);
disp('Eigenvalues:'); disp(eigenvals);

disp('Task 6.22:');
A = [4 1; 2 3];
[P, D] = eig(A);
n = 3;
LHS = A^n;
RHS = round(P * D^n * inv(P));
disp('A^3 =');           disp(LHS);
disp('PD^3P^-1 =');      disp(RHS);

if isequal(LHS,RHS) == true
    disp('A^n is equal P * D^n * inv(P)');
else 
    disp('A^n is not equal P * D^n * inv(P)');
end


disp('Task 6.23:');
A = [1 0 0 -1; 0 1 0 0; 0 0 1 0; -1 0 0 1];
p = poly(A);
disp('Characteristic polynomial:');
disp(poly2str(p, 'lambda'));
r = roots(p);
disp('Roots (eigenvalues):'); disp(r);

disp('Task 6.24:');
A  = [2 -1; -1 1];
x0 = [1; -1];
f  = @(t, x) A*x;
[t, x] = ode45(f, [0 5], x0);
T = table(t, x(:,1), x(:,2), 'VariableNames', {'t', 'x1', 'x2'});
disp(T);



