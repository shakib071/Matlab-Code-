n = input('Enter number of equations: ');
A = zeros(n,n+1);

disp('Enter the augmented matrix [A|b] row by row:');

for i=1:n
    for j=1:n+1
        A(i,j) = input(sprintf('A(%d,%d) = ',i,j));
    end
end

disp('Matrix After Input: ');
disp(A);


for k=1:n-1
    for i=k+1:n
        factor = A(i,k) / A(k,k);
        A(i,:) = A(i,:) - factor*A(k,:);
    end
end

disp('Matrix After Elimination: ');
disp(A);


x = zeros(n,1);
x(n) = A(n,n+1)/A(n,n);

for i=n-1:-1:1
    x(i) = (A(i,n+1) - A(i,i+1:n)*x(i+1:n))/ A(i,i);
end

disp('Gaussian Elimination solution without pivoting is :');
for i = 1:n
    fprintf('x%d = %.4f\n', i, x(i));
end
