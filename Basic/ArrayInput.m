%A = input('Enter a row vector (e.g. [1 2 3 4]): ');
%disp(A)

%B = input('Enter a column vector (e.g. [1;2;3;4]): ');
%disp(B)


%M = input('Enter a 2x3 matrix (e.g. [1 2 3; 4 5 6]): ');
%disp(M)



%input using 
n = input('Enter the number of elements: ');
D = zeros(1,n); %[0,0,0,...n times]

for i = 1:n
    D(i) = input(['enter element',num2str(1),': ']);
end
%disp(D)

%Or
A = zeros(1,n);

for i = 1:n
    x=input('enter number : ');
    A(i) = x;
end

disp(A)


%2d

rows = input('Enter number of rows: ');
cols = input('Enter number of columns: ');
M = zeros(rows,cols);

for i = 1:rows
    for j = 1:cols
        M(i,j) = input(['Enter element (', num2str(i),',', num2str(j),'): ']);
    end
end

disp('Your matrix:');
disp(M)








