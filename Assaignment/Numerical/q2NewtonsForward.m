
n = input('How many data u want to input : ');
f = zeros(n);
x = zeros(1,n);

disp('Enter x and f(x) : ')
for i=1:n
    fprintf('For row %d ',i);
    x(i) = input('Enter x = ');
    fprintf('For row %d ',i);
    f(i,1) = input('Enter f(x) = ');
end



for i=2:n
    for j=1:n-i+1
        f(j,i) = f(j+1,i-1) - f(j,i-1); 
    end
end

intpoint = input('Enter the interpolation point : ');
h=x(2) - x(1);
u=(intpoint - x(1))./h;

disp('The interpolation table is : ');
disp(f);


answer = 0;
term = 1;

for i=1:n
    answer = answer + ((term * f(1,i))./ factorial(i-1));
    term = term .* (u-i+1);
end

fprintf('Newtons forward difference interpolation at interpolation Point = %0.2f is %0.3f ',intpoint,answer);








