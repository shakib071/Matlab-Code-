f_str = input('Enter function : eg(x^3+y^2) : ','s');
f = str2func(['@(x,y)' f_str]);

disp('Enter the value of initian value x0,y0 and step size h and iteration number ');
x0 = input('x0 = ');
y0 = input('y0 = ');
h = input('h = ');
iter = input('iteration = ');

x = zeros(1,iter + 1);
y = zeros(1,iter + 1);

x(1) = x0;
y(1) = y0;


for i=2:iter+1
    x(i) = x(i-1) + h;
    k1 = h*f(x(i-1),y(i-1));
    k2 = h*f(x(i-1)+h,y(i-1)+k1);
    y(i)=y(i-1) + 0.5*(k1+k2);

end

disp('The RK-2 method solutions are : ')
for i=1:iter+1
    fprintf('At iteration = %d x = %0.2f y = %0.4f \n',i-1,x(i),y(i));
end

