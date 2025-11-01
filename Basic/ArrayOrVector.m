%Row Vector
A=[1 2 3 4 5 6];
A(1); %1

%Column Vector 

B = [1;2;3;4;5;6]
B(3) % 3

%Creating Matrices // 2d vetor 
M = [1 2 3;4 5 6;7 8 9]
M(2,2)%5
M(3,2)%8

%Using Range Operator (:)

v1 = 1:5        % 1 2 3 4 5
v2 = 1:2:9      % start:step:end → 1 3 5 7 9
v3 = 10:-2:2    % 10 8 6 4 2

%zeros(m,n)	m×n matrix of 0s	zeros(2,3)
%ones(m,n)	m×n matrix of 1s	ones(3,2)
%eye(n)	n×n identity matrix	eye(3)
%rand(m,n)	random numbers (0–1)	rand(2,2)
%linspace(a,b,n)	n equally spaced values from a to b	linspace(0,10,5) → [0 2.5 5 7.5 10]

%linspace(10,20) %default step is 0.001
linspace(10,20,11) % it means 11 values between 10 to 20 .. equal space


AAAA = rand(3,3,2); % 3×3×2 array



%Changing Elements
A(3)=10;
M(2,2) = 0;


%Numeric array	Most common (numbers)	[1 2 3; 4 5 6]
%Character array (char)	Text as array of characters	'Shakib'
%Cell array (cell)	Can hold mixed data types	{1, 'Hi', [2 3 4]}
%Struct array (struct)	Holds named fields	person.name = 'Shakib'; person.age = 22;
%String array (string)	Modern text type	["Hi" "Hello"]

%A1 = [1 2 3 4];         % all numeric → OK
%A2 = ['a' 'b' 'c'];     % all char → OK
%A3 = [1 'a' 3];         %  ERROR → mixed numeric and char not allowed




%store different kinds of data

C = {1, 'Shakib', [2 3 4], true};

%C{2}     % returns 'Shakib'
%C{3}(2)  % returns 3 (second element of that vector)


% array input 

A5 = input('Enter a row vector (e.g. [1 2 3 4]): ');
disp(A5)

B5 = input('Enter a column vector (e.g. [1;2;3;4]): ');
disp(B5)

M5 = input('Enter a 2x3 matrix (e.g. [1 2 3; 4 5 6]): ');
disp(M5)


