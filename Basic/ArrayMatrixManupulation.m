%need matrix of same size
A = [1 2 3];
B = [4 5 6];

%Addition / Subtraction
C = A + B;    % [5 7 9]
D = A - B;   % [-3 -3 -3]

%Element-wise Multiplication / Division

E = A .* B;   % [4 10 18]
F = B ./ A ;  % [4 2.5 2]

%Element-wise Power
G = A .^ 2;  % [1 4 9]


%* → matrix multiplication
%.* → element-wise multiplication

%matrix multiplication
M1 = [1 2; 3 4];
M2 = [5 6; 7 8];
R = M1 * M2;

%Use * only if inner dimensions match (m×n * n×p)


%Transpose and Inverse
A1 = [1 2 3; 4 5 6];
A1_T = A1';      % Transpose

%Matrix inverse:
M = [1 2; 3 4];
M_inv = inv(M);  % inverse of M
fprintf('%.1f %.1f\n', M_inv');   % transpose to print row-wise



%Operation	Syntax	Example
%Sum of elements	sum(A)	sum([1 2 3]) → 6
%Product	prod(A)	prod([1 2 3 4]) → 24
%Maximum / Minimum	max(A), min(A)	max([5 2 9]) → 9
%Mean / Median	mean(A), median(A)	mean([1 2 3 4]) → 2.5
%Sort	sort(A)	sort([3 1 2]) → [1 2 3]
%Size / Length	size(M), length(A)	size([1 2;3 4]) → [2 2]




%Reshaping & Indexing

X1 = 1:6;               % [1 2 3 4 5 6]
X2 = reshape(X1,2,3);   % 2x3 matrix

%X2 =
%    1     3     5
%    2     4     6



% Logical Indexing

X3 = [10 20 30 40 50];
X4 = X3(X3>21); %[30 40 50]




