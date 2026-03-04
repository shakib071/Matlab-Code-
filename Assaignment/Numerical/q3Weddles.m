f_str = input('Enter function (e.g x^2 + 1): ','s');
f = str2func(['@(x)' f_str]);
disp('Inter the Interval a and b and number of subinterval n : ');
a= input('a = ');
b= input('b = ');
n= input('n = ');


y = zeros(1,n+1);
x = zeros(1,n+1);

h = (b-a)./n;
x(1) = a;


for i=1:n+1
    y(i) = f(x(i));
    if(i~=(n+1))
        x(i+1) = x(i) + h;
    end
end

disp('The table is');
t = table(x',y','VariableNames',{'x','y'});
disp(t);



sum = y(1)+(5*y(2)) +y(3)+(6.*y(4))+y(5)+(5.*y(6))+y(7);
answer = (3.*h.*sum)./10;
fprintf(' Simpson 3/8 Rule integation approximation is = %0.4f',answer);
