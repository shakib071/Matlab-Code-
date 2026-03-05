A = [1 2 3; 4 5 6; 7 8 9];
B = [9 8 7; 6 5 4; 3 2 1];



add = A + B;
sub = A - B;
mul = A * B;


d = det(A);

disp('Addition of A and B :'); disp(add);
disp('Subtraction of A and B is : '); disp(sub);
disp('multiplication of A and B is : '); disp(mul);
disp('Determiant A is : '); disp(d);


R = rref(A); %reduced row ecelon form

disp('Row ecelon form of A is : '); disp(R);
fprintf('rank of A = %d\n', rank(A));



if d == 0
    disp('Matrix is singular .. No inverse Exists');
else
    A_inv = inv(A);
    disp('Inverse of A is : ');
    disp(A_inv);
    disp('Determination of inverse of A is : '); disp(det(A_inv));
end

[eigenvectors,eigenvalues] = eig(A);

disp('Eigen Values of A is : '); disp(diag(eigenvalues));
disp('Eigen Vectors of A is : '); disp(eigenvectors);

p = poly(A);
disp('Charecteristics Polynomial of A is : '); disp(poly2str(p,'lamda'));

n = length(p);
result = zeros(size(A));


for k = 1:n
    result = result + p(k) * A^(n-k);
    
end



if all(all(round(result)==0))
    disp('Cayley-Hamilton Theorem varified .');
else
    disp('Cayley-Hamilton Theorem not varified .');
end



if det(eigenvectors) == 0
    disp('Matrix is not diagonalizable');
else 
    diagonalization = round(eigenvectors * eigenvalues * (inv(eigenvectors)));
    disp('Diagonalization of A is : '); disp(diagonalization);
end





