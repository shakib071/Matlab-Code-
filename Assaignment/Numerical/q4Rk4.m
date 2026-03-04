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
    k2 = h*f(x(i-1)+(h/2),y(i-1)+(k1/2));
    k3 = h*f(x(i-1)+(h/2),y(i-1)+(k2/2));
    k4 = h*f(x(i-1)+h,y(i-1)+k3);
    k = (k1+2*k2+2*k3+k4)/6;
    y(i)=y(i-1) + k ;

end

disp('The RK-4 method solutions are : ')
for i=1:iter+1
    fprintf('At iteration = %d x = %0.2f y = %0.4f \n',i-1,x(i),y(i));
end

