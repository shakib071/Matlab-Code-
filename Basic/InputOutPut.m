%if ; at end then not print in command line 


%input a integer or float
x= input('Enter a number = ');
fprintf('input number x = %d\n',x);
fprintf('input number x = %f\n',x);
fprintf('input number x = %.2f\n',x); % 2 decimal

%string input
name = input('Enter your name: ','s');
%fprintf('welcome %d\n',name); %wrong for string
%disp(['welcome  ',name]);%Use a space when concatenating ..atleast 1
fprintf('Welcome %s\n', name);





%d	Integer (whole number)	fprintf('%d', 10.5)	10
%f	Floating-point (decimal)	fprintf('%.2f', 3.1416)	3.14
%s	String (text)	fprintf('%s', 'Shakib')	Shakib
%c	Single character	fprintf('%c', 65)	A
%e	Scientific notation	fprintf('%e', 1234.56)	1.234560e+03
%g	Shortest of %e or %f (auto format)	fprintf('%g', 0.00012)	0.00012
%u	Unsigned integer	fprintf('%u', 255)	255
%o	Octal (base 8)	fprintf('%o', 8)	10
%x	Hexadecimal (lowercase)	fprintf('%x', 255)	ff
%X	Hexadecimal (uppercase)	fprintf('%X', 255)	FF



% check the type of a variable using
class(name);
class(x);